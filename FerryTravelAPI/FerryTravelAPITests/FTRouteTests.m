#import "FTRouteTests.h"
#import "FTRoute.h"
#import "FTPort.h"

@implementation FTRouteTests

- (void) testGetAllRoutes {
	
	NSError *error = nil;
    NSArray *routes = [FTRoute getAll:&error];
	
	XCTAssertNotNil(routes, @"routes are nil, you fail.");
	
}

- (void) testGetAllRoutesByDepartingPort {
  	
	NSError *error = nil;
	NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
	XCTAssertNotNil(routes, @"routes are nil, you fail.");
}

- (void) testGetAllRoutesByDepartingPortUsingCallback {
  	
	NSError *error = nil;
	NSArray *ports = [FTPort getAll:&error];
    
    __block BOOL done= NO;
    int count = 0;
	
	[FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID]
                     usingCallback:^(id routes) {
		XCTAssertNotNil(routes, @"routes were not returned, something went wrong.");
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

- (void) testGetAllRoutesUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTRoute getAllUsingCallback:^(id routes) {
		
		XCTAssertNotNil(routes, @"routes were not returned, something went wrong.");
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

- (void) testGetRouteByID {
	
	NSError *error = nil;
	NSArray *routes = [FTRoute getAll:&error];
	NSInteger routeID = [(FTRoute *)[routes objectAtIndex:0] routeID];
	
	FTRoute *route = [FTRoute getByID:routeID error:&error];
	XCTAssertNotNil(route, @"route is nil, you fail.");
}

- (void) testGetRouteByIDUsingCallback {
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *routes = [FTRoute getAll:&error];
	NSInteger routeID = [(FTRoute *)[routes objectAtIndex:0] routeID];
	
	[FTRoute getByID:routeID 
			   usingCallback:^(FTRoute *route) {
				   XCTAssertNotNil(route, @"route was not returned, something went wrong.");
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