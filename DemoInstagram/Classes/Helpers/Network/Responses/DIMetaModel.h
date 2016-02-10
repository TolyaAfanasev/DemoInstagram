//
//  DIMetaModel.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/5/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface DIMetaModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *code;
@end
