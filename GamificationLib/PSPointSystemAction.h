//
//  PSPointSystemAction.h
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

typedef enum {
    // Not associated with levels etc
    kSTANDALONE=1,
    // Associated with levels and missions
    kGENERTIC=2
    
}kActionTypes;


#import <Foundation/Foundation.h>
#import "PSUserBadgesAndLevels.h"

@interface PSPointSystemAction : NSObject

@property (nonatomic, strong) NSDictionary *dictActions;

@property (nonatomic, strong) NSString *selectedButtonAction;
@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSNumber *userId;


-(id)initWithKey:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId;
+(PSPointSystemAction *) sharedAction;
-(void)performActionToLog;
-(void) performAction:(NSString *) action;

@end
