#import "FTRoute.h"
#import "FTWebRequest.h"
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
    NSArray *results = [request makeWebRequest:@"routes" withContentType:WebRequestContentTypeJson withError:&*error];

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

+ (NSArray *)getAllByDepartingPort:(NSInteger)portID error:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:[NSString stringWithFormat:@"ports/%d/routes", portID] withContentType:WebRequestContentTypeJson withError:&*error];
    
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

+ (void)getAllByDepartingPort:(NSInteger)portID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:[NSString stringWithFormat:@"ports/%d/routes", portID]
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
#pragma mark - Population Methods

+ (FTRoute *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTRoute alloc] initWithDictionary:dict];
}

- (FTRoute *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    self.name = [dict objectForKey:@"name"];
    self.routeID = [[dict objectForKey:@"id"] intValue];
    self.description = [dict objectForKey:@"description"];
    
    if ([dict objectForKey:@"surcharge"] && ![[dict objectForKey:@"surcharge"] isKindOfClass:[NSNull class]]) {
        self.operatorID = [[dict objectForKey:@"operatorID"] intValue];
    }
    if ([dict objectForKey:@"departingPortID"] && ![[dict objectForKey:@"departingPortID"] isKindOfClass:[NSNull class]]) {
        self.departingPortID = [[dict objectForKey:@"departingPortID"] intValue];
    }
    
    if ([dict objectForKey:@"arrivingPortID"] && ![[dict objectForKey:@"arrivingPortID"] isKindOfClass:[NSNull class]]) {
        self.arrivingPortID = [[dict objectForKey:@"arrivingPortID"] intValue];
    }
    
    if ([dict objectForKey:@"active"] && ![[dict objectForKey:@"active"] isKindOfClass:[NSNull class]]) {
        self.active = [[dict objectForKey:@"active"] boolValue];
    }

    return self;
}

- (NSDictionary *) routeDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.routeID], @"routeID",
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