//
//  DIPostTableViewCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/28/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIPostTableViewCell.h"
#import "DIMediaModel.h"
#import "DIImagesModel.h"
#import "DIImageDataModel.h"
#import "DIUserModel.h"
#import "DICaptionModel.h"
#import "DILikesModel.h"
#import "DICommentsListModel.h"
#import "DIVideoModel.h"
#import "DIVideoPlayerView.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <Masonry/Masonry.h>
#import "NSDate+DITimeAgo.h"
#import "DICommentModel.h"

@interface DIPostTableViewCell ()
//44
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContainerHeight;

//0
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaContainerHeight;

//44
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContainerHeight;

@property (weak, nonatomic) IBOutlet UIImageView *imageSenderAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelSenderUsername;
@property (weak, nonatomic) IBOutlet UILabel *labelPostDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *mediaContainerView;
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonComments;
@property (weak, nonatomic) IBOutlet UILabel *labelLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *labelCommentCount;
@property (weak, nonatomic) IBOutlet UIView *lastCommentContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *lastCommentImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastCommentLabel;

@property (strong, nonatomic) UIView *mediaView;
@end

@implementation DIPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self reset];
    [self setupStyle];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self reset];
}

- (void)setupStyle {
    self.buttonComments.tintColor = [UIColor diRedColor];
    self.labelSenderUsername.textColor = [UIColor diRedColor];
    self.labelPostDescription.textColor = [UIColor diRedColor];
    self.labelLikeCount.textColor = [UIColor diRedColor];
    self.labelCommentCount.textColor = [UIColor diRedColor];
}

- (void)reset {
    [[self.mediaContainerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.lastCommentLabel.text = @"";
    self.lastCommentImageView.image = [UIImage imageNamed:@"ava"];
}

#pragma mark - Public

+ (CGFloat)cellHeight:(DIMediaModel *)item
                width:(CGFloat)width {
    CGFloat height = 44 + 44;
    
    if ([item.type isEqualToString:kMediaTypePhoto]) {
        CGFloat mediaHeight = [item.images.standard_resolution proportion] * width;
        height += mediaHeight;
    } else {
        CGFloat mediaHeight = [item.videos.low_resolution proportion] * width;
        height += mediaHeight;
    }
    
    return height;
}

- (void)willDisplayCell {
    if ([_model.type isEqualToString:kMediaTypeVideo]) {
        DIVideoPlayerView *mediaVideoView = (DIVideoPlayerView *)self.mediaView;
        [mediaVideoView prepareForPlay];
    }
}

- (void)didEndDisplayingCell {
    if ([_model.type isEqualToString:kMediaTypeVideo]) {
        DIVideoPlayerView *mediaVideoView = (DIVideoPlayerView *)self.mediaView;
        [mediaVideoView stopPlay];
    }
}

#pragma mark - Setters

- (void)setModel:(DIMediaModel *)model {
    _model = model;
    
    self.labelSenderUsername.text = _model.user.username;
    [self.imageSenderAvatar setImageWithURL:[NSURL URLWithString:_model.user.profile_picture]];
    self.labelPostDescription.text = _model.caption.text;
    
    self.mediaView = nil;
    
    if ([_model.type isEqualToString:kMediaTypePhoto])  {
        UIImageView *mediaPhoto = [UIImageView new];
        [mediaPhoto setImageWithURL:[NSURL URLWithString:_model.images.standard_resolution.url]];
        mediaPhoto.contentMode = UIViewContentModeScaleAspectFit;
        self.mediaView = mediaPhoto;
        CGFloat mediaHeight = [_model.images.standard_resolution proportion] * [UIScreen mainScreen].bounds.size.width;
        self.mediaContainerHeight.constant = mediaHeight;
    } else {
        DIVideoPlayerView *mediaVideoView = [[DIVideoPlayerView alloc] initWithUrl:[NSURL URLWithString:model.videos.low_resolution.url]];
        self.mediaView = mediaVideoView;
        CGFloat mediaHeight = [model.videos.low_resolution proportion] * [UIScreen mainScreen].bounds.size.width;
        self.mediaContainerHeight.constant = mediaHeight;
    }
    
    if (self.mediaView) {
        [self.mediaContainerView addSubview:self.mediaView];
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.mediaContainerView).with.insets(padding);
        }];
    }
    
    self.buttonLike.selected = _model.user_has_liked;
    self.buttonLike.tintColor = [UIColor diRedColor];
    self.labelLikeCount.text = [_model.likes.count stringValue];
    self.labelCommentCount.text = [_model.comments.count stringValue];
    
    self.labelDate.text = [_model.created_time agoText];
    
    if (self.mode != DIPostTableViewCellModeDetail) {
        [self prepareLastComment:_model];
    } else {
        [self.lastCommentContainerView removeFromSuperview];
    }
}

- (void)prepareLastComment:(DIMediaModel *)post {
    if (post.comments
        && [post.comments.count compare:@0] == NSOrderedDescending) {
        self.lastCommentContainerView.hidden = NO;
        
        DICommentModel *comment = post.comments.data.lastObject;
        self.lastCommentLabel.text = comment.text;

        if (comment.from.profile_picture) {
            [self.lastCommentImageView setImageWithURL:[NSURL URLWithString:comment.from.profile_picture]];
        }
    } else {
        self.lastCommentContainerView.hidden = YES;
    }
}

#pragma mark - IBActions

- (IBAction)buttonCommentClick:(id)sender {
    [self.delegate postTableViewCellDidSelectComments:self];
}

- (IBAction)buttonLikeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    sender.tintColor = [UIColor diRedColor];
}

@end