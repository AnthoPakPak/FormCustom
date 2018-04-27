#import "FORMPhoneNumberFormatter.h"

@implementation FORMPhoneNumberFormatter

- (NSString *)formatString:(NSString *)string reverse:(BOOL)reverse {
    string = [super formatString:string reverse:reverse];
    if (!string) return nil;

    NSString *rawString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (reverse) return rawString;

    BOOL hasCountryCode = (rawString.length > 2 &&
                           [[rawString substringToIndex:2] isEqualToString:@"00"]);

    NSMutableString *mutableString = [NSMutableString new];
    NSUInteger idx = 0;
    NSString *characterString;

    while (idx < rawString.length) {
        characterString = [NSString stringWithFormat:@"%c", [rawString characterAtIndex:idx]];
        [mutableString appendString:characterString];

            if (idx == 3 && hasCountryCode) [mutableString appendString:@" "];
            if ((idx == 2 || idx == 4)
                && !hasCountryCode) [mutableString appendString:@" "];
        ++idx;
    }

    return mutableString;
}

@end
