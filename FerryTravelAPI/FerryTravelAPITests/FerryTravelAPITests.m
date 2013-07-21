//
//  FerryTravelAPITests.m
//  FerryTravelAPITests
//
//  Created by Chad Meyer on 7/15/13.
//  Copyright (c) 2013 52projects, INC. All rights reserved.
//

#import "FerryTravelAPITests.h"

@implementation FerryTravelAPITests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) runLoop {
    
    @try {
        // This executes another run loop.
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        // Sleep 1/100th sec
        usleep(10000);
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
	
}

@end
