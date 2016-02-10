//
//  DIVideoModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/15/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@class DIImageDataModel;
@interface DIVideoModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) DIImageDataModel *low_bandwidth;
@property (strong, nonatomic) DIImageDataModel *standard_resolution;
@property (strong, nonatomic) DIImageDataModel *low_resolution;
@end
