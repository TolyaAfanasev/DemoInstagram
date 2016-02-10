//
//  DICommentsListModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>
@class DICommentModel;
@interface DICommentsListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray<DICommentModel *> *data;
@end
