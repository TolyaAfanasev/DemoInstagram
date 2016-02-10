//
//  DIProfileView.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/16/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIProfileView.h"
#import "DIUserModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "DIProfileCounterButton.h"
#import "DIProfileCounterDto.h"
#import "DIUserCountersModel.h"

@interface DIProfileView ()
@property (weak, nonatomic) IBOutlet DIProfileCounterButton *counterPosts;
@property (weak, nonatomic) IBOutlet DIProfileCounterButton *counterFollowers;
@property (weak, nonatomic) IBOutlet DIProfileCounterButton *counterFollowings;

@end

@implementation DIProfileView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    [self.counterFollowers addTarget:self action:@selector(counterFollowersClick) forControlEvents:UIControlEventTouchUpInside];
    [self.counterFollowings addTarget:self action:@selector(counterFollowingsClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUser:(DIUserModel *)user {
    _user = user;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:user.profile_picture]];
    
    self.counterPosts.counterButtonColor = [UIColor diBlackColor];
    self.counterFollowers.counterButtonColor = user.isIAm ? [UIColor diRedColor] : [UIColor diBlackColor];
    self.counterFollowings.counterButtonColor = user.isIAm ? [UIColor diRedColor] : [UIColor diBlackColor];
    
    self.counterPosts.counterDto = [DIProfileCounterDto counter:@"posts" count:user.counts.media];
    self.counterFollowers.counterDto = [DIProfileCounterDto counter:@"followers" count:user.counts.followed_by];
    self.counterFollowings.counterDto = [DIProfileCounterDto counter:@"following" count:user.counts.follows];
}

- (void)counterFollowersClick {
    if (self.user.isIAm) {
        [self.delegate profileViewSelectedFollowers:self];
    }
}

- (void)counterFollowingsClick {
    if (self.user.isIAm) {
        [self.delegate profileViewSelectedFollowing:self];
    }
}
@end