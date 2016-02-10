//
//  DIFollowTableViewCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIFollowTableViewCell.h"
#import "DIFollowButton.h"
#import "DIFollowingUserModel.h"

@implementation DIFollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  }

- (void)setUser:(DIFollowingUserModel *)user {
    [super setUser:user];
    self.buttonFollow.selected = user.isFollowedByMe;
    [self.buttonFollow addTarget:self
                          action:@selector(buttonFollowClick:)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonFollowClick:(DIFollowButton *)sender {
    if (sender.selected) {
        [self.delegate followTableViewCellRemoveClick:self];
    } else {
        [self.delegate followTableViewCellAddClick:self];
    }
}

@end
