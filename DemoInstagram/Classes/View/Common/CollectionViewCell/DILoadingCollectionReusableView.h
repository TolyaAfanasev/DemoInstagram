//
//  DILoadingCollectionReusableView.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DILoadingCollectionReusableView;
typedef void(^OnShowLoadingBlock)(DILoadingCollectionReusableView*);
@interface DILoadingCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) OnShowLoadingBlock onShowLoadingBlock;
@end
