//
//  DIMediaModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseIdModel.h"

static NSString *const kMediaTypePhoto = @"image";
static NSString *const kMediaTypeVideo = @"video";

@class DIUserModel;
@class DICommentsListModel;
@class DICaptionModel;
@class DIImagesModel;
@class DILikesModel;
@class DILocationModel;
@class DIVideoModel;
@interface DIMediaModel : DIBaseIdModel
@property (strong, nonatomic) id attribution;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) DILocationModel *location;
@property (strong, nonatomic) DICommentsListModel *comments; //Comments model
@property (strong, nonatomic) NSString *filter;
@property (strong, nonatomic) NSDate *created_time;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) DILikesModel *likes; //Likes model
@property (strong, nonatomic) DIImagesModel *images; //Imafe model
@property (strong, nonatomic) NSArray *users_in_photo;
@property (strong, nonatomic) DICaptionModel *caption; //Caption model
@property (assign, nonatomic) BOOL user_has_liked;
@property (strong, nonatomic) DIUserModel *user;
@property (strong, nonatomic) DIVideoModel *videos;
@end




