//
//  PSAlertUtil.m
//  Get Hot
//
//  Created by Raheel Ahmad on 13/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAlertUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KGModal.h"

@implementation PSAlertUtil

+(void) showAlertWithErrorMessage:(NSString *) message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

+(void) showAlertWithSuccessMessage:(NSString *) message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

+(void) showAlertWithMessage:(NSString *) message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Huh" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

+(void) showCustomAlertView:(NSString *) desc title:(NSString *) title img:(NSString *) img{
    PSAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"PSAlertView" owner:self options:nil] objectAtIndex:0];
    alertView.descriptionLbl.text = desc;
    alertView.titleLbl.text = title;
    [alertView.imgView sd_setImageWithURL:[NSURL URLWithString:img]];
    [[KGModal sharedInstance] showWithContentView:alertView andAnimated:YES];
}

@end
