@interface FTRouteSchedule : NSObject <NSCoding>

@property (nonatomic) NSInteger routeScheduleID;
@property (nonatomic) NSInteger routeID;
@property (nonatomic, strong) NSString *vesselCode;
@property (nonatomic, strong) NSString *vesselName;
@property (nonatomic, strong) NSDate *departDateTime;
@property (nonatomic, strong) NSDate *arriveDateTime;

+ (FTRouteSchedule *) populateWithDictionary: (NSDictionary *)dict;


/*!
@method getAllByRoute:
@abstract
Performs a synchronous call to the API routeSchedule
resource to get all schedules for a route.
@discussion
@param
routeID: the route to get schedules for
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An array of routeSchedule objects or nil if
the load failed.
*/
+ (NSArray *)getAllByRoute:(NSInteger)routeID error:(NSError **)error;


/*!
@method getAllUsingCallback:error:
@abstract
Performs an asynchronous call to the API routeSchedule 
resource to get all schedules for a route.
@discussion
@param
 routeID: the route to get schedules for
@param
resultsBlock The block that is performed after the
request to the app harbor api has happened.
@param
errorBlock If the requests errors for any reason,
a block is available for that
@result An array of routeSchedule objects or nil if
the load failed.
*/
+ (void)getAllByRoute:(NSInteger)routeID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;

/*!
@method getByID:error:
@abstract
Performs an asynchronous call to the API routeSchedule resource.
@discussion
@param
routeScheduleID is a variable that API uses
to distinguish between routeSchedules. 
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An FTRouteSchedule object that holds the information
about the routeSchedule that was retrieved
*/
+ (FTRouteSchedule *)getByID:(NSInteger)routeScheduleID error:(NSError **)error;


/*!
@method getByID:usingCallback:errorBlock:
@abstract
Performs an asynchronous call to the API resource
@discussion
@param
routeScheduleID is a variable that API uses
to distinguish between routeSchedules. 
@param
resultsBlock The block that is performed after the
request to the api has happened.
@param
error If the requests errors for any reason,
a block is available for that

*/
+ (void)getByID:(NSInteger)routeScheduleID usingCallback:(void (^)(FTRouteSchedule *))routeSchedule errorBlock:(void (^)(NSError *))error;


@end