//
//  DISelectableButton.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/15/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DISelectableButton.h"

@implementation DISelectableButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateColor];
}

- (void)updateColor {
    if (self.selected) {
        self.tintColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    } else {
        self.tintColor = [UIColor diWhiteColor];
    }
}
@end
