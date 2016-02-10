//
//  DIPaginationObject.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OnPaginationLoadingBlock)();

@interface DIPaginationObject : NSObject
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) NSString *nextUrl;
@property (assign, nonatomic) BOOL lowThanStep;
@property (copy, nonatomic) OnPaginationLoadingBlock onPaginationLoadingBlock;
@end