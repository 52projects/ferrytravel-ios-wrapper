#import "FTPortTests.h"
#import "FTPort.h"

@implementation FTPortTests

- (void) testGetAllPorts {
	
	NSError *error = nil;
    NSArray *ports = [FTPort getAll:&error];
	
	XCTAssertNotNil(ports, @"ports are nil, you fail.");
	
}

- (void) testGetAllPortsUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	
	[FTPort getAllUsingCallback:^(id ports) {
		
		XCTAssertNotNil(ports, @"ports were not returned, something went wrong.");
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

- (void) testGetPortByID {
	
	NSError *error = nil;
	NSArray *ports = [FTPort getAll:&error];
	NSInteger portID = [(FTPort *)[ports objectAtIndex:0] portID];
	
	FTPort *port = [FTPort getByID:portID error:&error];
	XCTAssertNotNil(port, @"port is nil, you fail.");
		
}

- (void) testGetPortByIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	NSArray *ports = [FTPort getAll:&error];
	NSInteger portID = [(FTPort *)[ports objectAtIndex:0] portID];
	
	[FTPort getByID:portID 
			   usingCallback:^(FTPort *port) {
				   XCTAssertNotNil(port, @"port was not returned, something went wrong.");
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