# gamificationframework---iOS

pod 'GamificationLib'

Integrating Gamification Library

	•	Install GamificationLib pods
	•	Include the #import <GamificationLib/GamificationLib.h> in GetHot-Prefix.pch
	•	Initialize PSPointSystemAction class with Secret Key and User Id.
	
	[[PSPointSystemAction sharedAction] initWithKey:@"GAMIFICATION_KEY" andUserId:@"USER_ID" andUserName:@"USER_Name" andEmail:@"USER_Email"];
	
 
How to make library work with Actions:

	•	Go to admin site and add an Action. http://teensystudios.com/gamification/admin/login
	•	Check for its Action Identifier after adding an action.
	•	In iOS application, write the Button Action Method with the name of Action Identifier.
	•	In this method, call the method [[PSPointSystemAction sharedAction] performActionToLog].
	•	Thats All.


Example:

	-(void)EXERCISE_ACTION {
    		[[PSPointSystemAction sharedAction] performActionToLog];
	}


Get user earned Badges:

    [PSUserBadgesAndLevels getUserBadgesAndLevels:YES completion:^(id object, NSString *error) {
    }];

Get Badges detail:

    [PSLevelInfo getLevelsInfo:^(id object, NSString *error) { 
    }];
