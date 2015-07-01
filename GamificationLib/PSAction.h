//
//  PSActionButton.h
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAPI.h"
#import "PSActionResponse.h"
#import "PSDateTimeUtil.h"


@interface PSAction : PSAPI

@property (nonatomic, strong) NSNumber<Optional> * button_id;
@property (nonatomic, strong) NSNumber<Optional> * points;
@property (nonatomic, strong) NSNumber<Optional> * action_type;
@property (nonatomic, strong) NSNumber<Optional> * is_badge;
@property (nonatomic, strong) NSString<Optional> * identifier;
@property (nonatomic, strong) NSNumber<Ignore> * user_id;
@property (nonatomic, strong) NSNumber<Optional> * button_tag;



+(void) loadAllActions;
+(PSAction *) getActionInfo:(NSString *) identifier user_id:(NSNumber *) user_id;
+(void) addAction:(NSNumber *) action_id info_id:(NSNumber *)info_id points:(NSNumber *) points completion:(void (^)(id object,NSString *error))completion;

@end
