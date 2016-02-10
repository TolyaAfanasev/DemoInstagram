//
//  UIColor+DIColors.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/12/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "UIColor+DIColors.h"

@implementation UIColor (DIColors)
+ (UIColor *)diWhiteColor{
    return [UIColor whiteColor];
}

+ (UIColor *)diRedColor{
    return [UIColor colorWithRed:0.8039f green:0.1764f blue:0.1764f alpha:1.0f];
}

+ (UIColor *)diBlackColor {
    return [UIColor colorWithRed:0.203f green:0.203f blue:0.203f alpha:1.0f];
}

+ (UIColor *)diBgLightGrayColor {
    return [UIColor colorWithRed:0.933f green:0.933f blue:0.933f alpha:1.0f];
}

+ (UIColor *)diBgDarkGrayColor {
    return [UIColor grayColor];
}


- (NSDictionary *)colorAttribute {
    return @{NSForegroundColorAttributeName : self};
}

@end
