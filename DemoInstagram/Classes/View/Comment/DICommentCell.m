//
//  DICommentCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/18/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DICommentCell.h"
#import "DICommentModel.h"
#import "DIUserModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "KILabel.h"
#import "NSDate+DITimeAgo.h"

@interface DICommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *commentUserAvatarImage;
@property (weak, nonatomic) IBOutlet UILabel *commentUserNameLable;
@property (weak, nonatomic) IBOutlet UILabel *commentDateLabel;
@property (weak, nonatomic) IBOutlet KILabel *commentTextLabel;
@end

@implementation DICommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareStyles];
}

- (void)prepareStyles {
    self.commentUserNameLable.textColor = [UIColor diRedColor];
    self.commentDateLabel.textColor = [UIColor lightGrayColor];
    self.commentTextLabel.textColor = [UIColor diBlackColor];
    
    [self.commentTextLabel setAttributes:@{NSForegroundColorAttributeName : [UIColor diRedColor]}
                             forLinkType:KILinkTypeHashtag];
    
    [self.commentTextLabel setAttributes:@{NSForegroundColorAttributeName : [UIColor diRedColor]}
                             forLinkType:KILinkTypeUserHandle];
}

- (void)setComment:(DICommentModel *)comment {
    _comment = comment;
    if (_comment.from.profile_picture) {
        [self.commentUserAvatarImage setImageWithURL:[NSURL URLWithString:_comment.from.profile_picture]];
    }
    
    self.commentUserNameLable.text = _comment.from.username;
    self.commentDateLabel.text = [_comment.created_time agoText];
    self.commentTextLabel.text = _comment.text;
}

@end
