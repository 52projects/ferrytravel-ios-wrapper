#import "FTRouteTariffTests.h"
#import "FTRouteTariff.h"

@implementation FTRouteTariffTests

- (void) testGetAllRouteTariffs {
	
	NSError *error = nil;
    NSArray *routeTariffs = [FTRouteTariff getAll:&error];
	
	STAssertNotNil(routeTariffs, @"routeTariffs are nil, you fail.");
	
}

- (void) testGetAllRouteTariffsUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTRouteTariff getAllUsingCallback:^(id routeTariffs) {
		
		STAssertNotNil(routeTariffs, @"routeTariffs were not returned, something went wrong.");
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

- (void) testGetRouteTariffByID {
	
	NSError *error = nil;
	NSArray *routeTariffs = [FTRouteTariff getAll:&error];
	NSInteger routeTariffID = [(FTRouteTariff *)[routeTariffs objectAtIndex:0] routeTariffID];
	
	FTRouteTariff *routeTariff = [FTRouteTariff getByID:routeTariffID error:&error];
	STAssertNotNil(application, @"routeTariff is nil, you fail.");
		
}

- (void) testGetRouteTariffByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *routeTariffs = [FTRouteTariff getAll:&error];
	NSInteger routeTariffID = [(FTRouteTariff *)[routeTariffs objectAtIndex:0] routeTariffID];
	
	[FTRouteTariff getByID:routeTariffID 
			   usingCallback:^(FTRouteTariff *routeTariff) {
				   STAssertNotNil(routeTariff, @"routeTariff was not returned, something went wrong.");
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

- (void) testCreateRouteTariff {
	
	NSError *error = nil;
	FTRouteTariff *routeTariff = [[FTRouteTariff alloc] init];
    
        [routeTariff setRouteTariffID:@"SET VALUE"];
        [routeTariff setRouteID:@"SET VALUE"];
        [routeTariff setTariffCategoryID:@"SET VALUE"];
        [routeTariff setFacilityCode:@"SET VALUE"];
        [routeTariff setDescription:@"SET VALUE"];
        [routeTariff setMinLength:@"SET VALUE"];
        [routeTariff setMaxLength:@"SET VALUE"];
        [routeTariff setAmount:@"SET VALUE"];
        [routeTariff setPerFootAmount:@"SET VALUE"];
        [routeTariff setStartDate:@"SET VALUE"];
        [routeTariff setEndDate:@"SET VALUE"];
        [routeTariff setRoundTripAmount:@"SET VALUE"];
        [routeTariff setVesselCode:@"SET VALUE"];
    
	[routeTariff create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}

	STAssertTrue(isSuccessful, @"routeTariff was not saved.");
}

- (void) testCreateRouteTariffUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRouteTariff *routeTariff = [[FTRouteTariff alloc] init];
    
        [routeTariff setRouteTariffID:@"SET VALUE"];
        [routeTariff setRouteID:@"SET VALUE"];
        [routeTariff setTariffCategoryID:@"SET VALUE"];
        [routeTariff setFacilityCode:@"SET VALUE"];
        [routeTariff setDescription:@"SET VALUE"];
        [routeTariff setMinLength:@"SET VALUE"];
        [routeTariff setMaxLength:@"SET VALUE"];
        [routeTariff setAmount:@"SET VALUE"];
        [routeTariff setPerFootAmount:@"SET VALUE"];
        [routeTariff setStartDate:@"SET VALUE"];
        [routeTariff setEndDate:@"SET VALUE"];
        [routeTariff setRoundTripAmount:@"SET VALUE"];
        [routeTariff setVesselCode:@"SET VALUE"];
	
	[routeTariff createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating routeTariff did not save.");
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


- (void) testDeleteRouteTariff {
	
	NSError *error = nil;
	FTRouteTariff *routeTariff = [[FTRouteTariff alloc] init];
    
        [routeTariff setRouteTariffID:@"SET VALUE"];
        [routeTariff setRouteID:@"SET VALUE"];
        [routeTariff setTariffCategoryID:@"SET VALUE"];
        [routeTariff setFacilityCode:@"SET VALUE"];
        [routeTariff setDescription:@"SET VALUE"];
        [routeTariff setMinLength:@"SET VALUE"];
        [routeTariff setMaxLength:@"SET VALUE"];
        [routeTariff setAmount:@"SET VALUE"];
        [routeTariff setPerFootAmount:@"SET VALUE"];
        [routeTariff setStartDate:@"SET VALUE"];
        [routeTariff setEndDate:@"SET VALUE"];
        [routeTariff setRoundTripAmount:@"SET VALUE"];
        [routeTariff setVesselCode:@"SET VALUE"];
    
	[routeTariff create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}
	
	if (isSuccessful) {
		NSArray *allRouteTariffs = [FTRouteTariff getAll:&error];
		
		for (FTRouteTariff *app in allApplications) {
			if ([app.routeTariffID isEqualToString:routeTariff.routeTariffID]) {
				[app delete:&localError];
			}
		}
	}
	
	STAssertTrue(isSuccessful, @"application was not saved.");
}

- (void) testDeleteRouteTariffUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTRouteTariff *routeTariff = [[FTRouteTariff alloc] init];
    
        [routeTariff setRouteTariffID:@"SET VALUE"];
        [routeTariff setRouteID:@"SET VALUE"];
        [routeTariff setTariffCategoryID:@"SET VALUE"];
        [routeTariff setFacilityCode:@"SET VALUE"];
        [routeTariff setDescription:@"SET VALUE"];
        [routeTariff setMinLength:@"SET VALUE"];
        [routeTariff setMaxLength:@"SET VALUE"];
        [routeTariff setAmount:@"SET VALUE"];
        [routeTariff setPerFootAmount:@"SET VALUE"];
        [routeTariff setStartDate:@"SET VALUE"];
        [routeTariff setEndDate:@"SET VALUE"];
        [routeTariff setRoundTripAmount:@"SET VALUE"];
        [routeTariff setVesselCode:@"SET VALUE"];
	
	[routeTariff createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating application did not save.");
					done = YES;
		
					if (isSuccessful) {
						NSArray *allRouteTariffs = [FTRouteTariff getAll:&localError];
						
						for (FTRouteTariff *app in allRouteTariffs) {
							if ([app.routeTariffID isEqualToString:routeTariff.routeTariffID]) {
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