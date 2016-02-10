//
//  DILoadingTableViewCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DILoadingTableViewCell;
typedef void(^OnShowLoadingBlock)(DILoadingTableViewCell*);
@interface DILoadingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, copy) OnShowLoadingBlock onShowLoadingBlock;
@end
