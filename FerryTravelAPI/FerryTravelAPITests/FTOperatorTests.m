#import "FTOperatorTests.h"
#import "FTOperator.h"

@implementation FTOperatorTests

//- (void) testGetAllOperators {
//	
//	NSError *error = nil;
//    NSArray *operators = [FTOperator getAll:&error];
//	
//	XCTAssertNotNil(operators, @"operators are nil, you fail.");
//	
//}
//
//- (void) testGetAllOperatorsUsingCallback {
//	
//	__block BOOL done= NO;
//    int count = 0;
//	
//	[FTOperator getAllUsingCallback:^(id operators) {
//		
//		XCTAssertNotNil(operators, @"operators were not returned, something went wrong.");
//		done = YES;
//		
//		
//	}
//                             error:^(NSError *error) {
//                                 XCTFail(@"An error occured. \"%@\"", error);
//                                 done = YES;							
//                             }
//	 ];
//
//	
//	while (!done) {
//        if (count < 20) {
//            count++;
//            [self runLoop];
//        }
//        else {
//            done = YES;
//            XCTFail(@"Did not complete testGetAllUsingCallback");
//        }
//    }
//}
//
//- (void) testGetOperatorByID {
//	
//	NSError *error = nil;
//	NSArray *operators = [FTOperator getAll:&error];
//	NSInteger operatorID = [(FTOperator *)[operators objectAtIndex:0] operatorID];
//	
//	FTOperator *operator = [FTOperator getByID:operatorID error:&error];
//	XCTAssertNotNil(operator, @"operator is nil, you fail.");
//		
//}
//
//- (void) testGetOperatorByIDUsingCallback {
//	
//	NSError *error = nil;
//	__block BOOL done= NO;
//    int count = 0;
//	NSArray *operators = [FTOperator getAll:&error];
//	NSInteger operatorID = [(FTOperator *)[operators objectAtIndex:0] operatorID];
//	
//	[FTOperator getByID:operatorID 
//			   usingCallback:^(FTOperator *operator) {
//				   XCTAssertNotNil(operator, @"operator was not returned, something went wrong.");
//				   done = YES;
//		
//			   }
//				  errorBlock:^(NSError *error) {
//									 XCTFail(@"An error occured. \"%@\"", error);
//									 done = YES;							
//				  }
//	 ];
//	
//	
//	while (!done) {
//        if (count < 20) {
//            count++;
//            [self runLoop];
//        }
//        else {
//            done = YES;
//            XCTFail(@"Did not complete testGetAllUsingCallback");
//        }
//    }
//}

@end