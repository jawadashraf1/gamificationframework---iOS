//
//  PSHTTPClient.h
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface PSHTTPClient : AFHTTPRequestOperationManager


+(PSHTTPClient *) sharedClient;

-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data keyword:(NSString *)dataKeyword
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
