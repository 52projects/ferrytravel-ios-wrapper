#import "FTOperator.h"
#import "WebRequest.h"
#import "FTUserDefaults.h"

@interface FTOperator (PRIVATE)

- (FTOperator *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) operatordictionary;

@end


@implementation FTOperator
    @synthesize operatorID;
    @synthesize name;
    @synthesize monitoringDirectory;
    @synthesize surcharge;

#pragma mark - Data Methods

+ (NSArray *)getAll:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:@"operators" withContentType:WebRequestContentTypeJson withError:&*error]

    if (*error) {
        return nil;
    }

    if (results && ![results isEqual:[NSNull null]]) {
    	NSMutableArray *operators = [[NSMutableArray alloc] initWithObjects:nil];

        // Go through each one and add to the applications to an array
        for (NSDictionary *value in results) {
            [operators addObject:[FTOperator populateWithDictionary:value]];
        }

        return [operators copy];
    }
    
    return nil;
}

+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {	
    FTWebRequest *request = [[FTWebRequest alloc] init];
    
    [request makeWebRequest:@"operators"
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  NSMutableArray *operators = [[NSMutableArray alloc] initWithObjects:nil];
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in returnedResults) {
						  [operators addObject:[FTOperator populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([operators copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (FTOperator *)getByID:(NSInteger)operatorID error:(NSError **)error {
	FTWebRequest *request = [[FTWebRequest alloc] init];
	
	NSDictionary *results = [request makeWebRequest:[NSString stringWithFormat:@"operators/%d", operatorID]
									withContentType:WebRequestContentTypeJson
										  withError:&*error];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		return [FTOperator populateWithDictionary:results];
	}
	
	return nil;
}

+ (void)getByID:(NSInteger)operatorID usingCallback:(void (^)(FTOperator *))returnOperator errorBlock:(void (^)(NSError *))error {	
	FTWebRequest *request = [[FTWebRequest alloc] init];

	[request makeWebRequest:[NSString stringWithFormat:@"operators/%d", operatorID]
			withContentType:WebRequestContentTypeJson
			  usingCallback:^(id returnedResults) {
				  
				  if (returnOperator) {
					  returnOperator([FTOperator populateWithDictionary:returnedResults]);
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
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self operatorDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"operators"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self operatorDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request postWebRequest:@"operators"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self operatorDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"operators/%d", operatorID]"
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
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self operatorDictionary] options:NSJSONWritingPrettyPrinted error:&error];

    [request putWebRequest:@"[NSString stringWithFormat:@"operators/%d", operatorID]"
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

    [request deleteWebRequest:@"[NSString stringWithFormat:@"operators/%d", operatorID]"
              withContentType:WebRequestContentTypeJson
                    withError:&*error];
    
    if (*error) {
        return NO;
    }

    return YES;
}

- (void) deleteUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error {
    FTWebRequest *request = [[FTWebRequest alloc] init];

    [request deleteWebRequest:@"[NSString stringWithFormat:@"operators/%d", operatorID]"
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

+ (FTOperator *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTOperator alloc] initWithDictionary:dict];
}

- (FTOperator *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
        self.operatorID = [dict integerForKey:@"operatorID"];
        self.name = [dict objectForKey:@"name"];
        self.monitoringDirectory = [dict objectForKey:@"monitoringDirectory"];
        self.surcharge = [dict floatForKey:@"surcharge"];
    return self;
}

- (NSDictionary *) operatorDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.operatorID, @"operatorID",
            self.name, @"name",
            self.monitoringDirectory, @"monitoringDirectory",
            self.surcharge, @"surcharge",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTOperator alloc] init];

    if (self != nil) {
        self.operatorID = [coder decodeIntegerForKey:@"operatorID"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.monitoringDirectory = [coder decodeObjectForKey:@"monitoringDirectory"];
        self.surcharge = [coder decodeFloatForKey:@"surcharge"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:operatorID forKey:@"operatorID"];
        [coder encodeObject:name forKey:@"name"];
        [coder encodeObject:monitoringDirectory forKey:@"monitoringDirectory"];
        [coder encodeFloat:surcharge forKey:@"surcharge"];
}

@end