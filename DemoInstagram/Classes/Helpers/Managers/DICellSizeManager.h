//
//  DICellSizeManager.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat const kContentMargine = 1.0;
static CGFloat const kCollectionViewMinSpacing = 1.0;

@interface DICellSizeManager : NSObject
- (void)refresh;
- (CGSize)getCollectionViewCellSize:(UICollectionView *)collectionView;
@end
