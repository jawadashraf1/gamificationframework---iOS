//
//  PSActionButton.m
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAction.h"
#import "ActionButtons+DAO.h"

static NSTimer *timer;


@implementation PSAction



+(void) loadAllActions{
    [self getAllActions];
    [self pollingActions];
}

+(void) pollingActions{
    
    if(timer){
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(getAllActions) userInfo:nil repeats:YES];
    
}

+(void) getAllActions{
    
    NSLog(@"Getting Actions..........");
    
    [self getButtonActions:^(id object, NSString *error) {
        if(object){
            NSLog(@"All Actions saved locally");
        }
    }];
}


+(void) getButtonActions:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    [self sendRequest:PS_API_GET_BUTTON_ACTIONS paramName:PS_PARAM_ACTIONS parameters:parameters data:nil completion:^(id object, NSString *error) {
        if(object){
            
            //Deleting actions from local db
            [self deleteActions];
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            NSMutableArray *psJsonArray = (NSMutableArray *) object;
            
            for(NSDictionary *dictionary in psJsonArray){
                PSAction *actionButton  = [[PSAction alloc] initUsingData:dictionary];
                actionButton.user_id    = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
                [dataArray addObject:actionButton];
                [self saveAction:actionButton];
            }
            
            completion(dataArray, nil);
        } else {
            completion(nil,error);
        }
    }];
}

+(void) addAction:(NSNumber *) action_id info_id:(NSNumber *)info_id points:(NSNumber *) points completion:(void (^)(id object,NSString *error))completion{
    
    NSMutableDictionary *parameters = [self getDefaultParams];
    
    [parameters setObject:action_id forKey:PS_PARAM_ACTION_ID];
    [parameters setObject:info_id   forKey:PS_PARAM_INFO_ID];
    [parameters setObject:points    forKey:PS_PARAM_POINTS];
    [parameters setObject:[PSDateTimeUtil getCurrentFormatedDate] forKey:PS_PARAM_CREATED_DATE];
    
    
    [self sendRequest:PS_API_ADD_ACTION paramName:PS_PARAM_INFO parameters:parameters data:nil completion:^(id object, NSString *error) {
        if(object){
            NSDictionary *dictionary = (NSDictionary *) object;
            PSActionResponse *response = [[PSActionResponse alloc] initUsingData:dictionary];
            completion(response, nil);
        } else {
            completion(nil,error);
        }
    }];
}


+(PSAction *) getActionInfo:(NSString *) identifier user_id:(NSNumber *) user_id{
    PSAction *actionTemp        = [[PSAction alloc] init];
    ActionButtons *actionInfo   = [ActionButtons getActionInfo:identifier user_id:user_id];
    actionTemp.button_id        = actionInfo.button_id;
    actionTemp.identifier       = actionInfo.identifier;
    actionTemp.points           = actionInfo.points;
    actionTemp.action_type      = actionInfo.action_type;
    actionTemp.is_badge         = actionInfo.is_badge;
    actionTemp.button_tag       = actionInfo.button_tag;
    return actionTemp;
}

+(void) saveAction:(PSAction *) action{
    [ActionButtons saveAction:action];
}

+(void) deleteActions {
    [ActionButtons deleteAllActions];
}

@end
