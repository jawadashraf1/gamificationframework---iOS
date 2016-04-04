//
//  PSHTTPClient.m
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#define POINT_SYSTEM_URL @"points_system_url"

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
        NSString *pointsSystemUrl = @"http://gamificationlabs.teensystudios.com/gamification/web/"; // [self getStringFromPlistWithKey:POINT_SYSTEM_URL];
        NSLog(@"POINTS SYSTEM URL %@",pointsSystemUrl);
        _sharedClient = [[PSHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:pointsSystemUrl]];
    });
    return _sharedClient;
}
-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dictParam  = [[NSMutableDictionary  alloc] initWithDictionary:parameters];
    NSString * language             = [[NSLocale preferredLanguages] objectAtIndex:0];
    [dictParam setObject:language forKey:@"lang"];
    
    if (data==nil) {
        [self POST:methodName parameters:dictParam success:success failure:failure];
    }else{
        [self POST:methodName parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"user_img" fileName:@"user_img.png" mimeType:@"image/png"];
        }
           success:success failure:failure];
    }
}
-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data keyword:(NSString *)dataKeyword
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dictParam  = [[NSMutableDictionary  alloc] initWithDictionary:parameters];
    NSString * language             = [[NSLocale preferredLanguages] objectAtIndex:0];
    [dictParam setObject:language forKey:@"lang"];
    
    if (data==nil) {
        [self POST:methodName parameters:dictParam success:success failure:failure];
    }else{
        [self POST:methodName parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:dataKeyword fileName:[NSString stringWithFormat:@"%@.png", dataKeyword] mimeType:@"image/png"];
        }
           success:success failure:failure];
    }
}
-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    [self.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dictParam  = [[NSMutableDictionary  alloc] initWithDictionary:parameters];
    NSString * language             = [[NSLocale preferredLanguages] objectAtIndex:0];
    [dictParam setObject:language forKey:@"lang"];
    
    [self GET:methodName parameters:dictParam success:success failure:failure];
    
}


@end
