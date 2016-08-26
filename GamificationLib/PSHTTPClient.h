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

+(NSString*)getStringFromPlistWithKey:(NSString*)key;
-(void)sendRequest:(NSString *)apiName paramName:(NSString *) paramName parameters:(NSDictionary *)parameters data:(NSData *)imgData completion:(void (^)(id object, NSError *error))completion ;

@end
