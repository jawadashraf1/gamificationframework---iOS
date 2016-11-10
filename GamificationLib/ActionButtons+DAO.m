//
//  ActionButtons+DAO.m
//  Get Hot
//
//  Created by Raheel Ahmad on 24/03/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "ActionButtons+DAO.h"
#import "PSPointSystemAction.h"

//#import <MagicalRecord/MagicalRecord.h>

//#import "ObjectiveRecord.h"

#define MR_SHORTHAND 1

@implementation ActionButtons (DAO)


+(void) saveAction:(PSAction *) action{
    //    ActionButtons *actionb  = [ActionButtons MR_createEntity];
    //    actionb.button_id       = action.button_id;
    //    actionb.identifier      = action.identifier;
    //    actionb.points          = action.points;
    //    actionb.action_type     = action.action_type;
    //    actionb.is_badge        = action.is_badge;
    //    actionb.user_id         = action.user_id;
    //    actionb.button_tag      = action.button_tag;
    //    [self saveData];
    
    
    //    ActionButtons *actionb  = [ActionButtons create];
    //    actionb.button_id       = action.button_id;
    //    actionb.identifier      = action.identifier;
    //    actionb.points          = action.points;
    //    actionb.action_type     = action.action_type;
    //    actionb.is_badge        = action.is_badge;
    //    actionb.user_id         = action.user_id;
    //    actionb.button_tag      = action.button_tag;
    //
    //    [actionb save];
    
    
    
    
    NSEntityDescription* entityDesc=[NSEntityDescription entityForName:@"ActionButtons" inManagedObjectContext:[PSPointSystemAction sharedAction].managedObjectContext];
    ActionButtons  *actionb =  (ActionButtons *) [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:[PSPointSystemAction sharedAction].managedObjectContext];
    
    actionb.button_id       = action.button_id;
    actionb.identifier      = action.identifier;
    actionb.points          = action.points;
    actionb.action_type     = action.action_type;
    actionb.is_badge        = action.is_badge;
    actionb.user_id         = action.user_id;
    actionb.button_tag      = action.button_tag;
    
    NSError *error = nil;
    
    [[PSPointSystemAction sharedAction].managedObjectContext save:&error];
    
    if(error){
        NSLog(@"ERROR %@",error);
    }
    
    //[self saveData];
    
    
}

+(ActionButtons *) getActionInfo:(NSString *) identifier user_id:(NSNumber *) user_id{
    //    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(identifier = %@) AND (user_id = %@)",identifier,user_id];
    //    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"button_tag = %@",user_id];
    
    //
    //
    //
    //
    //    NSArray * list          = [ActionButtons MR_findAllWithPredicate:predicate];
    //
    //    ActionButtons * actionButtons = nil;
    //
    //    if ([list count] > 0 ) {
    //        actionButtons       = (ActionButtons *)[list objectAtIndex:0];
    //    }
    
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"identifier ==[c] %@",identifier];
    
    ActionButtons * actionButtons = (ActionButtons *) [self getObject:@"ActionButtons" predicate:predicate];
    
    
    //    NSArray *list = [ActionButtons where:predicate];
    //
    //
    //    //NSArray * list          = [ActionButtons MR_findAllWithPredicate:predicate];
    //
    //    ActionButtons * actionButtons = nil;
    //
    //    if ([list count] > 0 ) {
    //        actionButtons       = (ActionButtons *)[list objectAtIndex:0];
    //    }
    
    
    return actionButtons;
}

+(void) deleteAllActions{
    
    
    NSFetchRequest *actionsRequest = [[NSFetchRequest alloc] init];
    [actionsRequest setEntity:[NSEntityDescription entityForName:@"ActionButtons" inManagedObjectContext:[PSPointSystemAction sharedAction].managedObjectContext]];
    [actionsRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *actions = [[PSPointSystemAction sharedAction].managedObjectContext executeFetchRequest:actionsRequest error:&error];
    //error handling goes here
    for (NSManagedObject *action in actions) {
        [[PSPointSystemAction sharedAction].managedObjectContext deleteObject:action];
    }
    NSError *saveError = nil;
    [[PSPointSystemAction sharedAction].managedObjectContext save:&saveError];
    
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ActionButtons"];
//    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
//    
//    NSError *deleteError = nil;
//    [[PSPointSystemAction sharedAction].managedObjectContext.persistentStoreCoordinator executeRequest:delete withContext:[PSPointSystemAction sharedAction].managedObjectContext error:&deleteError];
    
    
    //    [ActionButtons deleteAllInContext:[PSPointSystemAction sharedAction].managedObjectContext];
    //
    //    [PSPointSystemAction sharedAction].managedObjectContext dele
    //[ActionButtons save];
    //[ActionButtons MR_truncateAll];
    //[self saveData];
}

+ (void)saveData {
    //    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
    //        if (error) {
    //            NSLog(@"error in saving %@", error);
    //        }else{
    //            NSLog(@"Data saved successfully");
    //        }
    //    }];
}

- (void)saveContext{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

+(NSManagedObject *)getObject:(NSString *)className predicate:(NSPredicate *)predicate{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:className];
    if(predicate)
        fetchRequest.predicate = predicate;
    fetchRequest.fetchLimit = 1;
    NSError *error;
    NSArray *results = [[PSPointSystemAction sharedAction].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (results.count)
        return results[0];
    return nil;
}

@end
