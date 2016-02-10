//
//  DIFollowersViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIFollowersViewController.h"
#import "DIUserApiClient.h"
#import "DIBaseFollowTableViewCell.h"
#import "DIProfileViewController.h"

static NSString *const kProfileSegue = @"profile";

@interface DIFollowersViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray<DIUserModel *> *list;
@end

@implementation DIFollowersViewController

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
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([DIBaseFollowTableViewCell class]) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass([DIBaseFollowTableViewCell class])];
}

#pragma mark - Data

- (void)loadData {
    @weakify(self);
    [[DIUserApiClient client] followers:^(NSArray<DIUserModel *> *list) {
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
    DIBaseFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DIBaseFollowTableViewCell class])];
    cell.user = self.list[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kProfileSegue sender:self.list[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kProfileSegue]) {
        DIProfileViewController *vc = segue.destinationViewController;
        vc.user = sender;
    }
}

@end