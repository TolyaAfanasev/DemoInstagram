//
//  DIFollowingUserModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIFollowingUserModel.h"

@implementation DIFollowingUserModel
- (id)init{
    self = [super init];
    if (self) {
        self.isFollowedByMe = YES;
    }
    return self;
}
@end
