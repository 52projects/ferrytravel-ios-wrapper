//
//  FTUserDefaults.m
//  FerryTravelAPI
//
//  Created by Chad Meyer on 7/15/13.
//  Copyright (c) 2013 52projects, INC. All rights reserved.
//

#import "FTUserDefaults.h"

@implementation FTUserDefaults


static FTUserDefaults *_sharedDefaults = nil;

+ (FTUserDefaults *) sharedDefaults {
	return _sharedDefaults;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        _sharedDefaults = [[FTUserDefaults alloc] init];
    }
}

- (NSString *) baseUrl {
	return @"http://ferry-travel.apphb.com/api/";
}

- (void) killAll {
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
