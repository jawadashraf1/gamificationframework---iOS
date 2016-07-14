//
//  PSPointSystemAction.m
//  Get Hot
//
//  Created by Raheel Ahmad on 08/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSPointSystemAction.h"
#import "PSAlertUtil.h"
#import "PSAction.h"
//#import "ObjectiveRecord.h"
//#import <MagicalRecord/MagicalRecord.h>

@implementation PSPointSystemAction


-(id)initWithKey:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email{
    self = [super init];
    if (self) {
        //Setting up Magical Record to Data Saving
//        [MagicalRecord setupCoreDataStack];
//        [CoreDataManager sharedManager].modelName = @"GamificationLib";
//        [CoreDataManager sharedManager].databaseName = @"GamificationLib";
        self.secretKey              = z_SecretKey;
        self.userId                 = z_userId;
        self.userName               = z_UserName;
        self.email                  = z_Email;
        [self saveSecretKeyAndUserId];
        [PSAction loadAllActions];
    }
    return self;
}


-(void) setKeyInfo:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId andUserName:(NSString *)z_UserName andEmail:(NSString *)z_Email{
        //Setting up Magical Record to Data Saving
//        [MagicalRecord setupCoreDataStack];
//        [CoreDataManager sharedManager].modelName = @"GamificationLib";
//        [CoreDataManager sharedManager].databaseName = @"GamificationLib";
        self.secretKey              = z_SecretKey;
        self.userId                 = z_userId;
        self.userName               = z_UserName;
        self.email                  = z_Email;
        [self saveSecretKeyAndUserId];
        [PSAction loadAllActions];
    
}

//** Read Plist file from Main Bundle to get Array of its contents
- (NSDictionary *)getDictionaryFromPlistFileWithName:(NSString *)fileName {
    
    NSString *path                  = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *dictContents      = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictContents;
}


+(PSPointSystemAction *) sharedAction{
    static PSPointSystemAction *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient               = [[PSPointSystemAction alloc] init];
    });
    return _sharedClient;
}

-(NSString *) getParentMethoName{
    
    NSArray *callStack      = [NSThread callStackSymbols];
    NSString *sourceString  = [callStack objectAtIndex:2];
    NSRange start           = [sourceString rangeOfString:@"["];
    NSRange end             = [sourceString rangeOfString:@"]"];
    sourceString            = [sourceString substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
    NSArray *array          = [sourceString componentsSeparatedByString:@" "];
    NSString *parentMethodName = array[1];
    if([parentMethodName rangeOfString:@":"].location != NSNotFound) {
        parentMethodName = [parentMethodName substringToIndex:[parentMethodName rangeOfString:@":"].location];
    }
    NSLog(@"%@" , parentMethodName);
    return parentMethodName;
}

//-(void)performActionWithKey:(int)key
-(void)performActionToLog:(NSString *) identifierTemp{
//    NSString *actionIdentifier      = [self.dictActions objectForKey:[NSString stringWithFormat:@"%d",key]];
//    [self performAction:actionIdentifier];
    
    NSString *identifier            = identifierTemp;
    PSAction * selectedActionInfo   = [PSAction getActionInfo:identifier   user_id:[NSNumber numberWithInt:0]];
    kActionTypes actionType         = (kActionTypes)[selectedActionInfo.action_type integerValue];
    
    if ((actionType == kSTANDALONE && [selectedActionInfo.is_badge intValue] == 0) || actionType == kGENERTIC) {
        NSLog(@"Action: %@",selectedActionInfo.identifier);
        [self sendAction:selectedActionInfo];
    }
}

-(void)saveSecretKeyAndUserId{
    [[NSUserDefaults standardUserDefaults] setObject:self.secretKey forKey:@"secretKey"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userId    forKey:@"userId"];
    self.dictActions                = [[NSDictionary alloc] init];
    self.dictActions                = [self getDictionaryFromPlistFileWithName:@"ActionButtonsStrings"];
}


-(void) performAction:(NSString *) action{
//    self.selectedButtonAction       =  action;
//    PSAction * selectedActionInfo   = [PSAction getActionInfo:action user_id:self.userId];
//    kActionTypes actionType         = (kActionTypes)[selectedActionInfo.action_type integerValue];
//
//    if ((actionType == kSTANDALONE && [selectedActionInfo.is_badge intValue] == 0) || actionType == kGENERTIC) {
//        NSLog(@"Action: %@",action);
//        [self sendAction:selectedActionInfo];
//    }
}

-(void) sendAction:(PSAction *) actionInfo {
    [PSAction addAction:[NSNumber numberWithInt:[actionInfo.action_type intValue]] info_id:actionInfo.button_id points:actionInfo.points completion:^(id object, NSString *error) {
        
        PSActionResponse *response  = (PSActionResponse *) object;
        if(response && [response.alert intValue]){
            [self performSelectorOnMainThread:@selector(showCustomViewMessage:) withObject:response waitUntilDone:YES];
        }
    }];
}

-(void) showCustomViewMessage:(PSActionResponse *) response{
    [PSAlertUtil showCustomAlertView:response.message title:response.title subTitle:response.subTitle img:response.img];
}





-(void)getAllLeaderBoardsWithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler {
    [PSAction getLeaderboardsWithCompletionHandler:^(NSString *err, NSArray *arr) {
        if (err.length > 0) {
            [PSAlertUtil showCustomAlertView:err title:@"Error" subTitle:nil img:nil];
        }
        handler (err, arr);
    }];
}


-(void)getLeaderBoardsDetailsForId:(NSString *)leaderboardId WithCompletionHandler:(void (^)(NSString *error, NSArray *arrayLeaderboards))handler {
    [PSAction getUsersForLeaderboard:leaderboardId WithCompletionHandler:^(NSString *err, NSArray *arr) {
        if (err.length > 0) {
            [PSAlertUtil showCustomAlertView:err title:@"Error" subTitle:nil img:nil];
        }
        handler (err, arr);
    }];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sultanete.Muslim_Matcher" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GamificationLib_db" withExtension:@"momd"];
    
    if(modelURL == nil){
        modelURL = [[NSBundle mainBundle] URLForResource:@"/Frameworks/GamificationLib.framework/GamificationLib_db" withExtension:@"momd"];
        
    }
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GamificationLib_db.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}





@end
