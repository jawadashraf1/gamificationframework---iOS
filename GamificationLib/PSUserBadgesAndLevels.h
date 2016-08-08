//
//  GHUserBadgesAndLevels.h
//  Get Hot
//
//  Created by Raheel Ahmad on 14/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PSAPI.h"
#import "PSPointsSystemConstant.h"

@interface PSUserBadgesAndLevels : PSAPI

//@property (nonatomic, strong) NSNumber<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * name;
@property (nonatomic, strong) NSString<Optional> * image;
@property (nonatomic, strong) NSNumber<Optional> * is_badge;
@property (nonatomic, strong) NSNumber<Optional> * points;
@property (nonatomic, strong) NSString<Optional> * pointslbl;

+(void) getUserBadgesAndLevels:(BOOL) isDeleteExisting completion:(void (^)(id object,NSString *error))completion;
+(void) getUserEarnedBadgeAndLevel:(void (^)(id object,NSString *error))completion;

@end
