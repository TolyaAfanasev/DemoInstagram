//
//  UITableView+DICommonCells.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DILoadingTableViewCell;
@interface UITableView (DICommonCells)
- (DILoadingTableViewCell *)dequeueUFLoadingCell;
- (UITableViewCell *)dequeueUFCommonNoResultCell;
- (UITableViewCell *)dequeueUFNoConnectionCell;
@end
