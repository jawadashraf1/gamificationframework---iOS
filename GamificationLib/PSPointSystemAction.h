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
    kGENERTIC=2,
    kSMILES=3
    
}kActionTypes;


#import <Foundation/Foundation.h>
#import "PSUserBadgesAndLevels.h"
#import <CoreData/CoreData.h>
#import "PSActionResponse.h"

@interface PSPointSystemAction : NSObject

@property (nonatomic, strong) NSDictionary *dictActions;

@property (nonatomic, strong) NSString *selectedButtonAction;
@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *baseUrl;

@property (nonatomic, strong) NSString *b_uname;
@property (nonatomic, strong) NSString *b_pwd;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(id)initWithKey:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email;
-(void) setKeyInfo:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email;
-(void) setKeyInfo:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email baseUrl:(NSString *)baseUrl;
+(PSPointSystemAction *) sharedAction;
-(void)performActionToLog:(NSString *) identifierTemp params:(NSMutableDictionary *) params completionAction:(void (^)(bool success))completionAction;
-(void)getAllLeaderBoardsWithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler ;
-(void)getLeaderBoardsDetailsForId:(NSString *)leaderboardId WithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler;
-(void)performActionToLog:(NSString *) identifierTemp params:(NSMutableDictionary *) params showDefaultAlert:(BOOL) showDefaultAlert completionAction:(void (^)(bool success,PSActionResponse *response))completionAction;
-(void) setKeyInfo:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email baseUrl:(NSString *)baseUrl b_user:(NSString *) b_user b_password:(NSString *) b_password;

@end
