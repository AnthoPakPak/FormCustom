#import "FORMTextField.h"

#import "FORMTextFieldCell.h"

#import "FORMTextFieldTypeManager.h"

#import "UIColor+Hex.h"

static const CGFloat FORMTextFieldClearButtonWidth = 30.0f;
static const CGFloat FORMTextFieldClearButtonHeight = 20.0f;
static const CGFloat FORMTextFieldMinusButtonWidth = 30.0f;
static const CGFloat FORMTextFieldMinusButtonHeight = 20.0f;
static const CGFloat FORMTextFieldPlusButtonWidth = 30.0f;
static const CGFloat FORMTextFieldPlusButtonHeight = 20.0f;

static BOOL enabledProperty;

static NSString * const FORMTextFieldFontKey = @"font";
static NSString * const FORMTextFieldFontSizeKey = @"font_size";
static NSString * const FORMTextFieldBorderWidthKey = @"border_width";
static NSString * const FORMTextFieldBorderColorKey = @"border_color";
static NSString * const FORMTextFieldBackgroundColorKey = @"background_color";
static NSString * const FORMTextFieldCornerRadiusKey = @"corner_radius";
static NSString * const FORMTextFieldActiveBackgroundColorKey = @"active_background_color";
static NSString * const FORMTextFieldActiveBorderColorKey = @"active_border_color";
static NSString * const FORMTextFieldInactiveBackgroundColorKey = @"inactive_background_color";
static NSString * const FORMTextFieldInactiveBorderColorKey = @"inactive_border_color";
static NSString * const FORMTextFieldEnabledBackgroundColorKey = @"enabled_background_color";
static NSString * const FORMTextFieldEnabledBorderColorKey = @"enabled_border_color";
static NSString * const FORMTextFieldEnabledTextColorKey = @"enabled_text_color";
static NSString * const FORMTextFieldDisabledBackgroundColorKey = @"disabled_background_color";
static NSString * const FORMTextFieldDisabledBorderColorKey = @"disabled_border_color";
static NSString * const FORMTextFieldDisabledTextColorKey = @"disabled_text_color";
static NSString * const FORMTextFieldValidBackgroundColorKey = @"valid_background_color";
static NSString * const FORMTextFieldValidBorderColorKey = @"valid_border_color";
static NSString * const FORMTextFieldInvalidBackgroundColorKey = @"invalid_background_color";
static NSString * const FORMTextFieldInvalidBorderColorKey = @"invalid_border_color";
static NSString * const FORMTextFieldClearButtonColorKey = @"clear_button_color";
static NSString * const FORMTextFieldMinusButtonColorKey = @"minus_button_color";
static NSString * const FORMTextFieldPlusButtonColorKey = @"plus_button_color";

@interface FORMTextField () <UITextFieldDelegate> {
    //IBAN
    NSString *previousTextFieldContent;
    UITextRange *previousSelection;
}

@property (nonatomic, getter = isModified) BOOL modified;
@property (nonatomic) UIButton *clearButton;
@property (nonatomic) UIButton *minusButton;
@property (nonatomic) UIButton *plusButton;

// Style Properties
@property (nonatomic) UIColor *activeBackgroundColor;
@property (nonatomic) UIColor *activeBorderColor;
@property (nonatomic) UIColor *inactiveBackgroundColor;
@property (nonatomic) UIColor *inactiveBorderColor;

@property (nonatomic) UIColor *enabledBackgroundColor;
@property (nonatomic) UIColor *enabledBorderColor;
@property (nonatomic) UIColor *enabledTextColor;
@property (nonatomic) UIColor *disabledBackgroundColor;
@property (nonatomic) UIColor *disabledBorderColor;
@property (nonatomic) UIColor *disabledTextColor;

@property (nonatomic) UIColor *validBackgroundColor;
@property (nonatomic) UIColor *validBorderColor;
@property (nonatomic) UIColor *invalidBackgroundColor;
@property (nonatomic) UIColor *invalidBorderColor;

@end

@implementation FORMTextField

@synthesize rawText = _rawText;

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.delegate = self;

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, FORMFieldCellLeftMargin, 0.0f)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;

    [self addTarget:self action:@selector(textFieldDidUpdate:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];

    self.returnKeyType = UIReturnKeyDone;

    [self createClearButton];
    [self addClearButton];
    [self createCountButtons];

    return self;
}

#pragma mark - Setters

