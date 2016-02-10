//
//  DIBaseApiResponse.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/18/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Overcoat/Overcoat.h>
@class DIMetaModel;
@interface DIBaseApiResponse : OVCResponse
@property (strong, nonatomic) DIMetaModel *meta;
@end
