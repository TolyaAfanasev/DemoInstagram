//
//  DIVideoModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/15/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIVideoModel.h"
#import "DIImageDataModel.h"

@implementation DIVideoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"low_bandwidth" : @"low_bandwidth",
             @"standard_resolution" : @"standard_resolution",
             @"low_resolution" : @"low_resolution"};
}

#pragma mark - Entities

+ (NSValueTransformer *)low_bandwidthJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

+ (NSValueTransformer *)standard_resolutionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

+ (NSValueTransformer *)low_resolutionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

@end
