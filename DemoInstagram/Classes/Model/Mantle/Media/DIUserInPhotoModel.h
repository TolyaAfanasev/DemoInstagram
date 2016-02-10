//
//  DIUserInPhotoModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@class DIUserModel;
@class DIUserInPhotoPositionModel;
@interface DIUserInPhotoModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) DIUserModel *user;
@property (strong, nonatomic) DIUserInPhotoPositionModel *position;
@end
