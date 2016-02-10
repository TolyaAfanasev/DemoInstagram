//
//  DIPaginationModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/5/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIPaginationModel.h"

@implementation DIPaginationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"next": @"next_url",
              @"nextMaxId" : @"next_max_id"};
}
@end