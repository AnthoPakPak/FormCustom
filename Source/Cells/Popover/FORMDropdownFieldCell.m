//
//  FORMDropdownFieldCell.m
//
//  Created by Anthonin Cocagne on 23/04/2018.
//

#import "FORMDropdownFieldCell.h"

#import "FORMFieldValue.h"
#import "UIViewController+HYPTopViewController.h"

static const CGSize FORMSelectPopoverSize = { .width = 320.0f, .height = 308.0f };
static const NSInteger FORMSelectMaxItemCount = 6;

@interface FORMDropdownFieldCell () <FORMTextFieldDelegate, FORMFieldValuesTableViewControllerDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate>

@end

@implementation FORMDropdownFieldCell {
    NSArray *valuesSave;
}


#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame contentViewController:self.fieldValuesController
                 andContentSize:FORMSelectPopoverSize dropdown:YES];
    if (!self) return nil;
    
    self.fieldValueTextField.delegate = self;
    [self.fieldValueTextField addTarget:self action:@selector(updateLabelUsingContentsOfTextField:) forControlEvents:UIControlEventEditingChanged];
    
    return self;
}

#pragma mark - Getters

- (FORMFieldValuesTableViewController *)fieldValuesController {
    if (_fieldValuesController) return _fieldValuesController;
    
    _fieldValuesController = [FORMFieldValuesTableViewController new];
    _fieldValuesController.delegate = self;
    
    return _fieldValuesController;
}

#pragma mark - FORMBaseFormFieldCell

- (void)updateWithField:(FORMField *)field {
    [super updateWithField:field];
    
    if (field.value) {
        if ([field.value isKindOfClass:[FORMFieldValue class]]) {
            FORMFieldValue *fieldValue = (FORMFieldValue *)field.value;
            self.fieldValueTextField.text = fieldValue.title;
        } else {
            self.fieldValueTextField.text = nil;
            
            for (FORMFieldValue *fieldValue in field.values) {
                if ([fieldValue identifierIsEqualTo:field.value]) {
                    field.value = fieldValue;
                    self.fieldValueTextField.text = fieldValue.title;
                    break;
                }
            }
        }
    } else {
        self.fieldValueTextField.text = nil;
    }
    
    if (!valuesSave)
        valuesSave = self.field.values;

    
    if ([field.accessibilityLabel length] > 0) {
        self.fieldValueTextField.accessibilityLabel = field.accessibilityLabel;
    } else {
        self.fieldValueTextField.accessibilityLabel = field.title;
    }
    self.fieldValueTextField.accessibilityValue = self.fieldValueLabel.text;
}

#pragma mark - FORMPopoverFormFieldCell

- (void)updateContentViewController:(UIViewController *)contentViewController
                          withField:(FORMField *)field {
    self.fieldValuesController.field = self.field;
    
    if (self.field.values.count <= FORMSelectMaxItemCount) {
        CGSize currentSize = FORMSelectPopoverSize;
        
        CGFloat labelHeight = floorf(self.fieldValuesController.headerView.labelHeight);
        CGSize customSize = CGSizeMake(currentSize.width, (FORMFieldValuesCellHeight * self.field.values.count) + labelHeight + FORMInfoLabelY);
        
        self.fieldValuesController.preferredContentSize = customSize;
    } else { //restore original size
        self.fieldValuesController.preferredContentSize = FORMSelectPopoverSize;
    }
}

#pragma mark - FORMFieldValuesTableViewControllerDelegate

- (void)fieldValuesTableViewController:(FORMFieldValuesTableViewController *)fieldValuesTableViewController
                      didSelectedValue:(FORMFieldValue *)selectedValue {
    self.field.value = selectedValue;
    
    [self updateWithField:self.field];
    
    //move uitextfield cursor to end
    UITextPosition *newCursorPosition = [self.fieldValueTextField positionFromPosition:self.fieldValueTextField.endOfDocument offset:0];
    UITextRange *newSelectedRange = [self.fieldValueTextField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
    [self.fieldValueTextField setSelectedTextRange:newSelectedRange];
    
    [self validate];
    
    [fieldValuesTableViewController dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(fieldCell:updatedWithField:)]) {
        [self.delegate fieldCell:self updatedWithField:self.field];
    }
    
    [self.fieldValueTextField resignFirstResponder];
}


- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    self.field.values = valuesSave;
}

#pragma mark - TextField delegate

- (void)updateLabelUsingContentsOfTextField:(FORMTextField*)sender {
    NSString *text = sender.text;
    
    NSMutableArray *filteredArray = @[].mutableCopy;
    for (FORMFieldValue *value in valuesSave) {
        if ([value.title.lowercaseString hasPrefix:text.lowercaseString] || [text isEqualToString:@""])
            [filteredArray addObject:value];
    }
    self.field.values = filteredArray;
    
    [self showOrUpdatePopoverFromSender:sender];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_fieldValuesController dismissViewControllerAnimated:YES completion:nil];
}


- (void)showOrUpdatePopoverFromSender:(FORMTextField *)textField {
    [self updateContentViewController:self.contentViewController withField:self.field];
    
    if (self.contentViewController.presentingViewController) //si le popup est déjà affiché
        return;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.contentViewController.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *presentationController = [self.contentViewController popoverPresentationController];
        presentationController.sourceView = self;
        presentationController.sourceRect = self.bounds;
        presentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        presentationController.delegate = self;
        UIViewController *topViewController = [UIViewController hyp_topViewController];
        [topViewController presentViewController:self.contentViewController animated:YES completion:nil];
        
        return;
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.contentViewController];
    
    navigationController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *presentationController = [navigationController popoverPresentationController];
    presentationController.sourceView = self;
    presentationController.sourceRect = self.bounds;
    
    UIViewController *topViewController = [UIViewController hyp_topViewController];
    [topViewController presentViewController:navigationController animated:YES completion:nil];
}

@end
