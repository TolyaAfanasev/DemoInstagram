//
//  ViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/12/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIAuthorizationViewController.h"
#import "DIButton.h"

static NSString *const kProfileSegue = @"toProfileSegue";
static NSString *const kInstClientId = @"5e9a25b6b32c4c399b4ddf0c2cbe9f60";

@interface DIAuthorizationViewController ()
@end

@implementation DIAuthorizationViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Setup

- (void)setup {
    self.view.backgroundColor = [UIColor diRedColor];
}

#pragma mark - Public

- (void)loginPerform {
    [self performSegueWithIdentifier:kProfileSegue sender:nil];
}

#pragma mark - IBActions

- (IBAction)signInClick:(DIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=%@&scope=likes+comments+relationships+basic",
                     kInstClientId,
                     kRedirectUrl,
                     @"token"];
    
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
