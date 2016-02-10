//
//  NSArray+DIMapAnnotation.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/23/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MKAnnotation;
@interface NSArray (DIMapAnnotation)
- (NSArray<id<MKAnnotation>> *)mapAnnotationList;
@end
