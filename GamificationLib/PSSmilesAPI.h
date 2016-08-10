//
//  PSSmilesAPI.h
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/10/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSAPI.h"
#import "PSSmilesData.h"


@protocol PSSmilesData
@end


@interface PSSmilesAPI : PSAPI

@property (nonatomic, strong) NSString<Optional> *message;
@property (nonatomic, strong) PSSmilesData<Optional> *data;


+(void) getSmiles:(void (^)(id object,NSString *error))completion;

@end
