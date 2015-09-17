//
//  PSAPI.h
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//


#import "JSONModel.h"
#import "PSPointsSystemConstant.h"


@interface PSAPI : JSONModel

-(id)initUsingData:(NSDictionary*) responseJsonDictionary;



+(void) sendRequest:(NSString *) apiName paramName:(NSString *) paramName parameters:(NSDictionary *) parameters data:(NSData *) imgData completion:(void (^)(id object,NSString *message))completion;
+(void) sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSString * message))completion;
+(void) sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters keyword:(NSString *) keyword data:(NSData *)imgData completion:(void (^)(id object, NSString *message))completion;

+(void)sendRequest:(NSString *)apiName parameters:(NSDictionary *)parameters completion:(void (^)(id object, NSString *message))completion;

+(NSMutableDictionary *) getDefaultParams;

@end
