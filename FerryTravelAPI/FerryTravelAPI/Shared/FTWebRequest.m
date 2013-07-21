
#import "FTWebRequest.h"
#import "FTUserDefaults.h"
#import "FTXMLParser.h"

@interface FTWebRequest (PRIVATE)

- (NSString *) createContentType:(WebRequestContentType)type;
- (NSMutableURLRequest *) createURLRequest:(NSURL *)url;

@end


@implementation FTWebRequest

@synthesize requestURL;
@synthesize responseData;
@synthesize requestError;
@synthesize storedBlock;
@synthesize webRequestErrorBlock;
@synthesize webRequestContentType;

- (void) makeWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))callBackBlock errorBlock:(void (^)(NSError *))errorBlock {

    self.storedBlock = callBackBlock;
	self.webRequestErrorBlock = errorBlock;
	self.webRequestContentType = contentType;
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
	
	// Create the request
	NSMutableURLRequest *request = [self createURLRequest:url];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) putWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error {
	
	NSError *localError = nil;
	NSURLResponse *localResponse = nil;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
    
    // Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];
	[request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Content-Type"]; 
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
	
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
														  returningResponse:&localResponse
																	  error:&localError];
	if (localError) {
        NSLog(@"Error occurred :: %@", localError);
		*error = localError;
		return nil;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		// Create new SBJSON parser object   
		return [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:*&error];;
    }
}


- (void) putWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error {

    self.storedBlock = returnedResults;
	self.webRequestErrorBlock = error;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
    
    // Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];	
	[request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Content-Type"]; 
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) postWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error {

	NSError *localError = nil;
	NSHTTPURLResponse *localResponse = nil;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
    
    // Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];
	[request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Content-Type"]; 
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
	
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
                                                          returningResponse:&localResponse
                                                                      error:&localError];
	
	if (localError) {
        NSLog(@"Error occurred :: %@", localError);
		*error = localError;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSInteger statusCode = [localResponse statusCode];
		NSLog(@"Web Request Response :: %@", responseBody);
		
		
		if (statusCode == 200) {
			return nil;
		}
		else if (statusCode == 201) {
			return [[localResponse allHeaderFields] objectForKey:@"Location"];
		}
		else {
			*error = [NSError errorWithDomain:@"com.52projects.BridgetechAPIClient" code:statusCode userInfo:nil];
		}
    }
    
    return nil;
}

- (void) postWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error {
    
    self.storedBlock = returnedResults;
    self.webRequestErrorBlock = error;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
	
    // Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];
	[request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Content-Type"]; 
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) makeWebRequest: (NSString *)urlLocation withContentType: (WebRequestContentType)contentType withError:(NSError **)error {
	
	NSError *localError = nil;
	NSHTTPURLResponse *localResponse = nil;
	self.webRequestContentType = contentType;
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
				  
	// Create the request 
	NSMutableURLRequest *request = [self createURLRequest:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"GET"];
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&localResponse
                                                     error:&localError];
	if (localError) {
        NSLog(@"Error occurred :: %@", localError);
		*error = [localError copy];
		return nil;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSInteger statusCode = [localResponse statusCode];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		switch (contentType) {
			case WebRequestContentTypeXml:
				return [FTXMLParser dictionaryForXMLString:responseBody error:&*error];
			case WebRequestContentTypeJson:
				if (statusCode < 300) {
					return [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:*&error];
				}
			default:
				break;
		}
    }
	
	return nil;
}

- (BOOL) deleteWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType withError:(NSError **)error {
	
	NSHTTPURLResponse *localResponse = nil;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
    
	// Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"DELETE"];
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
														  returningResponse:&localResponse
																	  error:&*error];
	if (*error) {
        NSLog(@"Error occurred :: %@", *error);
		return NO;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSInteger statusCode = [localResponse statusCode];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		if (statusCode < 300) {
			return YES;
		}
		else {
			*error = [NSError errorWithDomain:@"com.hivemindconsulting.BridgetechAPIClient" code:statusCode userInfo:nil];
			return NO;
		}
    }

}