- (NSRange)currentRange {
    NSInteger startOffset = [self offsetFromPosition:self.beginningOfDocument
                                          toPosition:self.selectedTextRange.start];
    NSInteger endOffset = [self offsetFromPosition:self.beginningOfDocument
                                        toPosition:self.selectedTextRange.end];
    NSRange range = NSMakeRange(startOffset, endOffset-startOffset);

    return range;
}

- (void)setText:(NSString *)text {
    UITextRange *textRange = self.selectedTextRange;
    NSString *newRawText = [self.formatter formatString:text
                                                reverse:YES];
    NSRange range = [self currentRange];

    BOOL didAddText  = (newRawText.length > self.rawText.length);
    BOOL didFormat   = (text.length > super.text.length);
    BOOL cursorAtEnd = (newRawText.length == range.location);

    [super setText:text];
    if ((didAddText && didFormat) || (didAddText && cursorAtEnd)) {
        if (range.location < text.length) {
            UITextPosition *start = [self positionFromPosition:self.beginningOfDocument
                                                        offset:range.location + 1];
            UITextPosition *end = [self positionFromPosition:start
                                                      offset:range.length];
            UITextRange *newTextRange = [self textRangeFromPosition:start
                                                         toPosition:end];
            self.selectedTextRange = newTextRange;
        }
    } else {
        self.selectedTextRange = textRange;
    }
}

- (void)setRawText:(NSString *)rawText {
    BOOL shouldFormat = (self.formatter && (rawText.length >= _rawText.length ||
                                            ![rawText isEqualToString:_rawText]));

    if (shouldFormat) {
        self.text = [self.formatter formatString:rawText reverse:NO];
    } else {
        self.text = rawText;
    }

    _rawText = rawText;
}

- (void)setTypeString:(NSString *)typeString {
    _typeString = typeString;
    
    FORMTextFieldType type;
    if ([typeString isEqualToString:@"name"]) {
        type = FORMTextFieldTypeName;
    } else if ([typeString isEqualToString:@"username"]) {
        type = FORMTextFieldTypeUsername;
    } else if ([typeString isEqualToString:@"phone"]) {
        type = FORMTextFieldTypePhoneNumber;
    } else if ([typeString isEqualToString:@"number"]) {
        type = FORMTextFieldTypeNumber;
    } else if ([typeString isEqualToString:@"float"]) {
        type = FORMTextFieldTypeFloat;
    } else if ([typeString isEqualToString:@"address"]) {
        type = FORMTextFieldTypeAddress;
    } else if ([typeString isEqualToString:@"email"]) {
        type = FORMTextFieldTypeEmail;
    } else if ([typeString isEqualToString:@"date"]) {
        type = FORMTextFieldTypeDate;
    } else if ([typeString isEqualToString:@"select"]) {
        type = FORMTextFieldTypeSelect;
    } else if ([typeString isEqualToString:@"text"]) {
        type = FORMTextFieldTypeDefault;
    } else if ([typeString isEqualToString:@"password"]) {
        type = FORMTextFieldTypePassword;
    } else if ([typeString isEqualToString:@"count"]) {
        type = FORMTextFieldTypeCount;
        [self addCountButtons];
    } else if ([typeString isEqualToString:@"ibanFR"]) {
        type = FORMTextFieldTypeIBAN;
    } else if (!typeString.length) {
        type = FORMTextFieldTypeDefault;
    } else {
        type = FORMTextFieldTypeUnknown;
    }

    self.type = type;
}

- (void)setInputTypeString:(NSString *)inputTypeString {
    _inputTypeString = inputTypeString;

    FORMTextFieldInputType inputType;
    if ([inputTypeString isEqualToString:@"name"]) {
        inputType = FORMTextFieldInputTypeName;
    } else if ([inputTypeString isEqualToString:@"username"]) {
        inputType = FORMTextFieldInputTypeUsername;
    } else if ([inputTypeString isEqualToString:@"phone"]) {
        inputType = FORMTextFieldInputTypePhoneNumber;
    } else if ([inputTypeString isEqualToString:@"number"]) {
        inputType = FORMTextFieldInputTypeNumber;
    } else if ([inputTypeString isEqualToString:@"float"]) {
        inputType = FORMTextFieldInputTypeFloat;
    } else if ([inputTypeString isEqualToString:@"address"]) {
        inputType = FORMTextFieldInputTypeAddress;
    } else if ([inputTypeString isEqualToString:@"email"]) {
        inputType = FORMTextFieldInputTypeEmail;
    } else if ([inputTypeString isEqualToString:@"text"]) {
        inputType = FORMTextFieldInputTypeDefault;
    } else if ([inputTypeString isEqualToString:@"password"]) {
        inputType = FORMTextFieldInputTypePassword;
    } else if ([inputTypeString isEqualToString:@"count"]) {
        inputType = FORMTextFieldInputTypeCount;
    } else if ([inputTypeString isEqualToString:@"ibanFR"]) {
        inputType = FORMTextFieldInputTypeIBAN;
    } else if (!inputTypeString.length) {
        inputType = FORMTextFieldInputTypeDefault;
    } else {
        inputType = FORMTextFieldInputTypeUnknown;
    }

    self.inputType = inputType;
}

