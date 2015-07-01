//
//  PSAlertUtil.h
//  Get Hot
//
//  Created by Raheel Ahmad on 13/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSAlertView.h"

@interface PSAlertUtil : NSObject


+(void) showAlertWithMessage:(NSString *) message;
+(void) showCustomAlertView:(NSString *) desc title:(NSString *) title img:(NSString *) img;




@end
