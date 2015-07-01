//
//  PSAlertView.m
//  Get Hot
//
//  Created by Raheel Ahmad on 14/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAlertView.h"

@implementation PSAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.clipsToBounds = YES;
}

@end
