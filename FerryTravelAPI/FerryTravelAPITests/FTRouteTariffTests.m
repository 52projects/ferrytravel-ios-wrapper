#import "FTRouteTariffTests.h"
#import "FTRouteTariff.h"
#import "FTPort.h"
#import "FTRoute.h"

@implementation FTRouteTariffTests

- (void) testGetAllRouteTariffs {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
    NSArray *routeTariffs = [FTRouteTariff getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	
	XCTAssertNotNil(routeTariffs, @"routeTariffs are nil, you fail.");
	
}

- (void) testGetAllRouteTariffsUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
    
    NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
	
	[FTRouteTariff getAllByRoute:[[routes objectAtIndex:0] routeID] usingCallback:^(id routeTariffs) {
		XCTAssertNotNil(routeTariffs, @"routeTariffs were not returned, something went wrong.");
		done = YES;
		
		
	}
								 error:^(NSError *error) {
									 XCTFail(@"An error occured. \"%@\"", error);
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
            XCTFail(@"Did not complete testGetAllUsingCallback");
        }
    }
}

- (void) testGetRouteTariffByID {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
	NSArray *routeTariffs = [FTRouteTariff getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	NSInteger routeTariffID = [(FTRouteTariff *)[routeTariffs objectAtIndex:0] routeTariffID];
	
	FTRouteTariff *routeTariff = [FTRouteTariff getByID:routeTariffID error:&error];
	XCTAssertNotNil(routeTariff, @"routeTariff is nil, you fail.");
		
}

- (void) testGetRouteTariffByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
	NSArray *routeTariffs = [FTRouteTariff getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	NSInteger routeTariffID = [(FTRouteTariff *)[routeTariffs objectAtIndex:0] routeTariffID];
	
	[FTRouteTariff getByID:routeTariffID 
			   usingCallback:^(FTRouteTariff *routeTariff) {
				   XCTAssertNotNil(routeTariff, @"routeTariff was not returned, something went wrong.");
				   done = YES;
		
			   }
				  errorBlock:^(NSError *error) {
									 XCTFail(@"An error occured. \"%@\"", error);
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
            XCTFail(@"Did not complete testGetAllUsingCallback");
        }
    }
}

@end