//
//  DIBaseIdModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface DIBaseIdModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString *idKey;
@end
