//
//  DIMediaApiClient.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIMediaApiClient.h"
#import "DICoreDateHelper.h"
#import "DIListApiResponse.h"
#import "DIMediaModel.h"
#import "DIUuidPaginationObject.h"

@implementation DIMediaApiClient

#pragma mark - OVCHTTPSessionManager

+ (NSDictionary *)responseClassesByResourcePath {
    return @{@"users/self/media/recent" : [DIListApiResponse class],
             @"users/*/media/recent" : [DIListApiResponse class]};
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{@"users/self/media/recent" : [DIMediaModel class],
             @"users/*/media/recent" : [DIMediaModel class]};
}

#pragma mark - Public

- (void)userMedia:(DIUuidPaginationObject *)pagination
        success:(void(^)(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination))success
        failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
  
        if (token) {
            NSString *path = nil;
            
            if (pagination.nextUrl) {
                path = pagination.nextUrl;
            } else {
                path = [NSString stringWithFormat:@"users/%@/media/recent", pagination.uuid];
            }
            
            [self GET:path
           parameters:@{@"access_token" : token,
                        @"COUNT" : @100}
           completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
               if (error) {
                   if (failure) {
                       failure(response.result);
                   }
               } else {
                   if (success) {
                       DIListApiResponse *list = (DIListApiResponse *)response;
                       success(response.result, list.pagination);
                   }
               }
           }];
        } else {
            failure(nil);
        }
    }];
}

- (void)myMedia:(void(^)(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination))success
        failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            [self GET:@"users/self/media/recent"
           parameters:@{@"access_token" : token}
           completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
               if (error) {
                   if (failure) {
                       failure(response.result);
                   }
               } else {
                   if (success) {
                       DIListApiResponse *list = (DIListApiResponse *)response;
                       success(response.result, list.pagination);
                   }
               }
           }];
        } else {
            failure(nil);
        }
    }];
}
@end
