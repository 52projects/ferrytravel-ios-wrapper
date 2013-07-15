#import "FTPort.h"
#import "WebRequest.h"
#import "FTUserDefaults.h"

@interface FTPort (PRIVATE)

- (FTPort *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) portdictionary;

@end


@implementation FTPort
    @synthesize portId;
    @synthesize code;
    @synthesize name;
    @synthesize city;
    @synthesize state;
    @synthesize countryID;
    @synthesize latitude;
    @synthesize longitude;
    @synthesize geographyDefinition;

#pragma mark - Data Methods

+ (NSArray *)getAll:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:@"ports" withContentType:WebRequestContentTypeJson withError:&*error]

    if (*error) {
        return nil;
    }

    if (results && ![results isEqual:[NSNull null]]) {
    	NSMutableArray *ports = [[NSMutableArray alloc] initWithObjects:nil];

        // Go through each one and add to the applications to an array
        for (NSDictionary *value in results) {
            [ports addObject:[FTPort populateWithDictionary:value]];
        }

        return [ports copy];
    }
    
    return nil;
}

+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {	
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:@"ports"
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  NSMutableArray *ports = [[NSMutableArray alloc] initWithObjects:nil];
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in returnedResults) {
						  [ports addObject:[FTPort populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([ports copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (FTPort *)getByID:(NSInteger)portID error:(NSError **)error {
	FTWebRequest *request = [[FTWebRequest alloc] init];
	
	NSDictionary *results = [request makeWebRequest:[NSString stringWithFormat:@"ports/%d", portID]
									withContentType:WebRequestContentTypeJson
										  withError:&*error];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		return [FTPort populateWithDictionary:results];
	}
	
	return nil;
}

+ (void)getByID:(NSInteger)portID usingCallback:(void (^)(FTPort *))returnPort errorBlock:(void (^)(NSError *))error {	
	FTWebRequest *request = [[FTWebRequest alloc] init];

	[request makeWebRequest:[NSString stringWithFormat:@"ports/%d", portID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  
				  if (returnPort) {
					  returnPort([FTPort populateWithDictionary:returnedResults]);
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
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self portDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"ports"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self portDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"ports"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self portDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"ports/%d", portID]"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self portDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"ports/%d", portID]"
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

    [request deleteWebRequest:@"[NSString stringWithFormat:@"ports/%d", portID]"
              withContentType:WebRequestContentTypeJson
                    withError:&*error];
    
    if (*error) {
        return NO;
    }

    return YES;
}

- (void) deleteUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];

    [request deleteWebRequest:@"[NSString stringWithFormat:@"ports/%d", portID]"
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

+ (FTPort *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTPort alloc] initWithDictionary:dict];
}

- (FTPort *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
        self.portId = [dict integerForKey:@"portId"];
        self.code = [dict objectForKey:@"code"];
        self.name = [dict objectForKey:@"name"];
        self.city = [dict objectForKey:@"city"];
        self.state = [dict objectForKey:@"state"];
        self.countryID = [dict integerForKey:@"countryID"];
        self.latitude = [dict floatForKey:@"latitude"];
        self.longitude = [dict floatForKey:@"longitude"];
        self.geographyDefinition = [dict objectForKey:@"geographyDefinition"];
    return self;
}

- (NSDictionary *) portDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.portId, @"portId",
            self.code, @"code",
            self.name, @"name",
            self.city, @"city",
            self.state, @"state",
            self.countryID, @"countryID",
            self.latitude, @"latitude",
            self.longitude, @"longitude",
            self.geographyDefinition, @"geographyDefinition",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTPort alloc] init];

    if (self != nil) {
        self.portId = [coder decodeIntegerForKey:@"portId"];
        self.code = [coder decodeObjectForKey:@"code"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.city = [coder decodeObjectForKey:@"city"];
        self.state = [coder decodeObjectForKey:@"state"];
        self.countryID = [coder decodeIntegerForKey:@"countryID"];
        self.latitude = [coder decodeFloatForKey:@"latitude"];
        self.longitude = [coder decodeFloatForKey:@"longitude"];
        self.geographyDefinition = [coder decodeObjectForKey:@"geographyDefinition"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:portId forKey:@"portId"];
        [coder encodeObject:code forKey:@"code"];
        [coder encodeObject:name forKey:@"name"];
        [coder encodeObject:city forKey:@"city"];
        [coder encodeObject:state forKey:@"state"];
        [coder encodeInteger:countryID forKey:@"countryID"];
        [coder encodeFloat:latitude forKey:@"latitude"];
        [coder encodeFloat:longitude forKey:@"longitude"];
        [coder encodeObject:geographyDefinition forKey:@"geographyDefinition"];
}

@end