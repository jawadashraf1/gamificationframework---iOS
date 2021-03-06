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
#import <CoreData/CoreData.h>

@interface PSPointSystemAction : NSObject

@property (nonatomic, strong) NSDictionary *dictActions;

@property (nonatomic, strong) NSString *selectedButtonAction;
@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *email;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(id)initWithKey:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email;
-(void) setKeyInfo:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email;
+(PSPointSystemAction *) sharedAction;
-(void)performActionToLog:(NSString *) identifierTemp params:(NSMutableDictionary *) params completionAction:(void (^)(bool success))completionAction;
-(void)getAllLeaderBoardsWithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler ;
-(void)getLeaderBoardsDetailsForId:(NSString *)leaderboardId WithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler;
@end
