//
//  DILoadDataState.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/5/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#ifndef DILoadDataState_h
#define DILoadDataState_h
typedef NS_ENUM(NSUInteger, DILoadDataState){
    DILoadDataStateInProcess,
    DILoadDataStateComplete,
    DILoadDataStateNoData,
    DILoadDataStateConnectionError
};

#endif /* DILoadDataState_h */
