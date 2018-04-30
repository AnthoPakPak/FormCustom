@import Foundation;

#import "FORMFieldValidation.h"

typedef NS_ENUM(NSInteger, FORMValidationResultType) {
    FORMValidationResultTypeValid = 0,
    FORMValidationResultTypeInvalid,
    FORMValidationResultTypeInvalidValue,
    FORMValidationResultTypeInvalidBankAccount,
    FORMValidationResultTypeInvalidFormat,
    FORMValidationResultTypeInvalidPostalCode,
    FORMValidationResultTypeInvalidSSN,
    FORMValidationResultTypeInvalidNotMajor, //date birth mineur
    FORMValidationResultTypeInvalidNotMajorConjoint, //date birth mineur conjoint
    FORMValidationResultTypeInvalidTooLong,
    FORMValidationResultTypeInvalidTooShort,
    FORMValidationResultTypeInvalidValueMissing
};

@interface FORMValidator : NSObject

- (instancetype)initWithValidation:(FORMFieldValidation *)validation;

- (FORMValidationResultType)validateFieldValue:(id)fieldValue;

- (FORMValidationResultType)validateFieldValue:(id)fieldValue
                            withDependentValue:(id)dependentValue
                                withComparator:(NSString *)comparator;

+ (Class)classForKey:(NSString *)key andType:(NSString *)type;

+(BOOL) isCustomValidator:(FORMValidationResultType)validationType;

@end
