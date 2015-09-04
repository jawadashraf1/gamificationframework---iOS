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
    
    [[PSHTTPClient sharedClient] postRequestDataWithMethodName:apiName withParameters:parameters withImageData:imgData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
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
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion (nil,error.localizedDescription);
    }];
    
}

+(void)sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSString *message))completion {
    
    [[PSHTTPClient sharedClient] postRequestDataWithMethodName:apiName withParameters:parameters withImageData:imgData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[responseDict objectForKey:PP_PARAM_SUCCESS] boolValue]==true) {
            completion ([responseDict valueForKey:PP_PARAM_MESSAGE],nil);
        } else{
            completion (nil,[responseDict valueForKey:PP_PARAM_MESSAGE]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion (nil,error.localizedDescription);
    }];
    
}

+(void)sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters keyword:(NSString *) keyword data:(NSData *)imgData completion:(void (^)(id object, NSString *message))completion {
    
    [[PSHTTPClient sharedClient] postRequestDataWithMethodName:apiName withParameters:parameters withImageData:imgData keyword:keyword success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[responseDict objectForKey:PP_PARAM_SUCCESS] boolValue]==true) {
            completion ([responseDict valueForKey:PP_PARAM_MESSAGE],nil);
        } else{
            completion (nil,[responseDict valueForKey:PP_PARAM_MESSAGE]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion (nil,error.localizedDescription);
    }];
    
}

+(NSMutableDictionary *) getDefaultParams{
    
    NSString *secTok    = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSNumber *userId    = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:secTok forKey:PS_PARAM_TOKEN];
    [parameters setObject:userId forKey:PS_PARAM_USER_ID];
    
    [parameters setObject:[PSPointSystemAction sharedAction].userName   forKey:@"username"];
    [parameters setObject:[PSPointSystemAction sharedAction].email      forKey:@"email"];
    
    return parameters;
}

@end
