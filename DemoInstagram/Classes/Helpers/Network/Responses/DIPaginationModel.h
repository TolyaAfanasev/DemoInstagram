//
//  DIPaginationModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/5/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface DIPaginationModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString *next;
@property (strong, nonatomic) NSString *nextMaxId;
@end