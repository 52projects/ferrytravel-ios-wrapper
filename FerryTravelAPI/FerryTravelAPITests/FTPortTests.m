#import "FTPortTests.h"
#import "FTPort.h"

@implementation FTPortTests

- (void) testGetAllPorts {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
	
	STAssertNotNil(ports, @"ports are nil, you fail.");
	
}

- (void) testGetAllPortsUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTPort getAllUsingCallback:^(id ports) {
		
		STAssertNotNil(ports, @"ports were not returned, something went wrong.");
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

- (void) testGetPortByID {
	
	NSError *error = nil;
	NSArray *ports = [FTPort getAll:&error];
	NSInteger portID = [(FTPort *)[ports objectAtIndex:0] portID];
	
	FTPort *port = [FTPort getByID:portID error:&error];
	STAssertNotNil(application, @"port is nil, you fail.");
		
}

- (void) testGetPortByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *ports = [FTPort getAll:&error];
	NSInteger portID = [(FTPort *)[ports objectAtIndex:0] portID];
	
	[FTPort getByID:portID 
			   usingCallback:^(FTPort *port) {
				   STAssertNotNil(port, @"port was not returned, something went wrong.");
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

- (void) testCreatePort {
	
	NSError *error = nil;
	FTPort *port = [[FTPort alloc] init];
    
        [port setPortId:@"SET VALUE"];
        [port setCode:@"SET VALUE"];
        [port setName:@"SET VALUE"];
        [port setCity:@"SET VALUE"];
        [port setState:@"SET VALUE"];
        [port setCountryID:@"SET VALUE"];
        [port setLatitude:@"SET VALUE"];
        [port setLongitude:@"SET VALUE"];
        [port setGeographyDefinition:@"SET VALUE"];
    
	[port create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}

	STAssertTrue(isSuccessful, @"port was not saved.");
}

- (void) testCreatePortUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTPort *port = [[FTPort alloc] init];
    
        [port setPortId:@"SET VALUE"];
        [port setCode:@"SET VALUE"];
        [port setName:@"SET VALUE"];
        [port setCity:@"SET VALUE"];
        [port setState:@"SET VALUE"];
        [port setCountryID:@"SET VALUE"];
        [port setLatitude:@"SET VALUE"];
        [port setLongitude:@"SET VALUE"];
        [port setGeographyDefinition:@"SET VALUE"];
	
	[port createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating port did not save.");
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


- (void) testDeletePort {
	
	NSError *error = nil;
	FTPort *port = [[FTPort alloc] init];
    
        [port setPortId:@"SET VALUE"];
        [port setCode:@"SET VALUE"];
        [port setName:@"SET VALUE"];
        [port setCity:@"SET VALUE"];
        [port setState:@"SET VALUE"];
        [port setCountryID:@"SET VALUE"];
        [port setLatitude:@"SET VALUE"];
        [port setLongitude:@"SET VALUE"];
        [port setGeographyDefinition:@"SET VALUE"];
    
	[port create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}
	
	if (isSuccessful) {
		NSArray *allPorts = [FTPort getAll:&error];
		
		for (FTPort *app in allApplications) {
			if ([app.portID isEqualToString:port.portID]) {
				[app delete:&localError];
			}
		}
	}
	
	STAssertTrue(isSuccessful, @"application was not saved.");
}

- (void) testDeletePortUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTPort *port = [[FTPort alloc] init];
    
        [port setPortId:@"SET VALUE"];
        [port setCode:@"SET VALUE"];
        [port setName:@"SET VALUE"];
        [port setCity:@"SET VALUE"];
        [port setState:@"SET VALUE"];
        [port setCountryID:@"SET VALUE"];
        [port setLatitude:@"SET VALUE"];
        [port setLongitude:@"SET VALUE"];
        [port setGeographyDefinition:@"SET VALUE"];
	
	[port createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating application did not save.");
					done = YES;
		
					if (isSuccessful) {
						NSArray *allPorts = [FTPort getAll:&localError];
						
						for (FTPort *app in allPorts) {
							if ([app.portID isEqualToString:port.portID]) {
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