
@interface FTDateUtility : NSObject {

}

// Converts a string to a full date and time
+ (NSDate *)dateAndTimeFromString:(NSString *)dateString;

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)stringFromDateAndTimeFrom:(NSDate *)date;

// Catch all for dates, insert a custom date format for the date
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat: (NSString *)format;

// Catch all for dates, insert a custom date format for the date
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat: (NSString *)format;

+ (NSString *)getUTCFormateDate:(NSDate *)localDate;

@end
