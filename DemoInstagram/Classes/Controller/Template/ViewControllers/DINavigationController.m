//
//  DINavigationController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/15/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DINavigationController.h"

@interface DINavigationController ()

@end

@implementation DINavigationController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup {
    self.navigationBar.barTintColor = [UIColor diRedColor];
    self.navigationBar.tintColor = [UIColor diWhiteColor];
    [self.navigationBar setTranslucent: NO];
    [self.navigationBar setTitleTextAttributes:[[UIColor diWhiteColor] colorAttribute]];
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
