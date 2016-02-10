//
//  DIBaseApiResponse.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiResponse.h"
#import "DIMetaModel.h"

@implementation DIBaseApiResponse
+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    NSString *keyPath = @"meta";
    
    NSNumber *status = JSONDictionary[@"meta"][@"code"];
    NSInteger statusInt = [status integerValue] / 100;
    
    if (statusInt == 2
        || statusInt == 3) {
        keyPath = @"data";
    }
    
    return keyPath;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"meta" : @"meta"};
}

+ (NSValueTransformer *)metaJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[DIMetaModel class]];
}
@end
