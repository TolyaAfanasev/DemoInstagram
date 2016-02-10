//
//  DIProfileCounterButton.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIProfileCounterButton.h"
#import "DIProfileCounterDto.h"

@interface DIProfileCounterButton ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation DIProfileCounterButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.text = @"";
}

- (void)setCounterDto:(DIProfileCounterDto *)counterDto {
    id largeText = @{NSFontAttributeName : [UIFont systemFontOfSize:21],
                     NSForegroundColorAttributeName : self.counterButtonColor};
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[counterDto.count stringValue]
                                                                                        attributes:largeText];
    [attributedString appendAttributedString:[[NSMutableAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@"\n%@", counterDto.name]
                                                                                   attributes:[self.counterButtonColor colorAttribute]]];
    self.label.attributedText = attributedString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
