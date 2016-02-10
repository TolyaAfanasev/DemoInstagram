//
//  DIVideoPlayerView.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/15/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIVideoPlayerView : UIView
- (instancetype)initWithFrame:(CGRect)frame url:(NSURL *)url;
- (instancetype)initWithUrl:(NSURL *)url;
- (void)prepareForPlay;
- (void)stopPlay;
@end
