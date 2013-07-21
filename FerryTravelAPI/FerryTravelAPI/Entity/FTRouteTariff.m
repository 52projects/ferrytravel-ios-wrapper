#import "FTRouteTariff.h"
#import "FTWebRequest.h"
#import "FTUserDefaults.h"
#import "FTUtility.h"

@interface FTRouteTariff (PRIVATE)

- (FTRouteTariff *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) routeTariffdictionary;

@end


@implementation FTRouteTariff
    @synthesize routeTariffID;
    @synthesize routeID;
    @synthesize tariffCategoryID;
    @synthesize facilityCode;
    @synthesize description;
    @synthesize minLength;
    @synthesize maxLength;
    @synthesize amount;
    @synthesize perFootAmount;
    @synthesize startDate;
    @synthesize endDate;
    @synthesize roundTripAmount;
    @synthesize vesselCode;

#pragma mark - Data Methods

+ (NSArray *)getAllByRoute:(NSInteger)routeID error:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:[NSString stringWithFormat:@"routes/%d/routeTariffs", routeID] withContentType:WebRequestContentTypeJson withError:&*error];

    if (*error) {
        return nil;
    }

    if (results && ![results isEqual:[NSNull null]]) {
    	NSMutableArray *routeTariffs = [[NSMutableArray alloc] initWithObjects:nil];

        // Go through each one and add to the applications to an array
        for (NSDictionary *value in results) {
            [routeTariffs addObject:[FTRouteTariff populateWithDictionary:value]];
        }

        return [routeTariffs copy];
    }
    
    return nil;
}

+ (void)getAllByRoute:(NSInteger)routeID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:[NSString stringWithFormat:@"routes/%d/routeTariffs", routeID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  NSMutableArray *routeTariffs = [[NSMutableArray alloc] initWithObjects:nil];
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in returnedResults) {
						  [routeTariffs addObject:[FTRouteTariff populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([routeTariffs copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (FTRouteTariff *)getByID:(NSInteger)routeTariffID error:(NSError **)error {
	FTWebRequest *request = [[FTWebRequest alloc] init];
	
	NSDictionary *results = [request makeWebRequest:[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]
									withContentType:WebRequestContentTypeJson
										  withError:&*error];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		return [FTRouteTariff populateWithDictionary:results];
	}
	
	return nil;
}

+ (void)getByID:(NSInteger)routeTariffID usingCallback:(void (^)(FTRouteTariff *))returnRouteTariff errorBlock:(void (^)(NSError *))error {	
	FTWebRequest *request = [[FTWebRequest alloc] init];

	[request makeWebRequest:[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  
				  if (returnRouteTariff) {
					  returnRouteTariff([FTRouteTariff populateWithDictionary:returnedResults]);
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

+ (FTRouteTariff *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTRouteTariff alloc] initWithDictionary:dict];
}

- (FTRouteTariff *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];

    self.routeTariffID = [[dict objectForKey:@"id"] intValue];
    self.routeID = [[dict objectForKey:@"routeID"] intValue];
    self.facilityCode = [dict objectForKey:@"facilityCode"];
    self.description = [dict objectForKey:@"description"];
    
    if ([dict objectForKey:@"arrivingPortID"] && ![[dict objectForKey:@"arrivingPortID"] isKindOfClass:[NSNull class]]) {
        self.tariffCategoryID = [[dict objectForKey:@"tariffCategoryID"] intValue];
    }

    if ([dict objectForKey:@"arrivingPortID"] && ![[dict objectForKey:@"arrivingPortID"] isKindOfClass:[NSNull class]]) {
        self.minLength = [NSNumber numberWithFloat:[[dict objectForKey:@"minLength"] floatValue]];
    }
    self.maxLength = [dict objectForKey:@"maxLength"];
    self.amount = [dict objectForKey:@"amount"];
    self.perFootAmount = [dict objectForKey:@"perFootAmount"];
    self.startDate = [FTUtility convertToNSDate:[dict objectForKey:@"startDate"]];
    self.endDate = [FTUtility convertToNSDate:[dict objectForKey:@"endDate"]];
    self.roundTripAmount = [dict objectForKey:@"roundTripAmount"];
    self.vesselCode = [dict objectForKey:@"vesselCode"];
    return self;
}

- (NSDictionary *) routeTariffDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.routeTariffID], @"routeTariffID",
            self.routeID, @"routeID",
            self.tariffCategoryID, @"tariffCategoryID",
            self.facilityCode, @"facilityCode",
            self.description, @"description",
            self.minLength, @"minLength",
            self.maxLength, @"maxLength",
            self.amount, @"amount",
            self.perFootAmount, @"perFootAmount",
            self.startDate, @"startDate",
            self.endDate, @"endDate",
            self.roundTripAmount, @"roundTripAmount",
            self.vesselCode, @"vesselCode",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTRouteTariff alloc] init];

    if (self != nil) {
        self.routeTariffID = [coder decodeIntegerForKey:@"routeTariffID"];
        self.routeID = [coder decodeIntegerForKey:@"routeID"];
        self.tariffCategoryID = [coder decodeIntegerForKey:@"tariffCategoryID"];
        self.facilityCode = [coder decodeObjectForKey:@"facilityCode"];
        self.description = [coder decodeObjectForKey:@"description"];
        self.minLength = [coder decodeObjectForKey:@"minLength"];
        self.maxLength = [coder decodeObjectForKey:@"maxLength"];
        self.amount = [coder decodeObjectForKey:@"amount"];
        self.perFootAmount = [coder decodeObjectForKey:@"perFootAmount"];
        self.startDate = [coder decodeObjectForKey:@"startDate"];
        self.endDate = [coder decodeObjectForKey:@"endDate"];
        self.roundTripAmount = [coder decodeObjectForKey:@"roundTripAmount"];
        self.vesselCode = [coder decodeObjectForKey:@"vesselCode"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:routeTariffID forKey:@"routeTariffID"];
        [coder encodeInteger:routeID forKey:@"routeID"];
        [coder encodeInteger:tariffCategoryID forKey:@"tariffCategoryID"];
        [coder encodeObject:facilityCode forKey:@"facilityCode"];
        [coder encodeObject:description forKey:@"description"];
        [coder encodeObject:minLength forKey:@"minLength"];
        [coder encodeObject:maxLength forKey:@"maxLength"];
        [coder encodeObject:amount forKey:@"amount"];
        [coder encodeObject:perFootAmount forKey:@"perFootAmount"];
        [coder encodeObject:startDate forKey:@"startDate"];
        [coder encodeObject:endDate forKey:@"endDate"];
        [coder encodeObject:roundTripAmount forKey:@"roundTripAmount"];
        [coder encodeObject:vesselCode forKey:@"vesselCode"];
}

@end