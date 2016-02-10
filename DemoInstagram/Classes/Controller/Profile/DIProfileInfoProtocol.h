//
//  DIProfileInfoProtocol.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/20/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#ifndef DIProfileInfoProtocol_h
#define DIProfileInfoProtocol_h

@class DIUserModel;
@protocol DIProfileInfoProtocol <NSObject>
- (void)setUser:(DIUserModel *)user;
@end

#endif /* DIProfileInfoProtocol_h */
