#import "FTOperator.h"
#import "FTWebRequest.h"
#import "FTUserDefaults.h"

@interface FTOperator (PRIVATE)

- (FTOperator *)initWithDictionary: (NSDictionary *)dict;

- (NSDictionary *) operatordictionary;

@end


@implementation FTOperator
    @synthesize operatorID;
    @synthesize name;
    @synthesize surcharge;

#pragma mark - Data Methods

+ (NSArray *)getAll:(NSError **)error {
    FTWebRequest *request = [[FTWebRequest alloc] init];
    NSArray *results = [request makeWebRequest:@"operators" withContentType:WebRequestContentTypeJson withError:&*error];

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

#pragma mark - Population Methods

+ (FTOperator *)populateWithDictionary:(NSDictionary *)dict {
    return [[FTOperator alloc] initWithDictionary:dict];
}

- (FTOperator *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];

    self.operatorID = [[dict objectForKey:@"operatorID"] intValue];
    self.name = [dict objectForKey:@"name"];

    if ([dict objectForKey:@"surcharge"] && ![[dict objectForKey:@"surcharge"] isKindOfClass:[NSNull class]]) {
        self.surcharge = [[dict objectForKey:@"surcharge"] floatValue];
    }
    return self;
}

- (NSDictionary *) operatorDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.operatorID], @"operatorID",
            self.name, @"name",
            self.surcharge, @"surcharge",
        nil];
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
    self = [[FTOperator alloc] init];

    if (self != nil) {
        self.operatorID = [coder decodeIntegerForKey:@"operatorID"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.surcharge = [coder decodeFloatForKey:@"surcharge"];
    }

return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
        [coder encodeInteger:operatorID forKey:@"operatorID"];
        [coder encodeObject:name forKey:@"name"];
        [coder encodeFloat:surcharge forKey:@"surcharge"];
}

@end