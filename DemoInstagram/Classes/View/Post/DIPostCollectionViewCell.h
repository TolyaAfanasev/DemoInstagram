//
//  DIPostCollectionViewCell.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/3/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DIMediaModel;
@interface DIPostCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) DIMediaModel *media;
@end
