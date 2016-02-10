//
//  DIPostTableViewCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/28/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DIPostTableViewCellMode) {
    DIPostTableViewCellModeList,
    DIPostTableViewCellModeDetail
};

@class DIPostTableViewCell;
@protocol DIPostTableViewCellDelegate <NSObject>
- (void)postTableViewCellDidSelectComments:(DIPostTableViewCell *)cell;
@end

@class DIMediaModel;
@interface DIPostTableViewCell : UITableViewCell
+ (CGFloat)cellHeight:(DIMediaModel *)item width:(CGFloat)width;
- (void)willDisplayCell;
- (void)didEndDisplayingCell;
@property (strong, nonatomic) DIMediaModel *model;
@property (weak, nonatomic) id<DIPostTableViewCellDelegate> delegate;
@property (assign, nonatomic) DIPostTableViewCellMode mode;
@end
