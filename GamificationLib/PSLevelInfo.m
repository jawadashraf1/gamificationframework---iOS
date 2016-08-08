//
//  PSLevelInfo.m
//  Get Hot
//
//  Created by Raheel Ahmad on 23/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSLevelInfo.h"

@implementation PSLevelInfo


+(void) getLevelsInfo:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    if(!parameters){
        return;
    }
    
    [self sendRequest:PS_API_GET_LEVELS_INFO paramName:PS_PARAM_LEVELS parameters:parameters data:nil completion:^(id object, NSString *error) {
        if(object){
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            NSMutableArray *psJsonArray = (NSMutableArray *) object;
            
            for(NSDictionary *dictionary in psJsonArray){
                PSLevelInfo *level = [[PSLevelInfo alloc] initUsingData:dictionary];
                [dataArray addObject:level];
            }
            
            completion(dataArray, nil);
        } else {
            completion(nil,error);
        }
    }];
}


@end