- (void)setInputType:(FORMTextFieldInputType)inputType {
    _inputType = inputType;

    FORMTextFieldTypeManager *typeManager = [FORMTextFieldTypeManager new];
    [typeManager setUpType:inputType forTextField:self];
}

#pragma mark - Getters

- (NSString *)rawText {
    if (self.formatter) {
        return [self.formatter formatString:_rawText reverse:YES];
    }

    return _rawText;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(FORMTextField *)textField {
    BOOL selectable = (textField.type == FORMTextFieldTypeSelect ||
                       textField.type == FORMTextFieldTypeDate);

    if (selectable &&
        [self.textFieldDelegate respondsToSelector:@selector(textFormFieldDidBeginEditing:)]) {
        [self.textFieldDelegate textFormFieldDidBeginEditing:self];
    }

    return !selectable;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.active = YES;
    self.modified = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.active = NO;
    if ([self.textFieldDelegate respondsToSelector:@selector(textFormFieldDidEndEditing:)]) {
        [self.textFieldDelegate textFormFieldDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || [string isEqualToString:@"\n"]) return YES;

    BOOL validator = (self.inputValidator &&
                      [self.inputValidator respondsToSelector:@selector(validateReplacementString:withText:withRange:)]);

    if (validator) return [self.inputValidator validateReplacementString:string
                                                                withText:self.rawText withRange:range];

    if (self.type == FORMTextFieldTypeIBAN) {
        // Note textField's current state before performing the change, in case
        // reformatTextField wants to revert it
        previousTextFieldContent = textField.text;
        previousSelection = textField.selectedTextRange;
    }
    
    return YES;
}

#pragma mark - UIResponder Overwritables

- (BOOL)becomeFirstResponder {
    if ([self.textFieldDelegate respondsToSelector:@selector(textFormFieldDidBeginEditing:)]) {
        [self.textFieldDelegate textFormFieldDidBeginEditing:self];
    }

    return [super becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    BOOL isTextField = (self.type != FORMTextFieldTypeSelect &&
                        self.type != FORMTextFieldTypeDate);

    return (isTextField && self.enabled) ?: [super canBecomeFirstResponder];
}

#pragma mark - Notifications

- (void)textFieldDidUpdate:(UITextField *)textField {
    if (!self.isValid) {
        self.valid = YES;
    }

    self.modified = YES;
    self.rawText = self.text;

    if ([self.textFieldDelegate respondsToSelector:@selector(textFormField:didUpdateWithText:)]) {
        [self.textFieldDelegate textFormField:self
                            didUpdateWithText:self.rawText];
    }
    
    if (self.type == FORMTextFieldTypeIBAN) {
        [self reformatAsIbanFR:textField];
    }
}

- (void)textFieldDidReturn:(UITextField *)textField {
    if ([self.textFieldDelegate respondsToSelector:@selector(textFormFieldDidReturn:)]) {
        [self.textFieldDelegate textFormFieldDidReturn:self];
    }
}

#pragma mark - Buttons

- (void)createCountButtons {
    NSString *bundlePath = [[[NSBundle bundleForClass:self.class] resourcePath] stringByAppendingPathComponent:@"Form.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath: bundlePath];

    UITraitCollection *trait = [UITraitCollection traitCollectionWithDisplayScale:2.0];

    // Minus Button
    UIImage *minusImage = [UIImage imageNamed:@"minus" inBundle:bundle compatibleWithTraitCollection:trait];
    UIImage *minusImageTemplate = [minusImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusButton setImage:minusImageTemplate forState:UIControlStateNormal];
    
    [self.minusButton addTarget:self action:@selector(minusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.minusButton.frame = CGRectMake(0.0f, 0.0f, FORMTextFieldMinusButtonWidth, FORMTextFieldMinusButtonHeight);

    // Plus Button
    UIImage *plusImage = [UIImage imageNamed:@"plus" inBundle:bundle compatibleWithTraitCollection:trait];
    UIImage *plusImageTemplate = [plusImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plusButton setImage:plusImageTemplate forState:UIControlStateNormal];
    
    [self.plusButton addTarget:self action:@selector(plusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.plusButton.frame = CGRectMake(0.0f, 0.0f, FORMTextFieldPlusButtonWidth, FORMTextFieldPlusButtonHeight);
}

- (void)addCountButtons {
    self.leftView = self.minusButton;
    self.leftViewMode = UITextFieldViewModeAlways;

    self.rightView = self.plusButton;
    self.rightViewMode = UITextFieldViewModeAlways;

    self.textAlignment = NSTextAlignmentCenter;
}

- (void)createClearButton {
    NSString *bundlePath = [[[NSBundle bundleForClass:self.class] resourcePath] stringByAppendingPathComponent:@"Form.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath: bundlePath];
    
    UITraitCollection *trait = [UITraitCollection traitCollectionWithDisplayScale:2.0];

    UIImage *clearImage = [UIImage imageNamed:@"clear" inBundle:bundle compatibleWithTraitCollection:trait];
    UIImage *clearImageTemplate = [clearImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton setImage:clearImageTemplate forState:UIControlStateNormal];
    
    [self.clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.clearButton.frame = CGRectMake(0.0f, 0.0f, FORMTextFieldClearButtonWidth, FORMTextFieldClearButtonHeight);
}

- (void)addClearButton {
    self.rightView = self.clearButton;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}

#pragma mark - Actions

- (void)clearButtonAction {
    self.rawText = nil;

    if ([self.textFieldDelegate respondsToSelector:@selector(textFormField:didUpdateWithText:)]) {
        [self.textFieldDelegate textFormField:self
                            didUpdateWithText:self.rawText];
    }
}

- (void)minusButtonAction {
    NSNumber *number = @([self.rawText integerValue] - 1);
    if ([number integerValue] < 0) {
        self.rawText = @"0";
    } else {
        self.rawText = [number stringValue];
    }

    if ([self.textFieldDelegate respondsToSelector:@selector(textFormField:didUpdateWithText:)]) {
	[self.textFieldDelegate textFormField:self
			    didUpdateWithText:self.rawText];
    }
}

- (void)plusButtonAction {
    NSNumber *number = @([self.rawText integerValue] + 1);
    self.rawText = [number stringValue];

    if ([self.textFieldDelegate respondsToSelector:@selector(textFormField:didUpdateWithText:)]) {
	[self.textFieldDelegate textFormField:self
			    didUpdateWithText:self.rawText];
    }
}

#pragma mark - Appearance

- (void)setActive:(BOOL)active {
    _active = active;

    if (active) {
        self.backgroundColor = self.activeBackgroundColor;
        self.layer.backgroundColor = self.activeBackgroundColor.CGColor;
        self.layer.borderColor = self.activeBorderColor.CGColor;
    } else {
        self.backgroundColor = self.inactiveBackgroundColor;
        self.layer.backgroundColor = self.inactiveBackgroundColor.CGColor;
        self.layer.borderColor = self.inactiveBorderColor.CGColor;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];

    enabledProperty = enabled;

    if (enabled) {
        self.backgroundColor = self.enabledBackgroundColor;
        self.layer.borderColor = self.enabledBorderColor.CGColor;
        self.textColor = self.enabledTextColor;
    } else {
        self.backgroundColor = self.disabledBackgroundColor;
        self.layer.borderColor = self.disabledBorderColor.CGColor;
        self.textColor = self.disabledTextColor;
    }
}

- (void)setValid:(BOOL)valid {
    _valid = valid;

    if (!valid) {
        self.backgroundColor = self.invalidBackgroundColor;
        self.layer.borderColor = self.invalidBorderColor.CGColor;
    } else {
        if (self.isEnabled) {
            self.backgroundColor = self.validBackgroundColor;
            self.layer.borderColor = self.validBorderColor.CGColor;
        } else {
            self.backgroundColor = self.disabledBackgroundColor;
            self.layer.borderColor = self.disabledBorderColor.CGColor;
        }
    }
}

- (void)setCustomFont:(UIFont *)font {
    NSString *styleFont = [self.styles valueForKey:FORMTextFieldFontKey];
    NSString *styleFontSize = [self.styles valueForKey:FORMTextFieldFontSizeKey];
    if ([styleFont length] > 0) {
        if ([styleFontSize length] > 0) {
            font = [UIFont fontWithName:styleFont size:[styleFontSize floatValue]];
        } else {
            font = [UIFont fontWithName:styleFont size:font.pointSize];
        }
    }
    self.font = font;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    NSString *style = [self.styles valueForKey:FORMTextFieldBorderWidthKey];
    if ([style length] > 0) {
        borderWidth = [style floatValue];
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    NSString *style = [self.styles valueForKey:FORMTextFieldBorderColorKey];
    if ([style length] > 0) {
        borderColor = [[UIColor alloc] initWithHex:style];
    }
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    NSString *style = [self.styles valueForKey:FORMTextFieldBackgroundColorKey];
    if ([style length] > 0) {
        backgroundColor = [[UIColor alloc] initWithHex:style];
    }
    self.layer.backgroundColor = backgroundColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    NSString *style = [self.styles valueForKey:FORMTextFieldCornerRadiusKey];
    if ([style length] > 0) {
        cornerRadius = [style floatValue];
    }
    self.layer.cornerRadius = cornerRadius;
}

- (void)setActiveBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldActiveBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _activeBackgroundColor = color;
}

- (void)setActiveBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldActiveBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _activeBorderColor = color;
}

- (void)setInactiveBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldInactiveBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _inactiveBackgroundColor = color;
}

- (void)setInactiveBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldInactiveBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _inactiveBorderColor = color;
}

- (void)setEnabledBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldEnabledBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _enabledBackgroundColor = color;
}

- (void)setEnabledBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldEnabledBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _enabledBorderColor = color;
}

- (void)setEnabledTextColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldEnabledTextColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _enabledTextColor = color;
}

- (void)setDisabledBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldDisabledBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _disabledBackgroundColor = color;
}

- (void)setDisabledBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldDisabledBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _disabledBorderColor = color;
}

- (void)setDisabledTextColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldDisabledTextColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _disabledTextColor = color;
    self.enabled = enabledProperty;
}

- (void)setValidBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldValidBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _validBackgroundColor = color;
}

