//
//  DIBaseFollowTableViewCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DIUserModel;
@interface DIBaseFollowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (strong, nonatomic) DIUserModel *user;
@end
