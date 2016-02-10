//
//  NSDate+DITimeAgo.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/17/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "NSDate+DITimeAgo.h"
#import <DateTools/DateTools.h>

@implementation NSDate (DITimeAgo)
- (NSString *)agoText {
    NSString *ago = nil;
    
    if ([self yearsAgo] > 0) {
        ago = [NSString stringWithFormat:@"%liy", (long)[self yearsAgo]];
    } else if ([self monthsAgo] > 0) {
        ago = [NSString stringWithFormat:@"%lim", (long)[self monthsAgo]];
    } else if ([self weeksAgo] > 0) {
        ago = [NSString stringWithFormat:@"%liw", (long)[self weeksAgo]];
    } else if ([self daysAgo] > 0) {
        ago = [NSString stringWithFormat:@"%lid", (long)[self daysAgo]];
    } else if ([self hoursAgo] > 0) {
        ago = [NSString stringWithFormat:@"%lih", (long)[self daysAgo]];
    } else if ([self minutesAgo] > 0) {
        ago = [NSString stringWithFormat:@"%limin", (long)[self minutesAgo]];
    } else {
        ago = @"now";
    }
    
    return ago;
}
@end
