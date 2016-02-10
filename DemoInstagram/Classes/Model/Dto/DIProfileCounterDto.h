//
//  DIProfileCounterDto.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIProfileCounterDto : NSObject
+ (instancetype)counter:(NSString *)text count:(NSNumber *)count;
- (id)initWithName:(NSString *)text count:(NSNumber *)count;


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *count;
@end
