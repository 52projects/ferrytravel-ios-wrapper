

#import <Foundation/Foundation.h>


/* Enum that informs the search methods what to include in the search parameters */
typedef enum {
	WebRequestContentTypeXml, // The content type of the request is xml
	WebRequestContentTypeJson, // The content type of the request is json
} WebRequestContentType;

@interface FTWebRequest : NSObject {

	NSURL *requestURL;
	NSURLResponse *response;
	NSURLConnection *connection;
	NSMutableData *responseData;
	NSError *requestError;
	WebRequestContentType webRequestContentType;
}

@property (nonatomic, retain) NSURL *requestURL;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSError *requestError;
@property (nonatomic, assign) WebRequestContentType webRequestContentType;
@property(copy) void (^storedBlock)(id);
@property (copy) void (^webRequestErrorBlock)(NSError*);

//- (BOOL) authenticateWebRequest: (NSString *)location withUserName:(NSString *)username withPassword:(NSString *)password withError:(NSError **)error;

- (id) makeWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withError:(NSError **)error;

- (void) makeWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))callBackBlock errorBlock:(void (^)(NSError *))errorBlock;

- (id) putWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error;

- (void) putWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error;

- (id) postWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData: (NSData *)data withError:(NSError **)error;

- (void) postWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error;

- (BOOL) deleteWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withError:(NSError **)error;

- (void) deleteWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error;


@end

