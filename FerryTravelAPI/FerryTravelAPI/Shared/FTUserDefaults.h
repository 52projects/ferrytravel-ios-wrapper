//
//  FTUserDefaults.h
//  FerryTravelAPI
//
//  Created by Chad Meyer on 7/15/13.
//  Copyright (c) 2013 52projects, INC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTUserDefaults : NSObject

@property (nonatomic, strong) NSDictionary *routes;
@property (nonatomic, strong) NSDictionary *ports;

+ (FTUserDefaults *) sharedDefaults;

- (NSString *) baseUrl;

- (void) killAll;

@end
