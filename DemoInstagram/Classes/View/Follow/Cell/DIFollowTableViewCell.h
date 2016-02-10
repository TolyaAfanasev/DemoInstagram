//
//  DIFollowTableViewCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIBaseFollowTableViewCell.h"

@class DIFollowButton;
@class DIFollowTableViewCell;
@protocol DIFollowTableViewCellDelegate <NSObject>
- (void)followTableViewCellAddClick:(DIFollowTableViewCell *)cell;
- (void)followTableViewCellRemoveClick:(DIFollowTableViewCell *)cell;
@end


@interface DIFollowTableViewCell : DIBaseFollowTableViewCell
@property (weak, nonatomic) IBOutlet DIFollowButton *buttonFollow;
@property (weak, nonatomic) id<DIFollowTableViewCellDelegate>delegate;
@end
