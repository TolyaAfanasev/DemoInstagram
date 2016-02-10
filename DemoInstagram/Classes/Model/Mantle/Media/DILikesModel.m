//
//  DILikesModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DILikesModel.h"
#import "DIUserModel.h"

@implementation DILikesModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"count" : @"count",
             @"data" : @"data"};
}

#pragma mark - List

+ (NSValueTransformer *)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DIUserModel class]];
}
@end
