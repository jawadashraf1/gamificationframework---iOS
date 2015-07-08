//
//  ActionButtons+DAO.m
//  Get Hot
//
//  Created by Raheel Ahmad on 24/03/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "ActionButtons+DAO.h"

#import "MagicalRecord.h"

#define MR_SHORTHAND 1

@implementation ActionButtons (DAO)


+(void) saveAction:(PSAction *) action{
    ActionButtons *actionb  = [ActionButtons MR_createEntity];
    actionb.button_id       = action.button_id;
    actionb.identifier      = action.identifier;
    actionb.points          = action.points;
    actionb.action_type     = action.action_type;
    actionb.is_badge        = action.is_badge;
    actionb.user_id         = action.user_id;
    actionb.button_tag      = action.button_tag;
    [self saveData];
}

+(ActionButtons *) getActionInfo:(NSString *) identifier user_id:(NSNumber *) user_id{
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(identifier = %@) AND (user_id = %@)",identifier,user_id];
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"button_tag = %@",user_id];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"identifier ==[c] %@",identifier];
    NSArray * list          = [ActionButtons MR_findAllWithPredicate:predicate];
    
    ActionButtons * actionButtons = nil;
    
    if ([list count] > 0 ) {
        actionButtons       = (ActionButtons *)[list objectAtIndex:0];
    }
    
    return actionButtons;
}

+(void) deleteAllActions{
    [ActionButtons MR_truncateAll];
}

+ (void)saveData {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (error) {
            NSLog(@"error in saving %@", error);
        }else{
            NSLog(@"Data saved successfully");
        }
    }];
}

@end
