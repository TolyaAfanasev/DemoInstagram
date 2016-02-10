//
//  DICellSizeManager.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DICellSizeManager.h"


@interface DICellSizeManager ()
@property (strong, nonatomic) NSValue *sizeValue;
@end

@implementation DICellSizeManager

- (void)refresh{
    self.sizeValue = nil;
}

- (CGSize)getCollectionViewCellSize:(UICollectionView *)collectionView {
    CGSize size = CGSizeZero;
    
    if (self.sizeValue) {
        size = [self.sizeValue CGSizeValue];
    } else {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGSize contentSize = CGSizeMake(screenSize.width - ((kContentMargine*2)), screenSize.height);
        
        NSInteger itemsCountInt = 3;
        
        size.width = (contentSize.width - ((itemsCountInt - 1) *kCollectionViewMinSpacing))/itemsCountInt;
        size.height = size.width;
        self.sizeValue = [NSValue valueWithCGSize:size];
    }
    
    return size;
}

@end