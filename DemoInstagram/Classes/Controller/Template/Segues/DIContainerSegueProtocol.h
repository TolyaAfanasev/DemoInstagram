//
//  DIContainerSegueProtocol.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#ifndef DIContainerSegueProtocol_h
#define DIContainerSegueProtocol_h
@protocol DIContainerSegueProtocol <NSObject>
- (UIViewController *)oldViewController;
- (UIViewController *)destinationViewController;
- (UIView *)containerView;
@end

#endif /* DIContainerSegueProtocol_h */
