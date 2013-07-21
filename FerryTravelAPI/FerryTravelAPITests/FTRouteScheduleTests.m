#import "FTRouteScheduleTests.h"
#import "FTRouteSchedule.h"
#import "FTRoute.h"
#import "FTPort.h"

@implementation FTRouteScheduleTests

- (void) testGetAllRouteSchedules {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
    NSArray *routeSchedules = [FTRouteSchedule getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	
	XCTAssertNotNil(routeSchedules, @"routeSchedules are nil, you fail.");
	
}

- (void) testGetAllRouteSchedulesUsingCallback {
    
    NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTRouteSchedule getAllByRoute:[[routes objectAtIndex:0] routeID] usingCallback:^(id routeSchedules) {
		
		XCTAssertNotNil(routeSchedules, @"routeSchedules were not returned, something went wrong.");
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

- (void) testGetRouteScheduleByID {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
    NSArray *routeSchedules = [FTRouteSchedule getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	NSInteger routeScheduleID = [(FTRouteSchedule *)[routeSchedules objectAtIndex:0] routeScheduleID];
	
	FTRouteSchedule *routeSchedule = [FTRouteSchedule getByID:routeScheduleID error:&error];
	XCTAssertNotNil(routeSchedule, @"routeSchedule is nil, you fail.");
		
}

- (void) testGetRouteScheduleByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	
    NSArray *ports = [FTPort getAll:&error];
    NSArray *routes = [FTRoute getAllByDepartingPort:[[ports objectAtIndex:0] portID] error:&error];
    
    NSArray *routeSchedules = [FTRouteSchedule getAllByRoute:[[routes objectAtIndex:0] routeID] error:&error];
	NSInteger routeScheduleID = [(FTRouteSchedule *)[routeSchedules objectAtIndex:0] routeScheduleID];
	
	[FTRouteSchedule getByID:routeScheduleID 
			   usingCallback:^(FTRouteSchedule *routeSchedule) {
				   XCTAssertNotNil(routeSchedule, @"routeSchedule was not returned, something went wrong.");
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