@interface FTPort : NSObject <NSCoding>

@property (nonatomic) NSInteger portID;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic) NSInteger countryID;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic) id geographyDefinition;

+ (FTPort *) populateWithDictionary: (NSDictionary *)dict;


/*!
@method getAll:
@abstract
Performs a synchronous call to the API port
resource.
@discussion
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An array of port objects or nil if
the load failed.
*/
+ (NSArray *)getAll:(NSError **)error;


/*!
@method getAllUsingCallback:error:
@abstract
Performs an asynchronous call to the API port resource.
@discussion
@param
resultsBlock The block that is performed after the
request to the app harbor api has happened.
@param
errorBlock If the requests errors for any reason,
a block is available for that
@result An array of port objects or nil if
the load failed.
*/
+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*!
@method getByID:error:
@abstract
Performs an asynchronous call to the API port resource.
@discussion
@param
portID is a variable that API uses
to distinguish between ports. 
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
@result An FTPort object that holds the information
about the port that was retrieved
*/
+ (FTPort *)getByID:(NSInteger)portID error:(NSError **)error;


/*!
@method getByID:usingCallback:errorBlock:
@abstract
Performs an asynchronous call to the API resource
@discussion
@param
portID is a variable that API uses
to distinguish between ports. 
@param
resultsBlock The block that is performed after the
request to the api has happened.
@param
error If the requests errors for any reason,
a block is available for that

*/
+ (void)getByID:(NSInteger)portID usingCallback:(void (^)(FTPort *))port errorBlock:(void (^)(NSError *))error;


@end