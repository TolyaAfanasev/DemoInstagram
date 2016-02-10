//
//  DIImagesModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>
@class DIImageDataModel;
@interface DIImagesModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) DIImageDataModel *low_resolution;
@property (strong, nonatomic) DIImageDataModel *thumbnail;
@property (strong, nonatomic) DIImageDataModel *standard_resolution;
@end
