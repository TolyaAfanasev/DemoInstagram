//
//  DILocationModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseIdModel.h"

@interface DILocationModel : MTLModel<MTLJSONSerializing>
- (CLLocationCoordinate2D)location;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *idKey;
@end