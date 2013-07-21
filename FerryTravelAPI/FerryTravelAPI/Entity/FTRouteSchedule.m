#import "FTRouteSchedule.h"
#import "FTWebRequest.h"
#import "FTUserDefaults.h"
#import "FTUtility.h"

@interface FTRouteSchedule (PRIVATE)

- (FTRouteSchedule *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) routeScheduledictionary;

@end


@implementation FTRouteSchedule
    @synthesize routeScheduleID;
    @synthesize routeID;
    @synthesize vesselCode;
    @synthesize vesselName;
    @synthesize departDateTime;
    @synthesize arriveDateTime;

#pragma mark - Data Methods

+ (NSArray *)getAllByRoute:(NSInteger)routeID error:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:[NSString stringWithFormat:@"routes/%d/routeschedules", routeID] withContentType:WebRequestContentTypeJson withError:&*error];

    if (*error) {
        return nil;
    }

    if (results && ![results isEqual:[NSNull null]]) {
    	NSMutableArray *routeSchedules = [[NSMutableArray alloc] initWithObjects:nil];

        // Go through each one and add to the applications to an array
        for (NSDictionary *value in results) {
            [routeSchedules addObject:[FTRouteSchedule populateWithDictionary:value]];
        }

        return [routeSchedules copy];
    }
    
    return nil;
}

+ (void)getAllByRoute:(NSInteger)routeID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:[NSString stringWithFormat:@"routes/%d/routeschedules", routeID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  NSMutableArray *routeSchedules = [[NSMutableArray alloc] initWithObjects:nil];
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in returnedResults) {
						  [routeSchedules addObject:[FTRouteSchedule populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([routeSchedules copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (FTRouteSchedule *)getByID:(NSInteger)routeScheduleID error:(NSError **)error {
	FTWebRequest *request = [[FTWebRequest alloc] init];
	
	NSDictionary *results = [request makeWebRequest:[NSString stringWithFormat:@"routeSchedules/%d", routeScheduleID]
									withContentType:WebRequestContentTypeJson
										  withError:&*error];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		return [FTRouteSchedule populateWithDictionary:results];
	}
	
	return nil;
}

+ (void)getByID:(NSInteger)routeScheduleID usingCallback:(void (^)(FTRouteSchedule *))returnRouteSchedule errorBlock:(void (^)(NSError *))error {	
	FTWebRequest *request = [[FTWebRequest alloc] init];

	[request makeWebRequest:[NSString stringWithFormat:@"routeSchedules/%d", routeScheduleID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  
				  if (returnRouteSchedule) {
					  returnRouteSchedule([FTRouteSchedule populateWithDictionary:returnedResults]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (error) {
						 error(localError);
					 }
				 }
	 ];
}

#pragma mark - Population Methods

+ (FTRouteSchedule *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTRouteSchedule alloc] initWithDictionary:dict];
}

- (FTRouteSchedule *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
        self.routeScheduleID = [[dict objectForKey:@"id"] intValue];
        self.routeID = [[dict objectForKey:@"routeID"] intValue];
        self.vesselCode = [dict objectForKey:@"vesselCode"];
        self.vesselName = [dict objectForKey:@"vesselName"];
        self.departDateTime = [FTUtility convertToFullNSDate:[dict objectForKey:@"departDateTime"]];
        self.arriveDateTime = [FTUtility convertToFullNSDate:[dict objectForKey:@"arriveDateTime"]];
    return self;
}

- (NSDictionary *) routeScheduleDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.routeScheduleID], @"routeScheduleID",
            self.routeID, @"routeID",
            self.vesselCode, @"vesselCode",
            self.vesselName, @"vesselName",
            self.departDateTime, @"departDateTime",
            self.arriveDateTime, @"arriveDateTime",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTRouteSchedule alloc] init];

    if (self != nil) {
        self.routeScheduleID = [coder decodeIntegerForKey:@"routeScheduleID"];
        self.routeID = [coder decodeIntegerForKey:@"routeID"];
        self.vesselCode = [coder decodeObjectForKey:@"vesselCode"];
        self.vesselName = [coder decodeObjectForKey:@"vesselName"];
        self.departDateTime = [coder decodeObjectForKey:@"departDateTime"];
        self.arriveDateTime = [coder decodeObjectForKey:@"arriveDateTime"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:routeScheduleID forKey:@"routeScheduleID"];
        [coder encodeInteger:routeID forKey:@"routeID"];
        [coder encodeObject:vesselCode forKey:@"vesselCode"];
        [coder encodeObject:vesselName forKey:@"vesselName"];
        [coder encodeObject:departDateTime forKey:@"departDateTime"];
        [coder encodeObject:arriveDateTime forKey:@"arriveDateTime"];
}

@end