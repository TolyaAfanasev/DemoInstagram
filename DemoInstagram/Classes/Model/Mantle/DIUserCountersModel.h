//
//  DIUserCountersModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface DIUserCountersModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *media;
@property (strong, nonatomic) NSNumber *follows;
@property (strong, nonatomic) NSNumber *followed_by;
@end