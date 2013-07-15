#import "FTRouteTests.h"
#import "FTRoute.h"

@implementation FTRouteTests

- (void) testGetAllRoutes {
	
	NSError *error = nil;
    NSArray *routes = [FTRoute getAll:&error];
	
	STAssertNotNil(routes, @"routes are nil, you fail.");
	
}

- (void) testGetAllRoutesUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTRoute getAllUsingCallback:^(id routes) {
		
		STAssertNotNil(routes, @"routes were not returned, something went wrong.");
		done = YES;
		
		
	}
								 error:^(NSError *error) {
									 STFail([NSString stringWithFormat:@"An error occured. %@", error]);
									 done = YES;							
								 }
	 ];

	
	while (!done) {
        
        if (count < 20) {
            count++;
            [self runLoop];
        }
        else {
            done = YES;
            STFail(@"Did not complete testGetAllUsingCallback");
        }
    }
}

- (void) testGetRouteByID {
	
	NSError *error = nil;
	NSArray *routes = [FTRoute getAll:&error];
	NSInteger routeID = [(FTRoute *)[routes objectAtIndex:0] routeID];
	
	FTRoute *route = [FTRoute getByID:routeID error:&error];
	STAssertNotNil(application, @"route is nil, you fail.");
		
}

- (void) testGetRouteByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *routes = [FTRoute getAll:&error];
	NSInteger routeID = [(FTRoute *)[routes objectAtIndex:0] routeID];
	
	[FTRoute getByID:routeID 
			   usingCallback:^(FTRoute *route) {
				   STAssertNotNil(route, @"route was not returned, something went wrong.");
				   done = YES;
		
			   }
				  errorBlock:^(NSError *error) {
									 STFail([NSString stringWithFormat:@"An error occured. %@", error]);
									 done = YES;							
				  }
	 ];
	
	
	while (!done) {
        
        if (count < 20) {
            count++;
            [self runLoop];
        }
        else {
            done = YES;
            STFail(@"Did not complete testGetAllUsingCallback");
        }
    }
}

- (void) testCreateRoute {
	
	NSError *error = nil;
	FTRoute *route = [[FTRoute alloc] init];
    
        [route setRouteID:@"SET VALUE"];
        [route setOperatorID:@"SET VALUE"];
        [route setName:@"SET VALUE"];
        [route setDepartingPortID:@"SET VALUE"];
        [route setArrivingPortID:@"SET VALUE"];
        [route setActive:@"SET VALUE"];
        [route setDescription:@"SET VALUE"];
    
	[route create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}

	STAssertTrue(isSuccessful, @"route was not saved.");
}

- (void) testCreateRouteUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRoute *route = [[FTRoute alloc] init];
    
        [route setRouteID:@"SET VALUE"];
        [route setOperatorID:@"SET VALUE"];
        [route setName:@"SET VALUE"];
        [route setDepartingPortID:@"SET VALUE"];
        [route setArrivingPortID:@"SET VALUE"];
        [route setActive:@"SET VALUE"];
        [route setDescription:@"SET VALUE"];
	
	[route createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating route did not save.");
					done = YES;
				}
						  errorBlock:^(NSError *error) {
							  STFail([NSString stringWithFormat:@"An error occured. %@", error]);
							  done = YES;
						  }
	 ];

	while (!done) {
        
        if (count < 20) {
            count++;
            [self runLoop];
        }
        else {
            done = YES;
            STFail(@"Did not complete testGetAllUsingCallback");
        }
    }
	
}


- (void) testDeleteRoute {
	
	NSError *error = nil;
	FTRoute *route = [[FTRoute alloc] init];
    
        [route setRouteID:@"SET VALUE"];
        [route setOperatorID:@"SET VALUE"];
        [route setName:@"SET VALUE"];
        [route setDepartingPortID:@"SET VALUE"];
        [route setArrivingPortID:@"SET VALUE"];
        [route setActive:@"SET VALUE"];
        [route setDescription:@"SET VALUE"];
    
	[route create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}
	
	if (isSuccessful) {
		NSArray *allRoutes = [FTRoute getAll:&error];
		
		for (FTRoute *app in allApplications) {
			if ([app.routeID isEqualToString:route.routeID]) {
				[app delete:&localError];
			}
		}
	}
	
	STAssertTrue(isSuccessful, @"application was not saved.");
}

- (void) testDeleteRouteUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRoute *route = [[FTRoute alloc] init];
    
        [route setRouteID:@"SET VALUE"];
        [route setOperatorID:@"SET VALUE"];
        [route setName:@"SET VALUE"];
        [route setDepartingPortID:@"SET VALUE"];
        [route setArrivingPortID:@"SET VALUE"];
        [route setActive:@"SET VALUE"];
        [route setDescription:@"SET VALUE"];
	
	[route createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating application did not save.");
					done = YES;
		
					if (isSuccessful) {
						NSArray *allRoutes = [FTRoute getAll:&localError];
						
						for (FTRoute *app in allRoutes) {
							if ([app.routeID isEqualToString:route.routeID]) {
								[app delete:&localError];
							}
						}
					}
				}
						  errorBlock:^(NSError *error) {
							  STFail([NSString stringWithFormat:@"An error occured. %@", error]);
							  done = YES;
						  }
	 ];

	while (!done) {
        
        if (count < 20) {
            count++;
            [self runLoop];
        }
        else {
            done = YES;
            STFail(@"Did not complete testGetAllUsingCallback");
        }
    }
	
}

@end