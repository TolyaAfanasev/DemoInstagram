//
//  DICustomSegmentedView.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DICustomSegmentedView.h"
#import "DIProfileSegmentedButton.h"

@implementation DICustomSegmentedView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor diBgLightGrayColor];
    
    [self.buttons enumerateObjectsUsingBlock:^(DIProfileSegmentedButton *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addTarget:self action:@selector(profileSegmentedButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)profileSegmentedButtonSelected:(DIProfileSegmentedButton *)sender {
    sender.selected = YES;
    
    [self.buttons enumerateObjectsUsingBlock:^(DIProfileSegmentedButton *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != [self.buttons indexOfObject:sender]) {
            obj.selected = NO;
        }
    }];
    
    [self.delegate customSegmentedView:self
                      didSelectedIndex:[self.buttons indexOfObject:sender]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
