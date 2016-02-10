//
//  DILikesModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@class DIUserModel;
@interface DILikesModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray<DIUserModel *> *data;
@end