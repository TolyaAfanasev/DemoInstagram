//
//  DIProfileSegmentedButton.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIProfileSegmentedButton.h"

@implementation DIProfileSegmentedButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTitleColor:[UIColor diRedColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor diBlackColor] forState:UIControlStateSelected];
    [self updateColor];
}

- (void)updateColor {
    if (self.selected) {
        self.tintColor = [UIColor diBlackColor];
    } else {
        self.tintColor = [UIColor diRedColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
