//
//  DIBlockConstants.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/5/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#ifndef DIBlockConstants_h
#define DIBlockConstants_h

typedef void(^EmptyBlock)();

@class DIMediaModel;
@class DIPaginationModel;
typedef void(^MediaListSuccessBlock)(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination);
typedef void(^Failure)(id error);

@class DICommentModel;
typedef void(^CommentListSuccessBlock)(NSArray<DICommentModel *> *list);
#endif /* DIBlockConstants_h */
