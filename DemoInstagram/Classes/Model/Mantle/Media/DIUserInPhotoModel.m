//
//  DIUserInPhotoModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIUserInPhotoModel.h"
#import "DIUserModel.h"
#import "DIUserInPhotoPositionModel.h"

@implementation DIUserInPhotoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"user" : @"user",
             @"position" : @"position"};
}

#pragma mark - Entity

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIUserModel class]];
}

+ (NSValueTransformer *)positionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIUserInPhotoPositionModel class]];
}
@end
