//
//  PSActionResponse.h
//  Get Hot
//
//  Created by Raheel Ahmad on 13/04/2015.
//  Copyright (c) 2015 Burhan. All rights reserved.
//

#import "PSAPI.h"

@interface PSActionResponse : PSAPI

@property (nonatomic, strong) NSNumber<Optional> * alert;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSString<Optional> * title;
@property (nonatomic, strong) NSString<Optional> * subTitle;
@property (nonatomic, strong) NSString<Optional> * img;

@end
