//
//  DICustomSegmentedView.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DICustomSegmentedView;
@protocol DICustomSegmentedViewDelegate <NSObject>
- (void)customSegmentedView:(DICustomSegmentedView *)segmentedView
           didSelectedIndex:(NSInteger)index;
@end

@class DIProfileSegmentedButton;
@interface DICustomSegmentedView : UIView
@property (strong, nonatomic) IBOutletCollection(DIProfileSegmentedButton) NSArray *buttons;
@property (weak, nonatomic) id<DICustomSegmentedViewDelegate>delegate;
@end
