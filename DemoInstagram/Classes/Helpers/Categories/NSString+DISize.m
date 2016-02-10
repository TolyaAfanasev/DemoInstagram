//
//  NSString+DISize.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "NSString+DISize.h"

@implementation NSString (DISize)
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedForWidth:(CGFloat)width {
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    NSDictionary *attributes = @{ NSFontAttributeName: font };
    CGRect boundingRect = [self boundingRectWithSize:size options:options attributes:attributes context:nil];

    return boundingRect.size.height;
}
@end
