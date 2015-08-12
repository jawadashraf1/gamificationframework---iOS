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
#import "MagicalRecord.h"

@implementation PSPointSystemAction


-(id)initWithKey:(NSString *)z_SecretKey andUserId:(NSNumber *)z_userId{
    self = [super init];
    if (self) {
        //Setting up Magical Record to Data Saving
        [MagicalRecord setupCoreDataStack];
        self.secretKey              = z_SecretKey;
        self.userId                 = z_userId;
        [self saveSecretKeyAndUserId];
        [PSAction loadAllActions];
    }
    return self;
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


@end
