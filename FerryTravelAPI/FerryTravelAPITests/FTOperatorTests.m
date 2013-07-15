#import "FTOperatorTests.h"
#import "FTOperator.h"

@implementation FTOperatorTests

- (void) testGetAllOperators {
	
	NSError *error = nil;
    NSArray *operators = [FTOperator getAll:&error];
	
	STAssertNotNil(operators, @"operators are nil, you fail.");
	
}

- (void) testGetAllOperatorsUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTOperator getAllUsingCallback:^(id operators) {
		
		STAssertNotNil(operators, @"operators were not returned, something went wrong.");
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

- (void) testGetOperatorByID {
	
	NSError *error = nil;
	NSArray *operators = [FTOperator getAll:&error];
	NSInteger operatorID = [(FTOperator *)[operators objectAtIndex:0] operatorID];
	
	FTOperator *operator = [FTOperator getByID:operatorID error:&error];
	STAssertNotNil(application, @"operator is nil, you fail.");
		
}

- (void) testGetOperatorByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *operators = [FTOperator getAll:&error];
	NSInteger operatorID = [(FTOperator *)[operators objectAtIndex:0] operatorID];
	
	[FTOperator getByID:operatorID 
			   usingCallback:^(FTOperator *operator) {
				   STAssertNotNil(operator, @"operator was not returned, something went wrong.");
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

- (void) testCreateOperator {
	
	NSError *error = nil;
	FTOperator *operator = [[FTOperator alloc] init];
    
        [operator setOperatorID:@"SET VALUE"];
        [operator setName:@"SET VALUE"];
        [operator setMonitoringDirectory:@"SET VALUE"];
        [operator setSurcharge:@"SET VALUE"];
    
	[operator create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}

	STAssertTrue(isSuccessful, @"operator was not saved.");
}

- (void) testCreateOperatorUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTOperator *operator = [[FTOperator alloc] init];
    
        [operator setOperatorID:@"SET VALUE"];
        [operator setName:@"SET VALUE"];
        [operator setMonitoringDirectory:@"SET VALUE"];
        [operator setSurcharge:@"SET VALUE"];
	
	[operator createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating operator did not save.");
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


- (void) testDeleteOperator {
	
	NSError *error = nil;
	FTOperator *operator = [[FTOperator alloc] init];
    
        [operator setOperatorID:@"SET VALUE"];
        [operator setName:@"SET VALUE"];
        [operator setMonitoringDirectory:@"SET VALUE"];
        [operator setSurcharge:@"SET VALUE"];
    
	[operator create:&error];
	
	BOOL isSuccessful = YES;
	
	if (error) {
		isSuccessful = NO;
	}
	
	if (isSuccessful) {
		NSArray *allOperators = [FTOperator getAll:&error];
		
		for (FTOperator *app in allApplications) {
			if ([app.operatorID isEqualToString:operator.operatorID]) {
				[app delete:&localError];
			}
		}
	}
	
	STAssertTrue(isSuccessful, @"application was not saved.");
}

- (void) testDeleteOperatorUsingCallback {
	
	__block NSError *localError = nil;
	__block BOOL done= NO;
    int count = 0;
	
	FTOperator *operator = [[FTOperator alloc] init];
    
        [operator setOperatorID:@"SET VALUE"];
        [operator setName:@"SET VALUE"];
        [operator setMonitoringDirectory:@"SET VALUE"];
        [operator setSurcharge:@"SET VALUE"];
	
	[operator createUsingCallback:^(BOOL isSuccessful) {
					STAssertTrue(isSuccessful, @"creating application did not save.");
					done = YES;
		
					if (isSuccessful) {
						NSArray *allOperators = [FTOperator getAll:&localError];
						
						for (FTOperator *app in allOperators) {
							if ([app.operatorID isEqualToString:operator.operatorID]) {
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