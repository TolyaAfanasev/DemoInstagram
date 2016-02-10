//
//  DIMainViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIMainViewController.h"
#import "DIUserApiClient.h"
#import "DICoreDateHelper.h"
#import "DIUserModel.h"

static NSString *const kPostCollectionSegue = @"postCollection";
static NSString *const kPostListSegue = @"postList";
static NSString *const kGeoSegue = @"geo";

@interface DIMainViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navigationBarButtons;
//DIContainerSegueProtocol
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIViewController *oldViewController;
@property (weak, nonatomic) UIViewController *destinationViewController;
@property (strong, nonatomic) NSMutableDictionary *viewControllersByIdentifier;
@end

@implementation DIMainViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    [self presentViewControllerWithIndex:0];
    
    [[NSOperationQueue new] addOperationWithBlock:^{
        [[DIUserApiClient client] me:^(DIUserModel *user) {
            [DICoreDateHelper saveUserUuid:user.idKey];
        } failure:nil];
    }];
}

#pragma mark - Custom Getters

- (NSMutableDictionary *)viewControllersByIdentifier {
    if (!_viewControllersByIdentifier) {
        _viewControllersByIdentifier = [NSMutableDictionary dictionary];
    }
    return _viewControllersByIdentifier;
}

#pragma mark - IBActions

- (IBAction)profileSegmentedButtonSelected:(UIButton *)sender {
    [self.navigationBarButtons enumerateObjectsUsingBlock:^(UIButton *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != [self.navigationBarButtons indexOfObject:sender]) {
            obj.selected = NO;
        }
    }];
    
    [self presentViewControllerWithIndex:[self.navigationBarButtons indexOfObject:sender]];
}

#pragma mark - Common

- (void)presentViewControllerWithIndex:(NSInteger)index {
    UIButton *button = self.navigationBarButtons[index];
    button.selected = YES;
    
    NSString *segueName = nil;

    switch (index) {
        case 0: segueName = kPostListSegue; break;
        case 1: segueName = kPostCollectionSegue; break;
        case 2: segueName = kGeoSegue; break;
    }
    
    [self performSegueWithIdentifier:segueName
                              sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kPostCollectionSegue]) {
        [self prepareForPostCollectionSegue:segue sender:sender];
    } else if ([segue.identifier isEqualToString:kPostListSegue]) {
        [self prepareForPostListSegue:segue sender:sender];
    } else if ([segue.identifier isEqualToString:kGeoSegue]) {
        [self prepareForGeoSegue:segue sender:sender];
    }
}

- (void)prepareForPostListSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self switchViewController:segue.destinationViewController
                withIdentifier:segue.identifier];
}

- (void)prepareForPostCollectionSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self switchViewController:segue.destinationViewController
                withIdentifier:segue.identifier];
}

- (void)prepareForGeoSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self switchViewController:segue.destinationViewController
                withIdentifier:segue.identifier];
}

- (void)switchViewController:(UIViewController *)viewController
              withIdentifier:(NSString *)identifier {
    self.oldViewController = self.destinationViewController;
    
    if (!self.viewControllersByIdentifier[identifier]) {
        self.viewControllersByIdentifier[identifier] = viewController;
    }
    
    self.destinationViewController = self.viewControllersByIdentifier[identifier];
}


@end
