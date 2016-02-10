//
//  DIMediaModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIMediaModel.h"
#import "DICommentsListModel.h"
#import "DIUserModel.h"
#import "DICaptionModel.h"
#import "DIUserInPhotoModel.h"
#import "DIImagesModel.h"
#import "DILikesModel.h"
#import "DILocationModel.h"
#import "DIVideoModel.h"

@implementation DIMediaModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = @{
                           @"attribution" : @"attribution",
                           @"tags" : @"tags",
                           @"type" : @"type",
                           @"location" : @"location",
                           @"comments" : @"comments",
                           @"filter" : @"filter",
                           @"created_time" : @"created_time",
                           @"link" : @"link",
                           @"likes" : @"likes",
                           @"images" : @"images",
                           @"users_in_photo" : @"users_in_photo",
                           @"caption" : @"caption",
                           @"user_has_liked" : @"user_has_liked",
                           @"user" : @"user",
                           @"videos" : @"videos"
                           };
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:dict];
}

#pragma mark - Date

+ (NSValueTransformer *)created_timeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSString *)value integerValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return @([value timeIntervalSince1970]);
    }];
}

#pragma mark - Entities

+ (NSValueTransformer *)commentsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DICommentsListModel class]];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIUserModel class]];
}

+ (NSValueTransformer *)captionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DICaptionModel class]];
}

+ (NSValueTransformer *)imagesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIImagesModel class]];
}

+ (NSValueTransformer *)likesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DILikesModel class]];
}

+ (NSValueTransformer *)locationJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DILocationModel class]];
}

+ (NSValueTransformer *)videosJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIVideoModel class]];
}

#pragma mark - List

+ (NSValueTransformer *)users_in_photoJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DIUserInPhotoModel class]];
}


@end