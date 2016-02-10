//
//  DIBaseFollowTableViewCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIBaseFollowTableViewCell.h"
#import "DIUserModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@implementation DIBaseFollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelUsername.text = @"";
    self.imageAvatar.image = nil;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.labelUsername.text = @"";
    self.imageAvatar.image = nil;
}

- (void)setUser:(DIUserModel *)user {
    _user = user;
    
    [self.imageAvatar setImageWithURL:[NSURL URLWithString:_user.profile_picture]];
    self.labelUsername.text = _user.username;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
