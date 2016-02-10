//
//  DIUserApiClient.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiClient.h"
@class DIUserModel;
@class DIFollowingUserModel;
@interface DIUserApiClient : DIBaseApiClient

- (void)me:(void(^)(DIUserModel *user))success
   failure:(void(^)(id error))failure;

- (void)user:(NSString *)uuid
     success:(void(^)(DIUserModel *user))success
     failure:(void(^)(id error))failure;

- (void)followers:(void(^)(NSArray<DIUserModel *> *list))success
   failure:(void(^)(id error))failure;

- (void)following:(void(^)(NSArray<DIFollowingUserModel *> *list))success
          failure:(void(^)(id error))failure;

- (void)follow:(DIFollowingUserModel *)user
       success:(void(^)())success
          failure:(void(^)(id error))failure;

- (void)unfollow:(DIFollowingUserModel *)user
       success:(void(^)())success
       failure:(void(^)(id error))failure;
@end
