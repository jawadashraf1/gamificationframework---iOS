//
//  ActionButtons.h
//  Get Hot
//
//  Created by Raheel Ahmad on 24/03/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface ActionButtons : NSManagedObject

@property (nonatomic, retain) NSNumber * button_id;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) NSNumber * action_type;
@property (nonatomic, retain) NSNumber * is_badge;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSNumber * button_tag;

@end
