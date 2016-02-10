//
//  DIErrorHandler.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIErrorHandler.h"

@implementation DIErrorHandler
+ (void)showLog:(NSString *)text{
    NSLog(@"%@", text);
}

+ (Failure)apiErrorHandler {
    return ^(id error) {
        @try {
            NSString *text = error[@"error_message"];
            if (text) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        @catch (NSException *exception) {
            [DIErrorHandler showLog:@"Error getting Api error text!"];
        }
    };
}

@end
