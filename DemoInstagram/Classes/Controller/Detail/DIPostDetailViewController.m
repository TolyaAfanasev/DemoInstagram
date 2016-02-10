//
//  DIPostDetailViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/17/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIPostDetailViewController.h"
#import "DIPostTableViewCell.h"
#import "DIMediaModel.h"
#import "DICommentApiClient.h"
#import "DICommentModel.h"
#import "DILoadingTableViewCell.h"
#import "DICommentCell.h"
#import "UITableView+DICommonCells.h"
#import "DIUserModel.h"
#import "DICoreDateHelper.h"

@interface DIPostDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomPanelBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *postCommentButton;
@property (weak, nonatomic) IBOutlet UITextField *postCommentTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomPanel;
@property (strong, nonatomic) RACSignal *signal;

@property (strong, nonatomic) NSString *userUuid;
@property (strong, nonatomic) NSMutableArray <DICommentModel *> *list;
@property (copy, nonatomic) CommentListSuccessBlock commentListSuccessBlock;
@property (copy, nonatomic) Failure failure;
@property (assign, nonatomic) DILoadDataState dataState;
@end

@implementation DIPostDetailViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    [self setupUI];
    [self registerForKeyboardNotifications];
    [self registerNibs];
    [self data];
}

- (void)setupUI {
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 44.0;
    self.table.allowsMultipleSelectionDuringEditing = NO;
    
    self.bottomPanel.backgroundColor = [UIColor diBgLightGrayColor];
    [self.postCommentButton setTitleColor:[UIColor diWhiteColor] forState:UIControlStateNormal];
    self.postCommentButton.backgroundColor = [UIColor diRedColor];
    RAC(self.postCommentButton, enabled) = self.signal;
}

#pragma mark - Nibs

- (void)registerNibs {
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([DIPostTableViewCell class]) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass([DIPostTableViewCell class])];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([DICommentCell class]) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass([DICommentCell class])];
}

#pragma mark - Data

- (void)data {
    @weakify(self);
    [DICoreDateHelper getUserUuid:^(NSString *uuid) {
        @strongify(self);
        self.userUuid = uuid;
        
        [[DICommentApiClient client] getComments:self.post.idKey
                                         success:self.commentListSuccessBlock
                                         failure:self.failure];
    }];
    
}

#pragma mark - Custom Getters

- (CommentListSuccessBlock)commentListSuccessBlock {
    if (!_commentListSuccessBlock) {
        @weakify(self);
        _commentListSuccessBlock = ^(NSArray<DICommentModel *> *list){
            @strongify(self);
            self.dataState = DILoadDataStateComplete;
            self.list = [NSMutableArray arrayWithArray:list];
            [self.table reloadData];
        };
    }
    return _commentListSuccessBlock;
}

- (Failure)failure {
    if (!_failure) {
        @weakify(self);
        _failure = ^(id error) {
            @strongify(self);
            self.dataState = DILoadDataStateConnectionError;
            [self.table reloadData];
        };

    }
    return _failure;
}

- (RACSignal *)signal {
    if (!_signal) {
        NSArray *combineLatestList = @[[RACSignal merge:@[self.postCommentTextField.rac_textSignal,
                                                          RACObserve(self.postCommentTextField, text)]]];
        _signal = [RACSignal combineLatest:combineLatestList
                                       reduce:^id(NSString *text){
                                           return @(text.length > 0);
                                       }];
    }
    return _signal;
}

#pragma mark - IBActions

- (IBAction)postButtonClick:(id)sender {
    [[DICommentApiClient client] postComment:self.post.idKey
                                        text:self.postCommentTextField.text
                                     success:^{
                                     } failure:^(id error) {
                                     }];
}

#pragma mark - UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL can = NO;
    
    if (indexPath.section != 0
        && self.list.count > 0
        && self.userUuid) {
        DICommentModel *comment = self.list[indexPath.row];
        can = [comment.from.idKey isEqualToString:self.userUuid];
    }
    
    return can;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section != 0
            && self.list.count > 0) {
            DICommentModel *comment = self.list[indexPath.row];
            
            [[DICommentApiClient client] deleteComment:comment.idKey
                                                  post:self.post.idKey
                                               success:^{
                                                   [self.table beginUpdates];
                                                   [self.list removeObject:comment];
                                                   [self.table deleteRowsAtIndexPaths:@[indexPath]
                                                                     withRowAnimation:UITableViewRowAnimationFade];
                                                   [self.table endUpdates];
                                        
                                               } failure:[DIErrorHandler apiErrorHandler]];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRowsInSection = 1;
    if (section == 1) {
        numberOfRowsInSection = self.list.count > 0 ? self.list.count : 1;
    }
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    if (indexPath.section == 0) {
        DIPostTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DIPostTableViewCell class])];
        postCell.model = self.post;
        postCell.mode = DIPostTableViewCellModeDetail;
        cell = postCell;
    } else {
        if (self.list.count > 0) {
            DICommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DICommentCell class])];
            commentCell.comment = self.list[indexPath.row];
            commentCell.editing = YES;
            cell = commentCell;
        } else {
            switch (self.dataState) {
                case DILoadDataStateInProcess: cell = [tableView dequeueUFLoadingCell]; break;
                case DILoadDataStateComplete: cell = [tableView dequeueUFCommonNoResultCell]; break;
                case DILoadDataStateNoData:
                case DILoadDataStateConnectionError: cell = [tableView dequeueUFNoConnectionCell]; break;
            }
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[DIPostTableViewCell class]]) {
        DIPostTableViewCell *postCell = (DIPostTableViewCell *)cell;
        [postCell willDisplayCell];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if ([cell isKindOfClass:[DIPostTableViewCell class]]) {
        DIPostTableViewCell *postCell = (DIPostTableViewCell *)cell;
        [postCell didEndDisplayingCell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRowAtIndexPath = 0.0f;
    
    if (indexPath.section == 0) {
            heightForRowAtIndexPath = [DIPostTableViewCell cellHeight:self.post
                                                                width:tableView.bounds.size.width];
    } else {
        heightForRowAtIndexPath = UITableViewAutomaticDimension;
    }
    
    return heightForRowAtIndexPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.postCommentTextField resignFirstResponder];
}

#pragma mark - Keyboard

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardDidChangeFrame:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomPanelBottomConstraint.constant = [UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y;
    [self.view layoutIfNeeded];
}

@end