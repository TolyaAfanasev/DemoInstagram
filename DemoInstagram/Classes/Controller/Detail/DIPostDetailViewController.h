//
//  DIPostDetailViewController.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/17/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DIMediaModel;
@interface DIPostDetailViewController : UIViewController
@property (strong, nonatomic) DIMediaModel *post;
@end
