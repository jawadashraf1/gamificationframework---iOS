//
//  AllActionsView.h
//  GamificationLib
//
//  Created by Azeem Akram on 7/9/15.
//  Copyright (c) 2015 EurekaTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAPI.h"
#import "PSPointSystemAction.h"

@protocol AllActionViewDelegate <NSObject>

-(void)allActionView:(id)view didCancelButtonPressed:(BOOL)btnPressed;

@end


@interface AllActionsView : UIView <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) id <AllActionViewDelegate>delegate;

-(id)initWithNib;

@property (weak, nonatomic) IBOutlet UINavigationBar    *navbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *leftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *rightButton;

@property (weak, nonatomic) IBOutlet UIView             *viewAllActions;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView        *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel            *lblNoActionFound;
@property (weak, nonatomic) IBOutlet UITableView        *tableviewActions;

@property (weak, nonatomic) IBOutlet UIView             *viewAddNewAction;
@property (weak, nonatomic) IBOutlet UITextField        *tfAction;
@property (weak, nonatomic) IBOutlet UITextField        *tfPoint;

@end
