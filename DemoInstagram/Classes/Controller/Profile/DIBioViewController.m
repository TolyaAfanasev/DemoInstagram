//
//  DIBioViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//


#import "DIBioViewController.h"
#import "DIProfileInfoProtocol.h"
#import "DIUserModel.h"

@interface DIBioViewController ()<DIProfileInfoProtocol>
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;

//DIProfileInfoProtocol
@property (strong, nonatomic) DIUserModel *user;


@end

@implementation DIBioViewController

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
    self.bioLabel.text = self.user.bio;
    self.websiteLabel.text = self.user.website;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 30.0;
    
    if (indexPath.section == 0) {
        CGFloat bioHeigt = [self.user.bio getHeightWithFont:self.bioLabel.font
                                        constrainedForWidth:tableView.bounds.size.width - 16] + 2;
        if (bioHeigt > height) {
            height = bioHeigt;
        }
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

@end