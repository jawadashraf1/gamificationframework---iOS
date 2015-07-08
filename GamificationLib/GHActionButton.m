//
//  GHActionButton.m
//  Get Hot
//
//  Created by Azeem Akram on 6/8/15.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "GHActionButton.h"
#import "PSPointSystemAction.h"

@implementation GHActionButton

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)buttonClicked{
    NSLog(@"Action Button is tapped");
//    [[PSPointSystemAction sharedAction] performActionWithKey:(int)self.tag];
}


@end
