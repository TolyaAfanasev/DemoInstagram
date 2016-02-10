//
//  DIProfileCounterButton.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DIProfileCounterDto;
@interface DIProfileCounterButton : UIControl
@property (strong, nonatomic) DIProfileCounterDto *counterDto;
@property (strong, nonatomic) UIColor *counterButtonColor;
@end
