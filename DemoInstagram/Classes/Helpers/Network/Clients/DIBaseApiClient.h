//
//  DIBaseApiClient.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/16/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Overcoat/Overcoat.h>

@interface DIBaseApiClient : OVCHTTPRequestOperationManager
+ (instancetype)client;
@end
