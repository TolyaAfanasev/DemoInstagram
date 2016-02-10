//
//  DIProfileCounterDto.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIProfileCounterDto.h"

@implementation DIProfileCounterDto
+ (instancetype)counter:(NSString *)text count:(NSNumber *)count {
    return [[self alloc] initWithName:text count:count];
}

- (id)initWithName:(NSString *)text count:(NSNumber *)count{
    self = [super init];
    if (self) {
        self.name = text;
        self.count =count;
    }
    return self;
}

@end
