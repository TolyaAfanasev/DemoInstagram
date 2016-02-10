//
//  DICommentApiClient.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/17/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DICommentApiClient.h"
#import "DICommentModel.h"
#import "DIListApiResponse.h"
#import "DICoreDateHelper.h"

@implementation DICommentApiClient

#pragma mark - OVCHTTPSessionManager

+ (NSDictionary *)responseClassesByResourcePath {
    return @{@"media/*/comments" : [DIListApiResponse class]};
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{@"media/*/comments" : [DICommentModel class]};
}

#pragma mark - Public

- (void)getComments:(NSString *)postUuid
            success:(void(^)(NSArray<DICommentModel *> *list))success
            failure:(Failure)failure {
    [DICoreDateHelper getToken:^(NSString *token) {
        if (token) {
            [self GET:[NSString stringWithFormat:@"media/%@/comments", postUuid]
           parameters:@{@"access_token" : token}
           completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
               if (error) {
                   if (failure) {
                       failure(response.result);
                   }
               } else {
                   if (success) {
                       success(response.result);
                   }
               }
           }];
        } else {
            failure(nil);
        }
    }];
}

- (void)postComment:(NSString *)postUuid
               text:(NSString *)commentText
            success:(EmptyBlock)success
            failure:(Failure)failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        if (token) {
            @strongify(self);
            [self POST:[NSString stringWithFormat:@"media/%@/comments", postUuid]
            parameters:@{@"access_token" : token,
                         @"text" : commentText}
           completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
               if (error) {
                   if (failure) {
                       failure(response.result);
                   }
               } else {
                   if (success) {
                       success(response.result);
                   }
               }
           }];
        } else {
            failure(nil);
        }
    }];
}

- (void)deleteComment:(NSString *)commentUuid
               post:(NSString *)postUuid
            success:(EmptyBlock)success
            failure:(Failure)failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        if (token) {
            @strongify(self);
            [self DELETE:[NSString stringWithFormat:@"media/%@/comments/%@", postUuid, commentUuid]
            parameters:nil
            completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    if (failure) {
                        failure(response.result);
                    }
                } else {
                    if (success) {
                        success(response.result);
                    }
                }
            }];
        } else {
            failure(nil);
        }
    }];
}

@end