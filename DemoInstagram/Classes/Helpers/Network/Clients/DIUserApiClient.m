//
//  DIUserApiClient.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIUserApiClient.h"
#import "DICoreDateHelper.h"
#import "DIUserModel.h"
#import "DIFollowingUserModel.h"
#import "DIListApiResponse.h"

@implementation DIUserApiClient

#pragma mark - OVCHTTPSessionManager

+ (NSDictionary *)responseClassesByResourcePath {
    return @{@"users/self/followed-by" : [DIListApiResponse class],
             @"users/self/follows" : [DIListApiResponse class]};
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{@"users/self" : [DIUserModel class],
             @"users/*" : [DIUserModel class],
             @"users/self/followed-by" : [DIUserModel class],
             @"users/self/follows" : [DIFollowingUserModel class]};
}

#pragma mark - Public

- (void)me:(void(^)(DIUserModel *user))success
   failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
              [self GET:@"users/self/"
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

- (void)user:(NSString *)uuid
            success:(void(^)(DIUserModel *user))success
   failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            [self GET:[NSString stringWithFormat:@"users/%@", uuid]
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

- (void)followers:(void(^)(NSArray<DIUserModel *> *list))success
          failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            [self GET:@"users/self/followed-by"
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

- (void)following:(void(^)(NSArray<DIFollowingUserModel *> *list))success
          failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            [self GET:@"users/self/follows"
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

- (void)follow:(DIFollowingUserModel *)user
       success:(void(^)())success
       failure:(void(^)(id error))failure {
    [self follow:user follow:YES success:success failure:failure];
}

- (void)unfollow:(DIFollowingUserModel *)user
         success:(void(^)())success
         failure:(void(^)(id error))failure {
    [self follow:user follow:NO success:success failure:failure];
}


#pragma mark - Private

- (void)follow:(DIFollowingUserModel *)user
        follow:(BOOL)follow
       success:(void(^)())success
       failure:(void(^)(id error))failure {
    @weakify(self);
    [DICoreDateHelper getToken:^(NSString *token) {
        @strongify(self);
        if (token) {
            NSString *path = [NSString stringWithFormat:@"users/%@/relationship?access_token=%@", user.idKey, token];
            [self POST:path
           parameters:@{@"action" : follow ? @"follow" : @"unfollow"}
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
