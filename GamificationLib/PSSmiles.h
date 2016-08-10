//
//  PSSmiles.h
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/10/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSAPI.h"

@interface PSSmiles : PSAPI

@property (nonatomic, strong) NSNumber<Optional> *app_action_id;
@property (nonatomic, strong) NSNumber<Optional> *smile_points;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *reward_name;
@property (nonatomic, strong) NSString<Optional> *smile_desc;
@property (nonatomic, strong) NSNumber<Optional> *show_buy_button;

@property (nonatomic, strong) NSDictionary<Optional> *apiparams;


@end
