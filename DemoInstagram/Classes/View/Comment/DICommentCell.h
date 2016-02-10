//
//  DICommentCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/18/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DICommentModel;
@interface DICommentCell : UITableViewCell
@property (strong, nonatomic) DICommentModel *comment;
@end
