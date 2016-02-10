//
//  DIListApiResponse.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIListApiResponse.h"
#import "DIPaginationModel.h"

@implementation DIListApiResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSDictionary *dict = @{@"pagination" : @"pagination"};
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:dict];
}

+ (NSValueTransformer *)paginationJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIPaginationModel class]];
}
@end
