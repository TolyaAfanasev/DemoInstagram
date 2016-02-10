//
//  DIUserCountersModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIUserCountersModel.h"

@implementation DIUserCountersModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"media": @"media",
             @"follows": @"follows",
             @"followed_by": @"followed_by"};
}
@end