- (void)setValidBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldValidBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _validBorderColor = color;
}

- (void)setInvalidBackgroundColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldInvalidBackgroundColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _invalidBackgroundColor = color;
}

- (void)setInvalidBorderColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldInvalidBorderColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    _invalidBorderColor = color;
    self.enabled = enabledProperty;
}

- (void)setClearButtonColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldClearButtonColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    self.clearButton.tintColor = color;
}

- (void)setMinusButtonColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldMinusButtonColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    self.minusButton.tintColor = color;
}

- (void)setPlusButtonColor:(UIColor *)color {
    NSString *style = [self.styles valueForKey:FORMTextFieldPlusButtonColorKey];
    if ([style length] > 0) {
        color = [[UIColor alloc] initWithHex:style];
    }
    self.plusButton.tintColor = color;
}




#pragma mark - IBAN formatting
// Source and explanation: http://stackoverflow.com/a/19161529/1709587 (source is for credit card number)

//Reformat as French IBAN format
-(void)reformatAsIbanFR:(UITextField *)textField {
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *ibanWithoutSpaces = [self removeNonAlphaNum:textField.text andPreserveCursorPosition:&targetCursorPosition];
    
    if ([ibanWithoutSpaces length] > 27) {
        // If the user is trying to enter more than 19 digits, we prevent
        // their change, leaving the text field in  its previous state.
        // While 16 digits is usual, credit card numbers have a hard
        // maximum of 19 digits defined by ISO standard 7812-1 in section
        // 3.8 and elsewhere. Applying this hard maximum here rather than
        // a maximum of 16 ensures that users with unusual card numbers
        // will still be able to enter their card number even if the
        // resultant formatting is odd.
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    NSString *cardNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:ibanWithoutSpaces andPreserveCursorPosition:&targetCursorPosition];
    
    textField.text = cardNumberWithSpaces;
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:targetCursorPosition];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
}



/*
 Removes non-digits from the string, decrementing `cursorPosition` as
 appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 and a cursor position of `8`, the cursor position will be changed to
 `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonAlphaNum:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i=0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
//        if (isdigit(characterToAdd)) {
        if (isalnum(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

/*
 Inserts spaces into the string to format it as a credit card number OR iban,
 incrementing `cursorPosition` as appropriate so that, for instance, if we
 pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 will be changed to `8` (keeping it between the '2' and the '3' after the
 spaces are added).
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i=0; i<[string length]; i++) {
        if ((i>0) && ((i % 4) == 0)) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}


@end
