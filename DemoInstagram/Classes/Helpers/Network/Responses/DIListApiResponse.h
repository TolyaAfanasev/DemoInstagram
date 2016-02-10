//
//  DIListApiResponse.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseApiResponse.h"

@class DIPaginationModel;
@interface DIListApiResponse : DIBaseApiResponse
@property (strong, nonatomic) DIPaginationModel *pagination;
@end
