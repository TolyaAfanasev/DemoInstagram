//
//  DIImagesModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIImagesModel.h"
#import "DIImageDataModel.h"

@implementation DIImagesModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"low_resolution" : @"low_resolution",
             @"thumbnail" : @"thumbnail",
             @"standard_resolution" : @"standard_resolution"};
}

#pragma mark - Entity

+ (NSValueTransformer *)low_resolutionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

+ (NSValueTransformer *)thumbnailJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

+ (NSValueTransformer *)standard_resolutionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImageDataModel class]];
}

@end