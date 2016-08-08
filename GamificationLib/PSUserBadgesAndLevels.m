//
//  GHUserBadgesAndLevels.m
//  Get Hot
//
//  Created by Raheel Ahmad on 14/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSUserBadgesAndLevels.h"
#import "PSBadgesInfo.h"

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


+(void) getUserEarnedBadgeAndLevel:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    if(!parameters){
        return;
    }
    
    [self sendRequest:PS_API_GET_USER_EARNED_LEVEL_BADGE parameters:parameters completion:^(id object, NSString *error) {
        if(object){
            
            
            NSDictionary *dictionary = (NSDictionary *) object;
            
            NSDictionary * earnedBadgeInfo = [[dictionary valueForKey:@"data"] valueForKey:@"latestearnbadge"];
            NSDictionary * earnedLevelInfo = [[dictionary valueForKey:@"data"] valueForKey:@"latestearnlevel"];
            
            NSMutableArray *earnedBadgesArray = [[NSMutableArray alloc] init];
            NSMutableArray *earnedLevelsArray = [[NSMutableArray alloc] init];
            
            if(earnedBadgeInfo){
                PSBadgesInfo *badge = [[PSBadgesInfo alloc] initUsingData:earnedBadgeInfo];
                [earnedBadgesArray addObject:badge];
            }
            
            if(earnedLevelInfo){
                PSBadgesInfo *badge = [[PSBadgesInfo alloc] initUsingData:earnedLevelInfo];
                [earnedLevelsArray addObject:badge];
            }
            
            completion(@[earnedLevelsArray,earnedBadgesArray], nil);
        } else {
            completion(nil,error);
        }
    }];
}



@end
