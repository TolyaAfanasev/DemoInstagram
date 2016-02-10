//
//  DIProfileViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/15/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIProfileViewController.h"
#import "AppDelegate.h"
#import "DIProfileView.h"
#import <Masonry/Masonry.h>
#import "DIUserApiClient.h"
#import "DIUserModel.h"
#import "DICustomSegmentedView.h"
#import "DIContainerSegueProtocol.h"
#import "DIProfileInfoProtocol.h"
#import "DICoreDateHelper.h"
#import "DIBarButtonItem.h"

typedef void(^SuccessUserBlock)(DIUserModel *user);

static NSString *const kFollowersSegue = @"followers";
static NSString *const kFollowingSegue = @"following";

static NSString *const kBioSegue = @"bioSegue";
static NSString *const kPostCollectionSegue = @"postCollection";
static NSString *const kPostListSegue = @"postList";
static NSString *const kGeoSegue = @"geo";

@interface DIProfileViewController ()<DIProfileViewDelegate, DICustomSegmentedViewDelegate, DIContainerSegueProtocol>
@property (weak, nonatomic) IBOutlet UIView *profileContainerView;
@property (weak, nonatomic) IBOutlet DICustomSegmentedView *customSegmentedView;
@property (strong, nonatomic) DIProfileView *profileView;
@property (copy, nonatomic) SuccessUserBlock successUserBlock;
@property (weak, nonatomic) IBOutlet DIBarButtonItem *signoutButton;

//DIContainerSegueProtocol
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIViewController *oldViewController;
@property (weak, nonatomic) UIViewController *destinationViewController;
@property (strong, nonatomic) NSMutableDictionary *viewControllersByIdentifier;
@end

@implementation DIProfileViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    self.profileView = [[[NSBundle mainBundle] loadNibNamed:@"DIProfileView" owner:self options:nil] firstObject];
    self.profileView.delegate = self;
    [self.profileContainerView addSubview:self.profileView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.profileContainerView).with.insets(padding);
    }];
    
    self.customSegmentedView.delegate = self;
    [self loadData];
}

- (void)fillUI {
    self.profileView.user = self.user;
    self.navigationItem.title = self.user.full_name;
    if (!self.user.isIAm) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - Data

- (void)loadData {
    if (self.user) {
        [[DIUserApiClient client] user:self.user.idKey
                               success:self.successUserBlock failure:^(id error) {
                               }];
    } else {
        [[DIUserApiClient client] me:^(DIUserModel *user) {
            self.successUserBlock(user);
            [DICoreDateHelper saveUserUuid:user.idKey];
        } failure:^(id error) {
        }];
    }
}

- (SuccessUserBlock)successUserBlock{
    if (!_successUserBlock) {
        @weakify(self);
        _successUserBlock = ^(DIUserModel *userModel) {
            @strongify(self);
            
            userModel.isIAm = !self.user;
            
            self.user = userModel;
            [self fillUI];
            [self performSegueWithIdentifier:kPostCollectionSegue sender:nil];
        };
    }
    return _successUserBlock;
}


#pragma mark - IBActions

- (IBAction)doneClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signOutClick:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate signout];
}

#pragma mark - DIProfileViewDelegate

- (void)profileViewSelectedFollowers:(DIProfileView *)profileView {
    [self performSegueWithIdentifier:kFollowersSegue sender:nil];
}

- (void)profileViewSelectedFollowing:(DIProfileView *)profileView {
    [self performSegueWithIdentifier:kFollowingSegue sender:nil];
}

#pragma mark - DICustomSegmentedViewDelegate

- (void)customSegmentedView:(DICustomSegmentedView *)segmentedView
           didSelectedIndex:(NSInteger)index {
    switch (index) {
        case 0: [self performSegueWithIdentifier:kPostCollectionSegue sender:nil]; break;
        case 1: [self performSegueWithIdentifier:kPostListSegue sender:nil]; break;
        case 2: [self performSegueWithIdentifier:kGeoSegue sender:nil]; break;
        case 3: [self performSegueWithIdentifier:kBioSegue sender:nil]; break;
    }
}

#pragma mark - Custom Getters

- (NSMutableDictionary *)viewControllersByIdentifier {
    if (!_viewControllersByIdentifier) {
        _viewControllersByIdentifier = [NSMutableDictionary dictionary];
    }
    return _viewControllersByIdentifier;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kBioSegue]) {
        [self prepareForBioSegue:segue sender:sender];
    } else if ([segue.identifier isEqualToString:kPostCollectionSegue]) {
        [self prepareForPostCollectionSegue:segue sender:sender];
    } else if ([segue.identifier isEqualToString:kPostListSegue]) {
        [self prepareForPostListSegue:segue sender:sender];
    } else if ([segue.identifier isEqualToString:kGeoSegue]) {
        [self prepareForGeoSegue:segue sender:sender];
    }
}

- (void)prepareForBioSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self switchViewController:segue.destinationViewController
                withIdentifier:segue.identifier];
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
    
    if ([self.destinationViewController conformsToProtocol:@protocol(DIProfileInfoProtocol)]) {
        UIViewController<DIProfileInfoProtocol> *vc = (UIViewController<DIProfileInfoProtocol> *)self.destinationViewController;
        [vc setUser:self.user];
    }
}

@end