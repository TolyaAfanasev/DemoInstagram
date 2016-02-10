//
//  DIFollowingViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIFollowingViewController.h"
#import "DIUserApiClient.h"
#import "DIFollowTableViewCell.h"
#import "DIFollowingUserModel.h"
#import "DIProfileViewController.h"

static NSString *const kProfileSegue = @"profile";

@interface DIFollowingViewController ()<UITableViewDataSource, UITableViewDelegate, DIFollowTableViewCellDelegate>
@property (strong, nonatomic) NSArray<DIFollowingUserModel *> *list;
@end

@implementation DIFollowingViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    [self registerNibs];
    [self loadData];
}

- (void)registerNibs {
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([DIFollowTableViewCell class]) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass([DIFollowTableViewCell class])];
}

#pragma mark - Data

- (void)loadData {
    @weakify(self);
    [[DIUserApiClient client] following:^(NSArray<DIFollowingUserModel *> *list) {
        @strongify(self);
        self.list = list;
        [self.table reloadData];
    } failure:^(id error) {
        @strongify(self);
        self.list = nil;
        [self.table reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DIFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DIFollowTableViewCell class])];
    cell.user = self.list[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kProfileSegue sender:self.list[indexPath.row]];
}

#pragma mark - DIFollowTableViewCellDelegate 

- (void)followTableViewCellAddClick:(DIFollowTableViewCell *)cell {
    NSIndexPath *path = [self.table indexPathForCell:cell];
    DIFollowingUserModel *user = self.list[path.row];
    
    @weakify(self);
    [[DIUserApiClient client]follow:user success:^{
        @strongify(self);
        user.isFollowedByMe = YES;
        [self.table reloadData];
    } failure:^(id error) {
    }];
}

- (void)followTableViewCellRemoveClick:(DIFollowTableViewCell *)cell {
    NSIndexPath *path = [self.table indexPathForCell:cell];
    DIFollowingUserModel *user = self.list[path.row];
    
    @weakify(self);
    [[DIUserApiClient client]unfollow:user success:^{
        @strongify(self);
        user.isFollowedByMe = NO;
        [self.table reloadData];
    } failure:^(id error) {
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kProfileSegue]) {
        DIProfileViewController *vc = segue.destinationViewController;
        vc.user = sender;
    }
}
@end