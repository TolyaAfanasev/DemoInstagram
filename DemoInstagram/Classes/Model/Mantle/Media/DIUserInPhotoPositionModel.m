//
//  DIUserInPhotoPositionModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIUserInPhotoPositionModel.h"

@implementation DIUserInPhotoPositionModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"x" : @"x",
             @"y" : @"y"};
}
@end
