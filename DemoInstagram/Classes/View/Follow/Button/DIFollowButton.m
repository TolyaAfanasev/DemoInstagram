//
//  DIFollowButton.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIFollowButton.h"

@implementation DIFollowButton

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setTitle:@"FOLLOW" forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor diRedColor] forState:UIControlStateNormal];
//    [self setImage:[UIImage new] forState:UIControlStateNormal];
//    
//    [self setTitle:@"FOLLOWING" forState:UIControlStateSelected];
//    [self setTitleColor:[UIColor diWhiteColor] forState:UIControlStateSelected];
//    [self setImage:[UIImage new] forState:UIControlStateSelected];

    self.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor diBgDarkGrayColor];
        self.layer.borderColor = [[UIColor diBgDarkGrayColor] CGColor];
        self.label.text = @"following";
        self.label.textColor = [UIColor diWhiteColor];
    } else {
        self.backgroundColor = [UIColor diWhiteColor];
        self.layer.borderColor = [[UIColor diRedColor] CGColor];
        self.label.text = @"follow";
        self.label.textColor = [UIColor diRedColor];
    }
}

@end