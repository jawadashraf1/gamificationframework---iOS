//
//  PSHTTPClient.h
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVHTTPRequest.h"

@interface PSHTTPClient:NSObject


+(PSHTTPClient *) sharedClient;

//-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data
//                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters withImageData:(NSData*)data keyword:(NSString *)dataKeyword
//                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters
//                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void)sendRequest:(NSString *)apiName paramName:(NSString *) paramName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSError *error))completion ;

@end
