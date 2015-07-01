//
//  PSDateTimeUtil.m
//  Get Hot
//
//  Created by Raheel Ahmad on 13/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#define DEFAULT_DATE_FORMAT @"yyyy-MM-dd hh:mm:ss"

#import "PSDateTimeUtil.h"

@implementation PSDateTimeUtil

+(NSString *) getCurrentFormatedDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DEFAULT_DATE_FORMAT];
    return [dateFormat stringFromDate:[NSDate date]];
}

@end
