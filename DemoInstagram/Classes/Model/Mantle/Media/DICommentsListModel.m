//
//  DICommentsListModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DICommentsListModel.h"
#import "DICommentModel.h"

@implementation DICommentsListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"count" : @"count",
             @"data" : @"data"};
}

#pragma mark - List

+ (NSValueTransformer *)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DICommentModel class]];
}

@end
