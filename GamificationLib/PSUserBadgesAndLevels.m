//
//  GHUserBadgesAndLevels.m
//  Get Hot
//
//  Created by Raheel Ahmad on 14/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSUserBadgesAndLevels.h"

@implementation PSUserBadgesAndLevels


+(void) getUserBadgesAndLevels:(BOOL) isDeleteExisting completion:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    [self sendRequest:PS_API_GET_BADGES_AND_LEVELS paramName:PS_PARAM_BADGES_LEVELS parameters:parameters data:nil completion:^(id object, NSString *message) {
        
        if(object){
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            NSMutableArray *statsJsonArray = (NSMutableArray *) object;
            
            for(NSDictionary *dictionary in statsJsonArray){
                PSUserBadgesAndLevels *stat = [[PSUserBadgesAndLevels alloc] initUsingData:dictionary];
                [dataArray addObject:stat];
            }
            completion(dataArray,nil);
        } else {
            completion(nil,message);
        }
        
    }];
}


@end
