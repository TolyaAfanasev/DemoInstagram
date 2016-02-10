//
//  DIImageDataModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface DIImageDataModel : MTLModel<MTLJSONSerializing>
- (CGFloat)proportion;
- (void)image:(void(^)(UIImage *image))complete;

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *height;
@end
