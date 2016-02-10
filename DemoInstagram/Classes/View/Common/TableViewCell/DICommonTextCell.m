//
//  DICommonTextCell.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DICommonTextCell.h"

@implementation DICommonTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor diBlackColor];
    self.label.text = @"No Data";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
