//
//  PSSmilesAPI.m
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/10/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSSmilesAPI.h"

@implementation PSSmilesAPI


+(void) getSmiles:(NSNumber *) is_profile_list type:(NSString *) type  completion:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    if(!parameters){
        return;
    }
    
    [parameters setValue:is_profile_list forKey:@"is_profile_list"];
    [parameters setValue:type forKey:@"smile_type"];
    [self sendRequest:PS_API_GET_SMILES parameters:parameters completion:^(id object, NSString *error) {
        if(object){
            
            NSDictionary *psJsonArray = (NSDictionary *) object;
            NSError *errorTemp;
            
            PSSmilesAPI *smiles = [[PSSmilesAPI alloc] initWithDictionary:psJsonArray error:&errorTemp];
            if(smiles.data){
                completion(smiles.data, nil);
            } else{
                completion(nil, errorTemp.localizedDescription);
            }
            
        } else {
            completion(nil,error);
        }
    }];
}


+(void) getSmilesBurnForStoreListing:(void (^)(id object,NSString *error))completion{
    [self getSmiles:[NSNumber numberWithBool:YES] type:@"BURN" completion:completion];
}


@end
