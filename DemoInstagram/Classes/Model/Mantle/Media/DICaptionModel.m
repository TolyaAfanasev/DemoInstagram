//
//  DICaptionModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DICaptionModel.h"
#import "DIUserModel.h"

@implementation DICaptionModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = @{
                           @"created_time" : @"created_time",
                           @"text" : @"text",
                           @"from" : @"from"
                           };
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:dict];
}

#pragma mark - Entity

+ (NSValueTransformer *)dataJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIUserModel class]];
}

#pragma mark - Date

+ (NSValueTransformer *)created_timeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSString *)value integerValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return @([value timeIntervalSince1970]);
    }];
}

@end
