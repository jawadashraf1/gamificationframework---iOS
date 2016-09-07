//
//  PSLevelInfo.h
//  Get Hot
//
//  Created by Raheel Ahmad on 23/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAPI.h"

@interface PSLevelInfo : PSAPI

@property (nonatomic, strong) NSNumber<Optional> * level_id;
@property (nonatomic, strong) NSString<Optional> * level_name;
@property (nonatomic, strong) NSString<Optional> * level_desc;
@property (nonatomic, strong) NSString<Optional> * level_img;
@property (nonatomic, strong) NSNumber<Optional> * level_total_points;
@property (nonatomic, strong) NSNumber<Optional> * level_earned_points;
@property (nonatomic, strong) NSNumber<Optional> * is_latest_level_earn;
@property (nonatomic, strong) NSString<Optional> * level_title;
@property (nonatomic, strong) NSString<Optional> * level_sub_title;
@property (nonatomic, strong) NSNumber<Optional> * current_smiles;
+(void) getLevelsInfo:(void (^)(id object,NSString *error))completion;

@end
