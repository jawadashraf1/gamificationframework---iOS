# gamificationframework---iOS

Integrating Gamification Library

	•	Install GamificationLib pods
	•	Include the #import <GamificationLib/GamificationLib.h> in GetHot-Prefix.pch
	•	Initialize PSPointSystemAction class with Secret Key and User Id.


How to make library work with Actions:

	•	Let the admin add an Action.
	•	Check for its button_tag parameter while loading all actions.
	•	In iOS application, set the button tag with the value in button_tag parameter.
	•	Change the class of button from UIButton to GHActionButton

