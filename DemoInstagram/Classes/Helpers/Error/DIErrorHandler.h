//
//  DIErrorHandler.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIErrorHandler : NSObject
+ (void)showLog:(NSString *)text;
+ (Failure)apiErrorHandler;
@end
