//
//  DICoreDateHelper.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/13/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Token;
@interface DICoreDateHelper : NSObject
+ (void)saveToken:(NSString *)token;
+ (void)saveUserUuid:(NSString *)uuid;
+ (void)getToken:(void(^)(NSString *token))tokenBlock;
+ (void)getUserUuid:(void(^)(NSString *uuid))uuidBlock;
+ (void)removeToken;
@end
