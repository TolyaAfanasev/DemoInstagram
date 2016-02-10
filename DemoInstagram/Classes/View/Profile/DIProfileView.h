//
//  DIProfileView.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/16/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DIProfileView;
@protocol DIProfileViewDelegate <NSObject>
- (void)profileViewSelectedFollowers:(DIProfileView *)profileView;
- (void)profileViewSelectedFollowing:(DIProfileView *)profileView;
@end

@class DIUserModel;
@interface DIProfileView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) DIUserModel *user;
@property (weak, nonatomic) id<DIProfileViewDelegate>delegate;
@end
