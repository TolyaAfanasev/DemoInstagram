//
//  DIButton.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/12/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIButton.h"

@implementation DIButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

- (void)setBordered:(BOOL)bordered{
    if (bordered) {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor diWhiteColor] CGColor];
    } else {
        self.layer.borderWidth = 0.0f;
    }
}

- (void)setBorderCornerRadius:(float)borderCornerRadius {
    self.layer.cornerRadius = borderCornerRadius;
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    self.alpha = enabled ? 1.0f : 0.5f;
}
@end
