#import "FTRoute.h"
#import "WebRequest.h"
#import "FTUserDefaults.h"

@interface FTRoute (PRIVATE)

- (FTRoute *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) routedictionary;

@end


@implementation FTRoute
    @synthesize routeID;
    @synthesize operatorID;
    @synthesize name;
    @synthesize departingPortID;
    @synthesize arrivingPortID;
    @synthesize active;
    @synthesize description;

#pragma mark - Data Methods

+ (NSArray *)getAll:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:@"routes" withContentType:WebRequestContentTypeJson withError:&*error]

    if (*error) {
        return nil;
    }

    if (results && ![results isEqual:[NSNull null]]) {
    	NSMutableArray *routes = [[NSMutableArray alloc] initWithObjects:nil];

        // Go through each one and add to the applications to an array
        for (NSDictionary *value in results) {
            [routes addObject:[FTRoute populateWithDictionary:value]];
        }

        return [routes copy];
    }
    
    return nil;
}

+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {	
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:@"routes"
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  NSMutableArray *routes = [[NSMutableArray alloc] initWithObjects:nil];
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in returnedResults) {
						  [routes addObject:[FTRoute populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([routes copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (FTRoute *)getByID:(NSInteger)routeID error:(NSError **)error {
	FTWebRequest *request = [[FTWebRequest alloc] init];
	
	NSDictionary *results = [request makeWebRequest:[NSString stringWithFormat:@"routes/%d", routeID]
									withContentType:WebRequestContentTypeJson
										  withError:&*error];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		return [FTRoute populateWithDictionary:results];
	}
	
	return nil;
}

+ (void)getByID:(NSInteger)routeID usingCallback:(void (^)(FTRoute *))returnRoute errorBlock:(void (^)(NSError *))error {	
	FTWebRequest *request = [[FTWebRequest alloc] init];

	[request makeWebRequest:[NSString stringWithFormat:@"routes/%d", routeID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  
				  if (returnRoute) {
					  returnRoute([FTRoute populateWithDictionary:returnedResults]);
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
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"routes"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"routes"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"routes/%d", routeID]"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self routeDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"routes/%d", routeID]"
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

    [request deleteWebRequest:@"[NSString stringWithFormat:@"routes/%d", routeID]"
              withContentType:WebRequestContentTypeJson
                    withError:&*error];
    
    if (*error) {
        return NO;
    }

    return YES;
}

- (void) deleteUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];

    [request deleteWebRequest:@"[NSString stringWithFormat:@"routes/%d", routeID]"
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

+ (FTRoute *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTRoute alloc] initWithDictionary:dict];
}

- (FTRoute *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
        self.routeID = [dict integerForKey:@"routeID"];
        self.operatorID = [dict integerForKey:@"operatorID"];
        self.name = [dict objectForKey:@"name"];
        self.departingPortID = [dict integerForKey:@"departingPortID"];
        self.arrivingPortID = [dict integerForKey:@"arrivingPortID"];
        self.active = [dict boolForKey:@"active"];
        self.description = [dict objectForKey:@"description"];
    return self;
}

- (NSDictionary *) routeDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.routeID, @"routeID",
            self.operatorID, @"operatorID",
            self.name, @"name",
            self.departingPortID, @"departingPortID",
            self.arrivingPortID, @"arrivingPortID",
            self.active, @"active",
            self.description, @"description",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTRoute alloc] init];

    if (self != nil) {
        self.routeID = [coder decodeIntegerForKey:@"routeID"];
        self.operatorID = [coder decodeIntegerForKey:@"operatorID"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.departingPortID = [coder decodeIntegerForKey:@"departingPortID"];
        self.arrivingPortID = [coder decodeIntegerForKey:@"arrivingPortID"];
        self.active = [coder decodeBoolForKey:@"active"];
        self.description = [coder decodeObjectForKey:@"description"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:routeID forKey:@"routeID"];
        [coder encodeInteger:operatorID forKey:@"operatorID"];
        [coder encodeObject:name forKey:@"name"];
        [coder encodeInteger:departingPortID forKey:@"departingPortID"];
        [coder encodeInteger:arrivingPortID forKey:@"arrivingPortID"];
        [coder encodeBool:active forKey:@"active"];
        [coder encodeObject:description forKey:@"description"];
}

@end