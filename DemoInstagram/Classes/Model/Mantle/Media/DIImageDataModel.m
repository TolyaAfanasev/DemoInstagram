//
//  DIImageDataModel.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIImageDataModel.h"
#import "UIImage+DIImageWithSize.h"

@implementation DIImageDataModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"url" : @"url",
             @"width" : @"width",
             @"height" : @"height"};
}

- (CGFloat)proportion {
    return self.width.floatValue / self.height.floatValue;
}

- (void)image:(void(^)(UIImage *image))complete {
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperationWithBlock:^{
        UIImage *image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                  [NSURL URLWithString:self.url]]]
                          imageWithSize:CGSizeMake(36.0f, 36.0f)];
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        [queue addOperationWithBlock:^{
            complete(image);
        }];
    }];
}

@end