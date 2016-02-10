//
//  DICommentApiClient.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/17/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiClient.h"

@class DICommentModel;
@interface DICommentApiClient : DIBaseApiClient

- (void)getComments:(NSString *)postUuid
            success:(void(^)(NSArray<DICommentModel *> *list))success
            failure:(Failure)failure;

- (void)postComment:(NSString *)postUuid
               text:(NSString *)commentText
            success:(EmptyBlock)success
            failure:(Failure)failure;

- (void)deleteComment:(NSString *)commentUuid
                 post:(NSString *)postUuid
              success:(EmptyBlock)success
              failure:(Failure)failure;

@end
