//
//  NSArray+DIMapAnnotation.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/23/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "NSArray+DIMapAnnotation.h"
#import "DIMediaModel.h"
#import "DIMapAnnotation.h"

@implementation NSArray (DIMapAnnotation)

- (NSArray<id<MKAnnotation>> *)mapAnnotationList {
    NSMutableArray <id<MKAnnotation>> *list = [NSMutableArray new];
    
    for (DIMediaModel *item in self) {
        [list addObject:[[DIMapAnnotation alloc] initWithPost:item]];
    }
    
    return list;
}

@end
