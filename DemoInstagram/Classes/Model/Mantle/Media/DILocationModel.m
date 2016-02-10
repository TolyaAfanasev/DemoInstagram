//
//  DILocationModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DILocationModel.h"

@implementation DILocationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *dict = @{
                           @"latitude" : @"latitude",
                           @"longitude" : @"longitude",
                           @"name" : @"name",
                           @"idKey": @"id"
                           };
    return dict;
}

- (CLLocationCoordinate2D)location {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.latitude.doubleValue,
                                                                 self.longitude.doubleValue);
    return location;
}
@end
