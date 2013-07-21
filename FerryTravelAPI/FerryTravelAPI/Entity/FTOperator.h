@interface FTOperator : NSObject <NSCoding>

@property (nonatomic) NSInteger operatorID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) float surcharge;

+ (FTOperator *) populateWithDictionary: (NSDictionary *)dict;


/*!
@method getAll:
@abstract
Performs a synchronous call to the API operator
resource.
@discussion
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An array of operator objects or nil if
the load failed.
*/
+ (NSArray *)getAll:(NSError **)error;


/*!
@method getAllUsingCallback:error:
@abstract
Performs an asynchronous call to the API operator resource.
@discussion
@param
resultsBlock The block that is performed after the
request to the app harbor api has happened.
@param
errorBlock If the requests errors for any reason,
a block is available for that
@result An array of operator objects or nil if
the load failed.
*/
+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*!
@method getByID:error:
@abstract
Performs an asynchronous call to the API operator resource.
@discussion
@param
operatorID is a variable that API uses
to distinguish between operators. 
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An FTOperator object that holds the information
about the operator that was retrieved
*/
+ (FTOperator *)getByID:(NSInteger)operatorID error:(NSError **)error;


/*!
@method getByID:usingCallback:errorBlock:
@abstract
Performs an asynchronous call to the API resource
@discussion
@param
operatorID is a variable that API uses
to distinguish between operators. 
@param
resultsBlock The block that is performed after the
request to the api has happened.
@param
error If the requests errors for any reason,
a block is available for that

*/
+ (void)getByID:(NSInteger)operatorID usingCallback:(void (^)(FTOperator *))operator errorBlock:(void (^)(NSError *))error;

@end