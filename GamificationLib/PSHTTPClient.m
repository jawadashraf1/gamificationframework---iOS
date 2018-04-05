//
//  PSHTTPClient.m
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

//#define POINT_SYSTEM_URL @"https://gamification.theentertainerme.com/web/"

#import "PSHTTPClient.h"



@implementation PSHTTPClient

+(NSString*)getStringFromPlistWithKey:(NSString*)key{
    NSBundle* bundle = [NSBundle mainBundle];
    return bundle.infoDictionary[key];
}

+(PSHTTPClient *) sharedClient{
    static PSHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PSHTTPClient alloc] init];
    });
    return _sharedClient;
}

-(void)sendRequest:(NSString *)apiName paramName:(NSString *) paramName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSError *error))completion {
    
    NSMutableDictionary *dictParam  = [[NSMutableDictionary  alloc] initWithDictionary:parameters];
    NSString * language             = [[NSLocale preferredLanguages] objectAtIndex:0];
    [dictParam setObject:language forKey:@"lang"];
    
    NSString *systemUrl = @"";
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"]){
       systemUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"];
    } else {
       systemUrl = @"http://gamificationlabs.teensystudios.com/gamification/web/";//[PSHTTPClient getStringFromPlistWithKey:@"points_system_url"];
    }
    
    NSString *url = [systemUrl stringByAppendingPathComponent:apiName];
    
    
    SVHTTPClient *client = [SVHTTPClient sharedClient];
    
    [client setBasicAuthWithUsername:[[NSUserDefaults standardUserDefaults] valueForKey:@"bUser"] password:[[NSUserDefaults standardUserDefaults] valueForKey:@"bPwd"]];
    
    [client POST:url parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(!error){
            completion(response,nil);
        } else {
            completion (nil,error);
        }
    }];
    
}


@end
