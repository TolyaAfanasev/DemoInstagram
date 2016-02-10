//
//  DIMediaApiClient.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiClient.h"

@class DIMediaModel;
@class DIUuidPaginationObject;
@interface DIMediaApiClient : DIBaseApiClient

- (void)userMedia:(DIUuidPaginationObject *)pagination
          success:(void(^)(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination))success
          failure:(void(^)(id error))failure;

- (void)myMedia:(void(^)(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination))success
        failure:(void(^)(id error))failure;

@end