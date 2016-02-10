//
//  DILoadingTableViewCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DILoadingTableViewCell.h"

@implementation DILoadingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.activityIndicatorView.color = [UIColor diRedColor];
}

@end
