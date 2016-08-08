//
//  PSBadgesInfo.m
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/8/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSBadgesInfo.h"

@implementation PSBadgesInfo

+(void) getBadgesInfo:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    if(!parameters){
        return;
    }
    
    [self sendRequest:PS_API_GET_BADGES_INFO parameters:parameters completion:^(id object, NSString *error) {
        if(object){
            
            
            NSDictionary *dictionary = (NSDictionary *) object;
            
            NSArray * lockedbadges = [[dictionary valueForKey:@"data"] valueForKey:@"lockedbadges"];
            NSArray * unlockedbadges = [[dictionary valueForKey:@"data"] valueForKey:@"unlockedbadges"];
            
            NSMutableArray *lockedBadgesArray = [[NSMutableArray alloc] init];
            NSMutableArray *unlockedBadgesArray = [[NSMutableArray alloc] init];
            
            
            if(lockedbadges){
                for(NSDictionary *dicl in lockedbadges){
                    PSBadgesInfo *badge = [[PSBadgesInfo alloc] initUsingData:dicl];
                    [lockedBadgesArray addObject:badge];
                    
                }
            }
            
            
            if(unlockedbadges){
                for(NSDictionary *dicul in unlockedbadges){
                    PSBadgesInfo *badge = [[PSBadgesInfo alloc] initUsingData:dicul];
                    [unlockedBadgesArray addObject:badge];
                }
            }
            completion(@[unlockedBadgesArray,lockedBadgesArray], nil);
        } else {
            completion(nil,error);
        }
    }];
}

@end
