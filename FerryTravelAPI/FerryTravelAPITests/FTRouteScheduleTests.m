#import "FTRouteScheduleTests.h"
#import "FTRouteSchedule.h"

@implementation FTRouteScheduleTests

- (void) testGetAllRouteSchedules {
	
	NSError *error = nil;
    NSArray *routeSchedules = [FTRouteSchedule getAll:&error];
	
	STAssertNotNil(routeSchedules, @"routeSchedules are nil, you fail.");
	
}

- (void) testGetAllRouteSchedulesUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTRouteSchedule getAllUsingCallback:^(id routeSchedules) {
		
		STAssertNotNil(routeSchedules, @"routeSchedules were not returned, something went wrong.");
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

- (void) testGetRouteScheduleByID {
	
	NSError *error = nil;
	NSArray *routeSchedules = [FTRouteSchedule getAll:&error];
	NSInteger routeScheduleID = [(FTRouteSchedule *)[routeSchedules objectAtIndex:0] routeScheduleID];
	
	FTRouteSchedule *routeSchedule = [FTRouteSchedule getByID:routeScheduleID error:&error];
	STAssertNotNil(application, @"routeSchedule is nil, you fail.");
		
}

- (void) testGetRouteScheduleByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *routeSchedules = [FTRouteSchedule getAll:&error];
	NSInteger routeScheduleID = [(FTRouteSchedule *)[routeSchedules objectAtIndex:0] routeScheduleID];
	
	[FTRouteSchedule getByID:routeScheduleID 
			   usingCallback:^(FTRouteSchedule *routeSchedule) {
				   STAssertNotNil(routeSchedule, @"routeSchedule was not returned, something went wrong.");
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

- (void) testCreateRouteSchedule {
	
	NSError *error = nil;
	FTRouteSchedule *routeSchedule = [[FTRouteSchedule alloc] init];
    
        [routeSchedule setRouteScheduleID:@"SET VALUE"];
        [routeSchedule setRouteID:@"SET VALUE"];
        [routeSchedule setVesselCode:@"SET VALUE"];
        [routeSchedule setVesselName:@"SET VALUE"];
        [routeSchedule setDepartDateTime:@"SET VALUE"];
        [routeSchedule setArriveDateTime:@"SET VALUE"];
    
	[routeSchedule create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}

	STAssertTrue(isSuccessful, @"routeSchedule was not saved.");
}

- (void) testCreateRouteScheduleUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRouteSchedule *routeSchedule = [[FTRouteSchedule alloc] init];
    
        [routeSchedule setRouteScheduleID:@"SET VALUE"];
        [routeSchedule setRouteID:@"SET VALUE"];
        [routeSchedule setVesselCode:@"SET VALUE"];
        [routeSchedule setVesselName:@"SET VALUE"];
        [routeSchedule setDepartDateTime:@"SET VALUE"];
        [routeSchedule setArriveDateTime:@"SET VALUE"];
	
	[routeSchedule createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating routeSchedule did not save.");
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


- (void) testDeleteRouteSchedule {
	
	NSError *error = nil;
	FTRouteSchedule *routeSchedule = [[FTRouteSchedule alloc] init];
    
        [routeSchedule setRouteScheduleID:@"SET VALUE"];
        [routeSchedule setRouteID:@"SET VALUE"];
        [routeSchedule setVesselCode:@"SET VALUE"];
        [routeSchedule setVesselName:@"SET VALUE"];
        [routeSchedule setDepartDateTime:@"SET VALUE"];
        [routeSchedule setArriveDateTime:@"SET VALUE"];
    
	[routeSchedule create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}
	
	if (isSuccessful) {
		NSArray *allRouteSchedules = [FTRouteSchedule getAll:&error];
		
		for (FTRouteSchedule *app in allApplications) {
			if ([app.routeScheduleID isEqualToString:routeSchedule.routeScheduleID]) {
				[app delete:&localError];
			}
		}
	}
	
	STAssertTrue(isSuccessful, @"application was not saved.");
}

- (void) testDeleteRouteScheduleUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRouteSchedule *routeSchedule = [[FTRouteSchedule alloc] init];
    
        [routeSchedule setRouteScheduleID:@"SET VALUE"];
        [routeSchedule setRouteID:@"SET VALUE"];
        [routeSchedule setVesselCode:@"SET VALUE"];
        [routeSchedule setVesselName:@"SET VALUE"];
        [routeSchedule setDepartDateTime:@"SET VALUE"];
        [routeSchedule setArriveDateTime:@"SET VALUE"];
	
	[routeSchedule createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating application did not save.");
					done = YES;
		
					if (isSuccessful) {
						NSArray *allRouteSchedules = [FTRouteSchedule getAll:&localError];
						
						for (FTRouteSchedule *app in allRouteSchedules) {
							if ([app.routeScheduleID isEqualToString:routeSchedule.routeScheduleID]) {
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