//
//  DIBaseApiClient.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/16/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiClient.h"
#import "DIBaseApiResponse.h"

NSString * const kAPIBasePath = @"https://api.instagram.com/v1/";

@implementation DIBaseApiClient
- (instancetype)init {
    return [self initWithBaseURL:[NSURL URLWithString:kAPIBasePath]];
}

+ (instancetype)client {
    return [[[self class] alloc] init];
}

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [self.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error){
//            NSString *string = nil;
//            
//            @try{
//                NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:error];
//                string = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
//            }
//            @catch (NSException *exception){
//                NSLog(@"Error in serialization!!!");
//            }
//            NSLog(@"%@", string);
//            return string;
//        }];
    }
    
    return self;
}

#pragma mark - OVCHTTPSessionManager

+ (NSDictionary *)modelClassesByResourcePath {
    return @{};
}

+ (Class)responseClass{
    return [DIBaseApiResponse class];
}
@end
