//
//  NSString+DISize.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DISize)
- (CGFloat)getHeightWithFont:(UIFont *)font
         constrainedForWidth:(CGFloat)width;
@end
