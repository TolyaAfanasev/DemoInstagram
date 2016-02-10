//
//  DIContrainerSegue.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIContrainerSegue.h"
#import "DIContainerSegueProtocol.h"

@implementation DIContrainerSegue
- (void)perform {
    UIViewController<DIContainerSegueProtocol> *mainViewController = self.sourceViewController;
    UIViewController *destinationViewController = mainViewController.destinationViewController;
    
    if (mainViewController.oldViewController) {
        [mainViewController.oldViewController willMoveToParentViewController:nil];
        [mainViewController.oldViewController.view removeFromSuperview];
        [mainViewController.oldViewController removeFromParentViewController];
    }
    
    CGRect frame = mainViewController.containerView.bounds;
    
    destinationViewController.view.frame = frame;
    [mainViewController addChildViewController:destinationViewController];
    [mainViewController.containerView addSubview:destinationViewController.view];
    [destinationViewController didMoveToParentViewController:mainViewController];
}
@end