- (void) deleteWebRequest:(NSString *)urlLocation withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))returnedResults errorBlock:(void (^)(NSError *))error {
	
	self.storedBlock = returnedResults;
    self.webRequestErrorBlock = error;
	self.webRequestContentType = contentType;
	NSURL *theUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[FTUserDefaults sharedDefaults] baseUrl], urlLocation]];
	
    // Create the request 
	NSMutableURLRequest *request = [self createURLRequest:theUrl];
    [request setHTTPMethod:@"DELETE"];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
	
}



#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse {
	response = aResponse;
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	
	int statusCode = [((NSHTTPURLResponse *)response) statusCode];
   
	if (statusCode >= 400) {
			[connection cancel];  // stop connecting; no more delegate messages
			NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
											  NSLocalizedString(@"Server returned status code %d",@""),
											  statusCode]
									  forKey:NSLocalizedDescriptionKey];
        NSError *statusError = [NSError errorWithDomain:@"dontknow"
							  code:statusCode
						  userInfo:errorInfo];
		
		self.webRequestErrorBlock(statusError);
    }
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)webError {
    self.webRequestErrorBlock(webError);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	
	NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"Web Request Response :: %@", responseBody);
	int statusCode = [((NSHTTPURLResponse *)response) statusCode];
	NSError *connectionError = nil;
	NSDictionary *storedBlockResults = nil;
	
	switch (self.webRequestContentType) {
		case WebRequestContentTypeXml:
			
			storedBlockResults = [FTXMLParser dictionaryForXMLString:responseBody error:&connectionError];
			
			if (connectionError) {
				self.webRequestErrorBlock(connectionError);
			}
			else {
				self.storedBlock(storedBlockResults);
			}
			break;
		case WebRequestContentTypeJson:
			if (statusCode < 300) {
				
				if(statusCode == 201) {
					
					NSString *location = [[((NSHTTPURLResponse *)response) allHeaderFields] objectForKey:@"Location"];
					self.storedBlock(location);
				}
				
				else if (statusCode != 204) {
					self.storedBlock([NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil]);
				}
				else {
					self.storedBlock(responseBody);
				}
			}
			else {
				self.webRequestErrorBlock([NSError errorWithDomain:@"com.52proejcts.ferrytravel" code:statusCode userInfo:nil]);
			}
		default:
			break;
	}
    
}

#pragma mark Base 64 encoding for credentials
static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
"abcdefghijklmnopqrstuvwxyz"
"0123456789"
"+/";

int encode(unsigned s_len, char *src, unsigned d_len, char *dst)
{
	unsigned triad;
	
	for (triad = 0; triad < s_len; triad += 3)
	{
		unsigned long int sr = 0;
		unsigned byte;
		
		for (byte = 0; (byte<3)&&(triad+byte<s_len); ++byte)
		{
			sr <<= 8;
			sr |= (*(src+triad+byte) & 0xff);
		}
		
		sr <<= (6-((8*byte)%6))%6; /*shift left to next 6bit alignment*/
		
		if (d_len < 4) return 1; /* error - dest too short */
		
		*(dst+0) = *(dst+1) = *(dst+2) = *(dst+3) = '=';
		switch(byte)
		{
			case 3:
				*(dst+3) = base64[sr&0x3f];
				sr >>= 6;
			case 2:
				*(dst+2) = base64[sr&0x3f];
				sr >>= 6;
			case 1:
				*(dst+1) = base64[sr&0x3f];
				sr >>= 6;
				*(dst+0) = base64[sr&0x3f];
		}
		dst += 4; d_len -= 4;
	}
	
	return 0;
	
}
#pragma mark Private Methods

- (NSString *) createContentType:(WebRequestContentType)type {
	
	switch (type) {
		case WebRequestContentTypeXml:
			return @"application/xml";
		case WebRequestContentTypeJson:
			return @"application/json";
	}
	
	return nil;
}

 - (NSMutableURLRequest *) createURLRequest:(NSURL *)url {
	 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];	
	 [request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Accept"];
	 [request setValue:[self createContentType:[self webRequestContentType]] forHTTPHeaderField:@"Content-Type"];
	 //[request setValue:[NSString stringWithFormat: @"BEARER %@", [[BTUserDefaults sharedDefaults] accessToken]] forHTTPHeaderField:@"Authorization"];
	 
	 return request;
 }
	 
@end
