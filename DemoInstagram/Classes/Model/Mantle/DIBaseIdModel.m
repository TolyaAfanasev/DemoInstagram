//
//  DIBaseIdModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseIdModel.h"

@implementation DIBaseIdModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"idKey": @"id"};
}
@end
