@interface FTRoute : NSObject <NSCoding>

@property (nonatomic) NSInteger routeID;
@property (nonatomic) NSInteger operatorID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger departingPortID;
@property (nonatomic) NSInteger arrivingPortID;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *description;

+ (FTRoute *) populateWithDictionary: (NSDictionary *)dict;


/*!
@method getAll:
@abstract
Performs a synchronous call to the API route
resource.
@discussion
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An array of route objects or nil if
the load failed.
*/
+ (NSArray *)getAll:(NSError **)error;


/*!
@method getAllUsingCallback:error:
@abstract
Performs an asynchronous call to the API route resource.
@discussion
@param
resultsBlock The block that is performed after the
request to the app harbor api has happened.
@param
errorBlock If the requests errors for any reason,
a block is available for that
@result An array of route objects or nil if
the load failed.
*/
+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*!
 @method getAllByDepartingPort:
 @abstract
 Performs a synchronous call to the API route
 resource.
 @discussion
 gets the routes for the departing port specified
 @param
 portID: The departing port to find routes for
 @param
 error Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the
 load succeeds.
 @result An array of route objects or nil if
 the load failed.
 */
+ (NSArray *)getAllByDepartingPort:(NSInteger)portID error:(NSError **)error;


/*!
 @method getAllByDepartingPort:
 @abstract
 Performs an asynchronous call to the API route resource.
 @discussion
 gets the routes for the departing port specified
 @param
 portID: The departing port to find routes for
 @param
 resultsBlock The block that is performed after the
 request to the app harbor api has happened.
 @param
 errorBlock If the requests errors for any reason,
 a block is available for that
 @result An array of route objects or nil if
 the load failed.
 */
+ (void)getAllByDepartingPort:(NSInteger)portID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*!
@method getByID:error:
@abstract
Performs an asynchronous call to the API route resource.
@discussion
@param
routeID is a variable that API uses
to distinguish between routes. 
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An FTRoute object that holds the information
about the route that was retrieved
*/
+ (FTRoute *)getByID:(NSInteger)routeID error:(NSError **)error;


/*!
@method getByID:usingCallback:errorBlock:
@abstract
Performs an asynchronous call to the API resource
@discussion
@param
routeID is a variable that API uses
to distinguish between routes. 
@param
resultsBlock The block that is performed after the
request to the api has happened.
@param
error If the requests errors for any reason,
a block is available for that

*/
+ (void)getByID:(NSInteger)routeID usingCallback:(void (^)(FTRoute *))route errorBlock:(void (^)(NSError *))error;


@end