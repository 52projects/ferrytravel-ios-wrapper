@interface FTOperator : NSObject <NSCoding>

    @property (nonatomic) NSInteger operatorID
    @property (nonatomic, strong) NSString *name
    @property (nonatomic, strong) NSString *monitoringDirectory
    @property (nonatomic, strong) NSNumber *surcharge

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

/*!
@method create:
@abstract
Performs a synchronous call to the API
to create a new operator
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (BOOL) create: (NSError **)error;

/*!
@method createUsingCallback:errorBlock
@abstract
Performs an asynchronous call to the API
to create a new operator
@param
isSuccessful Block that gives a boolean on whether or not
the operation was successful
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (void)createUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error;


/*!
@method update:
@abstract
Performs a synchronous call to the API
to update the existing operator
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (BOOL) update: (NSError **)error;

/*!
@method updateUsingCallback:errorBlock
@abstract
Performs an asynchronous call to the API
to update the existing operator
@param
isSuccessful Block that gives a boolean on whether or not
the operation was successful
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (void)updateUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error;

/*!
@method delete:
@abstract
Performs a synchronous call to API
to delete the existing operator.
@discussion
It is highly recommended that when calling this method you
give the user a warning on what is about to happen
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (BOOL) delete: (NSError **)error;

/*!
@method deleteUsingCallback:errorBlock
@abstract
Performs an asynchronous call to the API
to delete the existing operator.
@discussion
It is highly recommended that when calling this method you
give the user a warning on what is about to happen
@param
isSuccessful Block that gives a boolean on whether or not
the operation was successful
@param
error Out parameter (may be NULL) used if an error occurs
while processing the request. Will not be modified if the
load succeeds.
*/
- (void)deleteUsingCallback:(void (^)(BOOL))isSuccessful errorBlock:(void (^)(NSError *))error;

@end