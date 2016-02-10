//
//  DIUserInPhotoPositionModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface DIUserInPhotoPositionModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *x;
@property (strong, nonatomic) NSNumber *y;
@end
