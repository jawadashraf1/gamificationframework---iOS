//
//  ActionButtons+DAO.h
//  Get Hot
//
//  Created by Raheel Ahmad on 24/03/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "ActionButtons.h"
#import "PSAction.h"

@interface ActionButtons (DAO)


+(void) saveAction:(PSAction *) action;
+(ActionButtons *) getActionInfo:(NSString *) identifier user_id:(NSNumber *) user_id;
+(void) deleteAllActions;

@end
