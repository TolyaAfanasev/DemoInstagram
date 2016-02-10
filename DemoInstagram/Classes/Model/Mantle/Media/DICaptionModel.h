//
//  DICaptionModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseIdModel.h"

@class DIUserModel;
@interface DICaptionModel : DIBaseIdModel
@property (strong, nonatomic) NSDate *created_time;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) DIUserModel *from;
@end