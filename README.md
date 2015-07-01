# gamificationframework---iOS

Integrating Gamification Library

	•	Install GamificationLib pods
	•	Include the #import <GamificationLib/GamificationLib.h> in GetHot-Prefix.pch
	•	Initialize PSPointSystemAction class with Secret Key and User Id.


How to make library work with Actions:

	•	Go to admin site and add an Action. http://teensystudios.com/gamification/admin/login
	•	Check for its button_tag parameter after adding an action.
	•	In iOS application, set the button tag with the value in button_tag parameter.
	•	Change the class of button from UIButton to GHActionButton. Thats All.

