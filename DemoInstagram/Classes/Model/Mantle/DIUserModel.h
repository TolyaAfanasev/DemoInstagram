//
//  DIUserModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseIdModel.h"
@class DIUserCountersModel;
@interface DIUserModel : DIBaseIdModel
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) DIUserCountersModel *counts;
@property (strong, nonatomic) NSString *full_name;
@property (strong, nonatomic) NSString *profile_picture;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *website;
@property (assign, nonatomic) BOOL isIAm;
@end