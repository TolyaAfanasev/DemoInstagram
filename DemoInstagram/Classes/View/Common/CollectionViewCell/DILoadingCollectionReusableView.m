//
//  DILoadingCollectionReusableView.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DILoadingCollectionReusableView.h"

@implementation DILoadingCollectionReusableView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.activityIndicator.color = [UIColor diRedColor];
}

@end
