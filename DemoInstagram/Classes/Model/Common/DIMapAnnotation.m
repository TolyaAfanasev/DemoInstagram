//
//  DIMapAnnotation.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/23/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIMapAnnotation.h"
#import "DIMediaModel.h"
#import "DILocationModel.h"

@interface DIMapAnnotation ()
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation DIMapAnnotation
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)loc {
    self = [super init];
    if (self) {
        self.coordinate = loc;
    }
    return self;
}

- (instancetype)initWithPost:(DIMediaModel *)post {
    self = [super init];
    if (self) {
        self.post = post;
        self.coordinate = [self.post.location location];
    }
    return self;
}
@end
