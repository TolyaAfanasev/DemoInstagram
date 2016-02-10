//
//  DIUserModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIUserModel.h"
#import "DIUserCountersModel.h"

@implementation DIUserModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = @{
                           @"bio" : @"bio",
                           @"counts" : @"counts",
                           @"full_name" : @"full_name",
                           @"profile_picture" : @"profile_picture",
                           @"username" : @"username",
                           @"website" : @"website"
                           };
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:dict];
}

#pragma mark - Entity

+ (NSValueTransformer *)countsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIUserCountersModel class]];
}

@end