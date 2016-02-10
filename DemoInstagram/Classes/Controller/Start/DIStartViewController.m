//
//  DIStartViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/15/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIStartViewController.h"
#import "DICoreDateHelper.h"

static NSString *const kLoginSegue = @"toLoginSegue";
static NSString *const kProfileSegue = @"toProfileSegue";

@interface DIStartViewController ()

@end

@implementation DIStartViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            [self presentProfile];
        } else {
            [self presentLogin];
        }
    }];
}

#pragma mark - Present View Controller

- (void)presentLogin {
    [self performSegueWithIdentifier:kLoginSegue sender:nil];
}

- (void)presentProfile {
    [self performSegueWithIdentifier:kProfileSegue sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
