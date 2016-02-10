//
//  DIMapAnnotation.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/23/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIMapAnnotation : NSObject<MKAnnotation>
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)loc;
- (instancetype)initWithPost:(DIMediaModel *)post;
@property (nonatomic, weak) DIMediaModel *post;
@end
