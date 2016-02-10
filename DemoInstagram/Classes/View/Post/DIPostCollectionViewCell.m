//
//  DIPostCollectionViewCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIPostCollectionViewCell.h"
#import "DIMediaModel.h"
#import "DIImagesModel.h"
#import "DIImageDataModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface DIPostCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageVideoPlaceholder;
@end

@implementation DIPostCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image.backgroundColor = [UIColor diBgLightGrayColor];
    [self reset];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self reset];
}

- (void)reset {
    self.image.image = nil;
    self.imageVideoPlaceholder.hidden = NO;
}

- (void)setMedia:(DIMediaModel *)media {
    _media = media;
    [self.image setImageWithURL:[NSURL URLWithString:_media.images.standard_resolution.url]];
    
    if ([_media.type isEqualToString:kMediaTypePhoto])  {
        self.imageVideoPlaceholder.hidden = YES;
    }
}

@end
