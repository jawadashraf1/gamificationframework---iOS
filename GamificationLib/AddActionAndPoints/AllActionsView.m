//
//  AllActionsView.m
//  GamificationLib
//
//  Created by Azeem Akram on 7/9/15.
//  Copyright (c) 2015 EurekaTechStudio. All rights reserved.
//

#import "AllActionsView.h"

@implementation AllActionsView{
    NSArray *arrayActions;
    PSAPI *api;
    
}


-(id)initWithNib {
    self    = [[[NSBundle mainBundle] loadNibNamed:@"AllActions" owner:self options:nil] objectAtIndex:0];
    if (self) {
        [self setView];
    }
    
    return self;
}

-(void)setView{
    CGRect allActionsRect    		= self.viewAllActions.frame;
    allActionsRect.origin.x          = 0;
    self.viewAllActions.frame     = allActionsRect;
    
    CGRect viewAddNewActionRect 	= self.viewAddNewAction.frame;
    viewAddNewActionRect.origin.x   = self.frame.size.width;
    self.viewAddNewAction.frame     = viewAddNewActionRect;
    
    self.layer.cornerRadius         = 5.0;
    self.clipsToBounds              = YES;
    
    
    self.lblNoActionFound.hidden    = YES;
    self.tableviewActions.hidden    = YES;
    self.activityIndicator.hidden   = NO;
    
    
    api                             = [[PSAPI alloc] init];
    [self getAllActions];
}



-(void)getAllActions{
    [PSAPI sendRequest:@"get_user_action" paramName:@"actions" parameters:@{@"token": [PSPointSystemAction sharedAction].secretKey} data:nil completion:^(id object, NSString *message) {
        arrayActions    = (NSArray *)object;
        
        if (arrayActions.count > 0) {
            self.lblNoActionFound.hidden    = YES;
            self.activityIndicator.hidden   = YES;
            self.tableviewActions.hidden    = NO;
            [self.tableviewActions reloadData];
        }else{
            self.lblNoActionFound.hidden    = NO;
            self.tableviewActions.hidden    = YES;
            self.activityIndicator.hidden   = YES;
        }
    }];
}


-(void)addActionWithActionName:(NSString *)actionName andPoints:(NSString *)points{
    
    if (actionName.length > 0 && [points intValue] > 0) {
        NSDictionary *dictParam = @{@"token": [PSPointSystemAction sharedAction].secretKey,
                                    @"action_name": actionName,
                                    @"points": points
                                    };
        
        [PSAPI sendRequest:@"add_user_action" paramName:@"actions" parameters:dictParam data:nil completion:^(id object, NSString *message) {
            
            if (message.length > 0) {
                UIAlertView *av  = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [av show];
                [self.tfAction becomeFirstResponder];
            }else{
                self.tfPoint.text   = @"";
                self.tfAction.text  = @"";

                [self btnBack_Action:nil];
                [self getAllActions];
            }
        }];
    }else{
        UIAlertView *av  = [[UIAlertView alloc] initWithTitle:@"Missing" message:@"Please enter Action name and points" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
    }
}

- (IBAction)btnBack_Action:(id)sender {
    UIBarButtonItem *btn            = (UIBarButtonItem *)sender;
    
    if ([btn.title caseInsensitiveCompare:@"   Cancel"] == NSOrderedSame) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(allActionView:didCancelButtonPressed:)]) {
            [self.delegate allActionView:self didCancelButtonPressed:YES];
        }
    }else{
        CGRect allActionsRect    		= self.viewAllActions.frame;
        allActionsRect.origin.x          = 0;
        
        CGRect viewAddNewActionRect 	= self.viewAddNewAction.frame;
        viewAddNewActionRect.origin.x   = self.frame.size.width;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.viewAllActions.frame     = allActionsRect;
            self.viewAddNewAction.frame     = viewAddNewActionRect;
        } completion:^(BOOL finished) {
            self.navbar.topItem.title       = @"All Actions";
            self.leftButton.title           = @"   Cancel";
            self.rightButton.title          = @"Add    ";
            
            [self.tfAction resignFirstResponder];
            [self.tfPoint resignFirstResponder];
        }];
    }
    
}

- (IBAction)btnAddAction:(id)sender {
    
    UIBarButtonItem *btn            = (UIBarButtonItem *)sender;
    
    if ([btn.title caseInsensitiveCompare:@"Add    "] == NSOrderedSame) {
        
        CGRect allActionsRect    		= self.viewAllActions.frame;
        allActionsRect.origin.x         = -self.frame.size.width;
        
        CGRect viewAddNewActionRect 	= self.viewAddNewAction.frame;
        viewAddNewActionRect.origin.x   = 0;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.viewAllActions.frame     = allActionsRect;
            self.viewAddNewAction.frame     = viewAddNewActionRect;
        } completion:^(BOOL finished) {
            self.navbar.topItem.title       = @"Add New Action";
            self.leftButton.title           = @"   Back";
            self.rightButton.title          = @"Save    ";
        }];
    }else{
        [self addActionWithActionName:self.tfAction.text andPoints:self.tfPoint.text];
    }
}

#pragma mark - DELEGATE
#pragma mark Tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayActions.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSDictionary *dict          = [arrayActions objectAtIndex:indexPath.row];
    
    cell.textLabel.text         = [dict objectForKey:@"action_name"];
    cell.detailTextLabel.text   = [dict objectForKey:@"points"];
    
    return cell;
}


@end
