//
//  PSBadgesInfo.h
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/8/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSAPI.h"

@interface PSBadgesInfo : PSAPI

@property (nonatomic, strong) NSString<Optional> * name;
@property (nonatomic, strong) NSString<Optional> * desc;
@property (nonatomic, strong) NSString<Optional> * image_url;
@property (nonatomic, strong) NSNumber<Optional> * is_earned;
@property (nonatomic, strong) NSNumber<Optional> * current_smiles;


+(void) getBadgesInfo:(void (^)(id object,NSString *error))completion;

@end
