//
//  DICoreDateHelper.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/13/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DICoreDateHelper.h"
#import "Token.h"
#import "Token+CoreDataProperties.h"

@import CoreData;
@implementation DICoreDateHelper

#pragma mark - Public

+ (void)saveToken:(NSString *)token {
    Token *newToken = (Token *)[DICoreDateHelper createObject:[Token class]];
    newToken.token = token;
    [DICoreDateHelper saveObject:newToken failure:nil success:nil];
}

+ (void)saveUserUuid:(NSString *)uuid {
    Token *token = [[DICoreDateHelper getManagedObjectWithClass:[Token class]] lastObject];
    token.userUuid = uuid;
    [DICoreDateHelper saveObject:token failure:nil success:nil];
}

+ (void)getToken:(void(^)(NSString *token))tokenBlock {
    Token *token = [[DICoreDateHelper getManagedObjectWithClass:[Token class]] lastObject];
    if (tokenBlock) {
        tokenBlock(token.token);
    }
}

+ (void)getUserUuid:(void(^)(NSString *uuid))uuidBlock {
    Token *token = [[DICoreDateHelper getManagedObjectWithClass:[Token class]] lastObject];
    if (uuidBlock) {
        uuidBlock(token.userUuid);
    }
}

+ (void)removeToken {
    [DICoreDateHelper clearCoreDataEntities:[Token class]];
}

#pragma mark - Private

+ (NSManagedObject *)createObject:(Class)obj {
    NSString *objDescription = [obj description];
    NSManagedObjectContext *context = [DICoreDateHelper managedObjectContext];
    
    return [NSEntityDescription insertNewObjectForEntityForName:objDescription inManagedObjectContext:context];
}

+ (void)saveObject:(NSManagedObject *)obj
           failure:(void(^)(NSError *error))failure
           success:(void(^)())success {
    NSManagedObjectContext *context = [DICoreDateHelper managedObjectContext];
    NSError *error;
    if (![context save:&error]) {
        if (failure) {
            failure(error);
        }
    } else {
        if (success) {
            success();
        }
    }
}

+ (void)clearCoreDataEntities:(Class)class{
    NSManagedObjectContext *context = [DICoreDateHelper managedObjectContext];
    for (NSManagedObject * obj in [DICoreDateHelper getManagedObjectWithClass:class]) {
        [context deleteObject:obj];
        
        NSError *saveError = nil;
        [context save:&saveError];
    }
}

+ (NSArray *)getManagedObjectWithClass:(Class)class {
    NSArray *list = nil;
    @try {
        NSManagedObjectContext *context = [DICoreDateHelper managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[class description]];
        NSError *error;
        list = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    }
    @catch (NSException *exception) {
        NSLog(@"getManagedObjectWithClass error.");
    }
    return list;
}

+ (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate respondsToSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }

    return context;
}
@end
