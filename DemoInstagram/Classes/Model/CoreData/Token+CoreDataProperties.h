//
//  Token+CoreDataProperties.h
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/13/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Token.h"

NS_ASSUME_NONNULL_BEGIN

@interface Token (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *userUuid;

@end

NS_ASSUME_NONNULL_END
