//
//  DIVideoPlayerView.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/15/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIVideoPlayerView.h"
@import MediaPlayer;
@interface DIVideoPlayerView ()
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end

@implementation DIVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame url:(NSURL *)url {
    self = [super initWithFrame:frame];
    if (self) {
        self.url = url;
        [self preload];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
        [self preload];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.moviePlayer.view.frame = self.bounds;
}

- (void)preload {
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.url];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    self.moviePlayer.view.hidden = NO;
    self.moviePlayer.view.backgroundColor = [UIColor diWhiteColor];
    [self.moviePlayer prepareToPlay];
    [self addSubview:self.moviePlayer.view];
}

- (void)prepareForPlay {
    [self.moviePlayer play];
}

- (void)stopPlay {
    [self.moviePlayer stop];
    self.moviePlayer = nil;
}
@end