//
//  PSSmilesAPI.m
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/10/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSSmilesAPI.h"

@implementation PSSmilesAPI


+(void) getSmiles:(void (^)(id object,NSString *error))completion{
    
    NSDictionary *parameters = [self getDefaultParams];
    
    if(!parameters){
        return;
    }
    
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


@end
