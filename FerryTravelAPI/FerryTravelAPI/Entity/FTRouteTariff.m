#import "FTRouteTariff.h"
#import "WebRequest.h"
#import "FTUserDefaults.h"

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

+ (NSArray *)getAll:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:@"routeTariffs" withContentType:WebRequestContentTypeJson withError:&*error]

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

+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {	
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:@"routeTariffs"
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

- (BOOL) create:(NSError *__autoreleasing *)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeTariffDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"routeTariffs"
            withContentType:WebRequestContentTypeJson
                   withData:jsonData
                  withError:&*error];

    if (*error) {
        return NO;
    }

    return YES;
}

- (void) createUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeTariffDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"routeTariffs"
            withContentType:WebRequestContentTypeJson
                   withData:jsonData
              usingCallback:^(id returnedResults) {
                isSuccessful(YES);
              }
                errorBlock:^(NSError *localError) {
                    if (error) {
                        error(localError);
                    }
                }
    ];
}

- (BOOL) update:(NSError *__autoreleasing *)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeTariffDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]"
           withContentType:WebRequestContentTypeJson
                  withData:jsonData
                 withError:&*error];

    if (*error) {
        return NO;
    }

    return YES;
}

- (void) updateUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeTariffDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]"
           withContentType:WebRequestContentTypeJson
                  withData:jsonData
             usingCallback:^(id returnedResults) {
                isSuccessful(YES);
             }
               errorBlock:^(NSError *localError) {
                 if (error) {
                    error(localError);
                 }
                }
    ];
}

- (BOOL) delete:(NSError *__autoreleasing *)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];

    [request deleteWebRequest:@"[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]"
              withContentType:WebRequestContentTypeJson
                    withError:&*error];
    
    if (*error) {
        return NO;
    }

    return YES;
}

- (void) deleteUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];

    [request deleteWebRequest:@"[NSString stringWithFormat:@"routeTariffs/%d", routeTariffID]"
              withContentType:WebRequestContentTypeJson
                usingCallback:^(id returnedResults) {
                    isSuccessful(YES);
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
    
        self.routeTariffID = [dict integerForKey:@"routeTariffID"];
        self.routeID = [dict integerForKey:@"routeID"];
        self.tariffCategoryID = [dict integerForKey:@"tariffCategoryID"];
        self.facilityCode = [dict objectForKey:@"facilityCode"];
        self.description = [dict objectForKey:@"description"];
        self.minLength = [dict floatForKey:@"minLength"];
        self.maxLength = [dict floatForKey:@"maxLength"];
        self.amount = [dict floatForKey:@"amount"];
        self.perFootAmount = [dict floatForKey:@"perFootAmount"];
        self.startDate = [dict objectForKey:@"startDate"];
        self.endDate = [dict objectForKey:@"endDate"];
        self.roundTripAmount = [dict floatForKey:@"roundTripAmount"];
        self.vesselCode = [dict objectForKey:@"vesselCode"];
    return self;
}

- (NSDictionary *) routeTariffDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.routeTariffID, @"routeTariffID",
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
        self.minLength = [coder decodeFloatForKey:@"minLength"];
        self.maxLength = [coder decodeFloatForKey:@"maxLength"];
        self.amount = [coder decodeFloatForKey:@"amount"];
        self.perFootAmount = [coder decodeFloatForKey:@"perFootAmount"];
        self.startDate = [coder decodeObjectForKey:@"startDate"];
        self.endDate = [coder decodeObjectForKey:@"endDate"];
        self.roundTripAmount = [coder decodeFloatForKey:@"roundTripAmount"];
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
        [coder encodeFloat:minLength forKey:@"minLength"];
        [coder encodeFloat:maxLength forKey:@"maxLength"];
        [coder encodeFloat:amount forKey:@"amount"];
        [coder encodeFloat:perFootAmount forKey:@"perFootAmount"];
        [coder encodeObject:startDate forKey:@"startDate"];
        [coder encodeObject:endDate forKey:@"endDate"];
        [coder encodeFloat:roundTripAmount forKey:@"roundTripAmount"];
        [coder encodeObject:vesselCode forKey:@"vesselCode"];
}

@end