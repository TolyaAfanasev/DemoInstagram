//
//  DIPostListViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIPostListViewController.h"
#import "DIMediaApiClient.h"
#import "DIMediaModel.h"
#import "DIPostTableViewCell.h"
#import "DIProfileInfoProtocol.h"
#import "DIUserModel.h"
#import "DIUuidPaginationObject.h"
#import "DIPaginationModel.h"
#import "UITableView+DICommonCells.h"
#import "DILoadingTableViewCell.h"
#import "DIPostDetailViewController.h"

@interface DIPostListViewController ()<UITableViewDataSource, UITableViewDelegate, DIProfileInfoProtocol, DIPostTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DIUserModel *user;
@property (assign, nonatomic) DILoadDataState dataState;
@property (copy, nonatomic) MediaListSuccessBlock mediaListSuccessBlock;
@property (copy, nonatomic) Failure failure;
@property (strong, nonatomic) DIUuidPaginationObject *paginationObject;
@end

@implementation DIPostListViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)setup {
    [self registerNibs];
    [self loadData];
}

- (void)registerNibs {
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([DIPostTableViewCell class]) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass([DIPostTableViewCell class])];
}

#pragma mark - Data

- (void)loadData {
    self.paginationObject = [[DIUuidPaginationObject alloc] init];
    self.paginationObject.list = [NSMutableArray new];
    
    @weakify(self);
    self.paginationObject.onPaginationLoadingBlock = ^(){
        @strongify(self);
        
        if (self.user) {
            self.paginationObject.uuid = self.user.idKey;
            [[DIMediaApiClient client] userMedia:self.paginationObject
                                         success:self.mediaListSuccessBlock
                                         failure:self.failure];
        } else {
            [[DIMediaApiClient client] myMedia:self.mediaListSuccessBlock
                                       failure:self.failure];
        }
    };
    
    self.paginationObject.onPaginationLoadingBlock();
}

- (MediaListSuccessBlock)mediaListSuccessBlock {
    if (!_mediaListSuccessBlock) {
        @weakify(self);
        _mediaListSuccessBlock = ^(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination){
            @strongify(self);
            self.paginationObject.nextUrl = pagination.next;
            [self.paginationObject.list addObjectsFromArray:list];
            self.paginationObject.lowThanStep = pagination.next ? NO : YES;
            self.dataState = DILoadDataStateComplete;
            [self.table reloadData];
        };
    }
    return _mediaListSuccessBlock;
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRowsInSection = self.paginationObject.list.count > 0
    ? self.paginationObject.lowThanStep
    ? self.paginationObject.list.count
    : self.paginationObject.list.count  + 1
    : 1;
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (self.paginationObject.list.count > 0) {
        if (indexPath.row < self.paginationObject.list.count) {
            DIPostTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DIPostTableViewCell class])];
            postCell.model = self.paginationObject.list[indexPath.row];
            postCell.delegate = self;
            cell = postCell;
        } else {
            if (self.paginationObject
                && !self.paginationObject.lowThanStep) {
                DILoadingTableViewCell *loadingView = (DILoadingTableViewCell *)[tableView dequeueUFLoadingCell];
                
                @weakify(self);
                loadingView.onShowLoadingBlock = (^(DILoadingTableViewCell *view){
                    @strongify(self);
                    if (self.paginationObject) {
                        self.paginationObject.onPaginationLoadingBlock();
                    }
                });
                
                loadingView.onShowLoadingBlock(loadingView);
                cell = loadingView;
            }
        }
    } else {
        switch (self.dataState) {
            case DILoadDataStateInProcess: cell = [tableView dequeueUFLoadingCell]; break;
            case DILoadDataStateComplete:
            case DILoadDataStateNoData: cell = [tableView dequeueUFCommonNoResultCell]; break;
            case DILoadDataStateConnectionError: cell = [tableView dequeueUFNoConnectionCell]; break;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRowAtIndexPath = 0.0f;
    
    if (self.paginationObject.list.count > 0) {
        if (indexPath.row < self.paginationObject.list.count) {
            heightForRowAtIndexPath = [DIPostTableViewCell cellHeight:self.paginationObject.list[indexPath.row]
                                                                width:[UIScreen mainScreen].bounds.size.width];
        } else {
            heightForRowAtIndexPath = 44.0f;
        }
    } else {
        heightForRowAtIndexPath = tableView.bounds.size.height;
    }
    
    return heightForRowAtIndexPath;
}

#pragma mark - DIPostTableViewCellDelegate

- (void)postTableViewCellDidSelectComments:(DIPostTableViewCell *)cell {
    DIPostDetailViewController *vc = [[DIPostDetailViewController alloc] initWithNibName:@"DIPostDetailViewController" bundle:nil];
    vc.post = self.paginationObject.list[[self.table indexPathForCell:cell].row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end