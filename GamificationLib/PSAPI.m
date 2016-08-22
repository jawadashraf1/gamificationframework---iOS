//
//  PSAPI.m
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAPI.h"
#import "PSHTTPClient.h"
#import "PSPointSystemAction.h"
#import "SVHTTPRequest.h"


@implementation PSAPI


-(id)initUsingData:(NSDictionary*)responseJsonDictionary{
    if (self=[super init]) {
        
        NSError *error = nil;
        
        self = [self initWithDictionary:responseJsonDictionary error:&error];
        
        if(error){
            NSLog(@"Error in parsing %@",error.localizedDescription);
        }
    }
    return self;
}

+(void)sendRequest:(NSString *)apiName paramName:(NSString *) paramName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSString *))completion {
    
    
    [[PSHTTPClient sharedClient] sendRequest:apiName paramName:paramName parameters:parameters data:nil completion:^(id responseobject, NSError *error) {
        
        if(!error){
            
            if(responseobject && [responseobject isKindOfClass:[NSDictionary class]]){
            
                NSDictionary *responseDict= (NSDictionary *)responseobject;//[NSJSONSerialization JSONObjectWithData:responseobject options:NSJSONReadingMutableContainers error:nil];
                
                if ([[responseDict objectForKey:PP_PARAM_SUCCESS] boolValue]==true) {
                    id obj = [[responseDict valueForKey:PP_PARAM_DATA] valueForKey:paramName];
                    if(obj!=(id)[NSNull null]){
                        completion (obj,nil);
                    }else{
                        completion (nil,@"No data found");
                    }
                } else{
                    completion (nil,[responseDict valueForKey:PP_PARAM_MESSAGE]);
                }
                
            }
            
        } else {
            completion (nil,error.localizedDescription);
        }
        
    }];
    
//    [[PSHTTPClient sharedClient] postRequestDataWithMethodName:apiName withParameters:apiName withImageData:imgData success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        if ([[responseDict objectForKey:PP_PARAM_SUCCESS] boolValue]==true) {
//            id obj = [[responseDict valueForKey:PP_PARAM_DATA] valueForKey:paramName];
//            if(obj!=(id)[NSNull null]){
//                completion (obj,nil);
//            }else{
//                completion (nil,@"No data found");
//            }
//        } else{
//            completion (nil,[responseDict valueForKey:PP_PARAM_MESSAGE]);
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completion (nil,error.localizedDescription);
//    }];
    
}

+(void)sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters completion:(void (^)(id object, NSString *message))completion {
    
    
    [[PSHTTPClient sharedClient] sendRequest:apiName paramName:nil parameters:parameters data:nil completion:^(id responseobject, NSError *error) {
        
        if(!error){
            
            if([responseobject isKindOfClass:[NSDictionary class]]){
                if([responseobject valueForKey:@"data"]!=(id)[NSNull null]){
                    completion (responseobject,nil);
                } else {
                    completion (nil,@"");
                }
            } else {
            NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseobject options:NSJSONReadingMutableContainers error:nil];
            completion (responseDict,nil);
            }
            
        } else {
            completion (nil,error.localizedDescription);
        }
        
    }];
    
    
//    [[PSHTTPClient sharedClient] postRequestDataWithMethodName:apiName withParameters:parameters withImageData:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        completion (responseDict,nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completion (nil,error.localizedDescription);
//    }];
    
}


+(NSMutableDictionary *) getDefaultParams{
    
    NSString *secTok    = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSNumber *userId    = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *userName  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSNumber *email    = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    
    
    
    if(!secTok){
        return nil;
    }
    
    if(!userId){
        return nil;
    }
    
    if(!userName){
        return nil;
    }
    
    if(!email){
        return nil;
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:secTok forKey:PS_PARAM_TOKEN];
    [parameters setObject:userId forKey:PS_PARAM_USER_ID];
    
    [parameters setObject:userName   forKey:@"username"];
    [parameters setObject:email      forKey:@"email"];
    [parameters setObject:[self getFormattedDate]  forKey:@"created_date"];
    [parameters setObject:[self getDEVICE_LANGUAGE] forKey:@"lang"];
    
    return parameters;
}



+(NSString *)getFormattedDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-M-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [dateFormat stringFromDate:[NSDate date]];
}


+(NSString *)getDEVICE_LANGUAGE{
    
    NSString  *langId = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDictionary *components = [NSLocale componentsFromLocaleIdentifier:langId];
    NSString *languageDesignator = components[NSLocaleLanguageCode];
    
    if([languageDesignator isEqualToString:@"el"]){
        return languageDesignator;
    } else if([languageDesignator isEqualToString:@"ar"]){
        return languageDesignator;
    } else {
        return @"en";
    }
}


@end
