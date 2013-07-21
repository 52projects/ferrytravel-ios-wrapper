@interface FTRouteTariff : NSObject <NSCoding>

@property (nonatomic) NSInteger routeTariffID;
@property (nonatomic) NSInteger routeID;
@property (nonatomic) NSInteger tariffCategoryID;
@property (nonatomic, strong) NSString *facilityCode;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *minLength;
@property (nonatomic, strong) NSNumber *maxLength;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *perFootAmount;
@property (nonatomic) id startDate;
@property (nonatomic) id endDate;
@property (nonatomic, strong) NSNumber *roundTripAmount;
@property (nonatomic, strong) NSString *vesselCode;

+ (FTRouteTariff *) populateWithDictionary: (NSDictionary *)dict;


/*!
@method getAll:
@abstract
Performs a synchronous call to the API routeTariff
resource.
@discussion
 @param
 routeID: The route id to get tariffs for
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An array of routeTariff objects or nil if
the load failed.
*/
+ (NSArray *)getAllByRoute:(NSInteger)routeID error:(NSError **)error;


/*!
@method getAllUsingCallback:error:
@abstract
Performs an asynchronous call to the API routeTariff resource.
@discussion
 @param
 routeID: The route id to get tariffs for
@param
resultsBlock The block that is performed after the
request to the app harbor api has happened.
@param
errorBlock If the requests errors for any reason,
a block is available for that
@result An array of routeTariff objects or nil if
the load failed.
*/
+ (void)getAllByRoute:(NSInteger)routeID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*!
@method getByID:error:
@abstract
Performs an asynchronous call to the API routeTariff resource.
@discussion
@param
routeTariffID is a variable that API uses
to distinguish between routeTariffs. 
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An FTRouteTariff object that holds the information
about the routeTariff that was retrieved
*/
+ (FTRouteTariff *)getByID:(NSInteger)routeTariffID error:(NSError **)error;


/*!
@method getByID:usingCallback:errorBlock:
@abstract
Performs an asynchronous call to the API resource
@discussion
@param
routeTariffID is a variable that API uses
to distinguish between routeTariffs. 
@param
resultsBlock The block that is performed after the
request to the api has happened.
@param
error If the requests errors for any reason,
a block is available for that

*/
+ (void)getByID:(NSInteger)routeTariffID usingCallback:(void (^)(FTRouteTariff *))routeTariff errorBlock:(void (^)(NSError *))error;


@end