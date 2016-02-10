//
//  UIColor+DIColors.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/12/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DIColors)
+ (UIColor *)diWhiteColor;
+ (UIColor *)diRedColor;
+ (UIColor *)diBlackColor;
+ (UIColor *)diBgLightGrayColor;
+ (UIColor *)diBgDarkGrayColor;

- (NSDictionary *)colorAttribute;
@end
