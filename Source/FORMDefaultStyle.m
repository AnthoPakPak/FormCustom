#import "FORMDefaultStyle.h"

#import "FORMTextField.h"
#import "FORMBackgroundView.h"
#import "FORMSeparatorView.h"
#import "FORMFieldValueLabel.h"
#import "FORMFieldValueCell.h"
#import "FORMGroupHeaderView.h"
#import "FORMFieldValuesTableViewHeader.h"
#import "FORMTextFieldCell.h"
#import "FORMButtonFieldCell.h"
#import "FORMSegmentFieldCell.h"
#import "FORMSwitchFieldCell.h"
#import "FORMBaseFieldCell.h"
#import "UIColor+Hex.h"

@implementation FORMDefaultStyle

//+ (void)applyStyle {
//    [[FORMTextField appearance] setTextColor:[UIColor redColor]];
//    [[FORMTextField appearance] setBackgroundColor:[UIColor yellowColor]];
//
//    [[FORMBaseFieldCell appearance] setHeadingLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:14.0]];
//    [[FORMBaseFieldCell appearance] setHeadingLabelTextColor:[[UIColor alloc] initWithHex:@"28649C"]];
//
////    [[FORMBackgroundView appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"DAE2EA"]];
//    [[FORMBackgroundView appearance] setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.85]];
////    [[FORMBackgroundView appearance] setGroupBackgroundColor:[[UIColor alloc] initWithHex:@"DAE2EA"]];
//    [[FORMBackgroundView appearance] setGroupBackgroundColor:[UIColor clearColor]];
//
//    [[FORMSeparatorView appearance] setSeparatorColor:[[UIColor alloc] initWithHex:@"C6C6C6"]];
//
//    [[FORMButtonFieldCell appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMButtonFieldCell appearance] setTitleLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
//    [[FORMButtonFieldCell appearance] setBorderWidth:1.0f];
//    [[FORMButtonFieldCell appearance] setCornerRadius:5.0f];
//    [[FORMButtonFieldCell appearance] setHighlightedTitleColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMButtonFieldCell appearance] setBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMButtonFieldCell appearance] setHighlightedBackgroundColor:[UIColor whiteColor]];
//    [[FORMButtonFieldCell appearance] setTitleColor:[UIColor whiteColor]];
//
//    [[FORMFieldValueCell appearance] setTextLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0]];
//    [[FORMFieldValueCell appearance] setTextLabelColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMFieldValueCell appearance] setDetailTextLabelHighlightedTextColor:[UIColor whiteColor]];
//    [[FORMFieldValueCell appearance] setDetailTextLabelFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0]];
//    [[FORMFieldValueCell appearance] setDetailTextLabelColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMFieldValueCell appearance] setDetailTextLabelHighlightedTextColor:[UIColor whiteColor]];
//    [[FORMFieldValueCell appearance] setSelectedBackgroundViewColor:[[UIColor alloc] initWithHex:@"008ED9"]];
//    [[FORMFieldValueCell appearance] setSelectedBackgroundFontColor:[UIColor whiteColor]];
//
//    [[FORMTextField appearance] setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:15.0]];
//    [[FORMTextField appearance] setTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMTextField appearance] setBorderWidth:1.0f];
//    [[FORMTextField appearance] setBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setCornerRadius:5.0f];
//    [[FORMTextField appearance] setActiveBackgroundColor:[[UIColor alloc] initWithHex:@"C0EAFF"]];
//    [[FORMTextField appearance] setActiveBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setInactiveBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMTextField appearance] setInactiveBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setEnabledBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMTextField appearance] setEnabledBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setEnabledTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMTextField appearance] setDisabledBackgroundColor:[[UIColor alloc] initWithHex:@"F5F5F8"]];
//    [[FORMTextField appearance] setDisabledBorderColor:[[UIColor alloc] initWithHex:@"DEDEDE"]];
//    [[FORMTextField appearance] setDisabledTextColor:[UIColor grayColor]];
//    [[FORMTextField appearance] setValidBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMTextField appearance] setValidBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setInvalidBackgroundColor:[[UIColor alloc] initWithHex:@"FFD7D7"]];
//    [[FORMTextField appearance] setInvalidBorderColor:[[UIColor alloc] initWithHex:@"EC3031"]];
//    [[FORMTextField appearance] setClearButtonColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setMinusButtonColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMTextField appearance] setPlusButtonColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//
//    [[FORMFieldValueLabel appearance] setCustomFont:[UIFont fontWithName:@"AvenirNext-Regular" size:15.0]];
//    [[FORMFieldValueLabel appearance] setTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMFieldValueLabel appearance] setBorderWidth:1.0f];
//    [[FORMFieldValueLabel appearance] setBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMFieldValueLabel appearance] setCornerRadius:5.0f];
//    [[FORMFieldValueLabel appearance] setActiveBackgroundColor:[[UIColor alloc] initWithHex:@"C0EAFF"]];
//    [[FORMFieldValueLabel appearance] setActiveBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMFieldValueLabel appearance] setInactiveBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMFieldValueLabel appearance] setInactiveBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMFieldValueLabel appearance] setEnabledBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMFieldValueLabel appearance] setEnabledBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMFieldValueLabel appearance] setEnabledTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMFieldValueLabel appearance] setDisabledBackgroundColor:[[UIColor alloc] initWithHex:@"F5F5F8"]];
//    [[FORMFieldValueLabel appearance] setDisabledBorderColor:[[UIColor alloc] initWithHex:@"DEDEDE"]];
//    [[FORMFieldValueLabel appearance] setDisabledTextColor:[UIColor grayColor]];
//    [[FORMFieldValueLabel appearance] setValidBackgroundColor:[[UIColor alloc] initWithHex:@"E1F5FF"]];
//    [[FORMFieldValueLabel appearance] setValidBorderColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//    [[FORMFieldValueLabel appearance] setInvalidBackgroundColor:[[UIColor alloc] initWithHex:@"FFD7D7"]];
//    [[FORMFieldValueLabel appearance] setInvalidBorderColor:[[UIColor alloc] initWithHex:@"EC3031"]];
//
//    [[FORMGroupHeaderView appearance] setHeaderLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0]];
//    [[FORMGroupHeaderView appearance] setHeaderLabelTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    //    [[FORMGroupHeaderView appearance] setHeaderBackgroundColor:[UIColor whiteColor]];
//    [[FORMGroupHeaderView appearance] setHeaderBackgroundColor:[UIColor clearColor]];
//
//    [[FORMFieldValuesTableViewHeader appearance] setTitleLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0]];
//    [[FORMFieldValuesTableViewHeader appearance] setTitleLabelTextColor:[[UIColor alloc] initWithHex:@"455C73"]];
//    [[FORMFieldValuesTableViewHeader appearance] setInfoLabelFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:17.0]];
//    [[FORMFieldValuesTableViewHeader appearance] setInfoLabelTextColor:[[UIColor alloc] initWithHex:@"28649C"]];
//
//    [[FORMTextFieldCell appearance] setTooltipLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:14.0]];
//    [[FORMTextFieldCell appearance] setTooltipLabelTextColor:[[UIColor alloc] initWithHex:@"97591D"]];
//    [[FORMTextFieldCell appearance] setTooltipBackgroundColor:[[UIColor alloc] initWithHex:@"FDFD54"]];
//
//    [[FORMSegmentFieldCell appearance] setLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
//    [[FORMSegmentFieldCell appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"FFFFFF"]];
//    [[FORMSegmentFieldCell appearance] setTintColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//
////    [[FORMSwitchFieldCell appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"FFFFFF"]];
//    [[FORMSwitchFieldCell appearance] setBackgroundColor:[UIColor clearColor]];
//    [[FORMSwitchFieldCell appearance] setTintColor:[[UIColor alloc] initWithHex:@"3DAFEB"]];
//
//}


+ (void)applyStyle {
    UIColor *inactiveBackgroundColor = [[UIColor alloc] initWithHex:@"FFF5FF"];
    UIColor *activeBackgroundColor = [[UIColor alloc] initWithHex:@"FFDCF1"];
    UIColor *borderColor = [[UIColor alloc] initWithHex:@"ef71b4"];
    UIColor *textColor = [[UIColor alloc] initWithHex:@"000000"];

    [[FORMTextField appearance] setTextColor:[UIColor redColor]];
    [[FORMTextField appearance] setBackgroundColor:[UIColor yellowColor]];
    
    [[FORMBaseFieldCell appearance] setHeadingLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:14.0]];
    [[FORMBaseFieldCell appearance] setHeadingLabelTextColor:textColor];
    
    //    [[FORMBackgroundView appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"DAE2EA"]];
    [[FORMBackgroundView appearance] setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.85]];
    //    [[FORMBackgroundView appearance] setGroupBackgroundColor:[[UIColor alloc] initWithHex:@"DAE2EA"]];
    [[FORMBackgroundView appearance] setGroupBackgroundColor:[UIColor clearColor]];
    
    [[FORMSeparatorView appearance] setSeparatorColor:[[UIColor alloc] initWithHex:@"C6C6C6"]];
    
    [[FORMButtonFieldCell appearance] setBackgroundColor:borderColor];
    [[FORMButtonFieldCell appearance] setTitleLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
    [[FORMButtonFieldCell appearance] setBorderWidth:1.0f];
    [[FORMButtonFieldCell appearance] setCornerRadius:5.0f];
    [[FORMButtonFieldCell appearance] setHighlightedTitleColor:borderColor];
    [[FORMButtonFieldCell appearance] setBorderColor:borderColor];
    [[FORMButtonFieldCell appearance] setHighlightedBackgroundColor:[UIColor whiteColor]];
    [[FORMButtonFieldCell appearance] setTitleColor:[UIColor whiteColor]];
    
    [[FORMFieldValueCell appearance] setTextLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0]];
    [[FORMFieldValueCell appearance] setTextLabelColor:textColor];
    [[FORMFieldValueCell appearance] setDetailTextLabelHighlightedTextColor:[UIColor whiteColor]];
    [[FORMFieldValueCell appearance] setDetailTextLabelFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0]];
    [[FORMFieldValueCell appearance] setDetailTextLabelColor:textColor];
    [[FORMFieldValueCell appearance] setDetailTextLabelHighlightedTextColor:[UIColor whiteColor]];
    [[FORMFieldValueCell appearance] setSelectedBackgroundViewColor:[[UIColor alloc] initWithHex:@"008ED9"]];
    [[FORMFieldValueCell appearance] setSelectedBackgroundFontColor:[UIColor whiteColor]];
    
    [[FORMTextField appearance] setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:15.0]];
    [[FORMTextField appearance] setTextColor:textColor];
    [[FORMTextField appearance] setBorderWidth:1.0f];
    //    [[FORMTextField appearance] setBorderColor:borderColor];
    [[FORMTextField appearance] setBorderColor:borderColor];
    [[FORMTextField appearance] setCornerRadius:5.0f];
    [[FORMTextField appearance] setActiveBackgroundColor:activeBackgroundColor];
    [[FORMTextField appearance] setActiveBorderColor:borderColor];
    [[FORMTextField appearance] setInactiveBackgroundColor:inactiveBackgroundColor];
    [[FORMTextField appearance] setInactiveBorderColor:borderColor];
    [[FORMTextField appearance] setEnabledBackgroundColor:inactiveBackgroundColor];
    [[FORMTextField appearance] setEnabledBorderColor:borderColor];
    [[FORMTextField appearance] setEnabledTextColor:textColor];
    [[FORMTextField appearance] setDisabledBackgroundColor:[[UIColor alloc] initWithHex:@"F5F5F8"]];
    [[FORMTextField appearance] setDisabledBorderColor:[[UIColor alloc] initWithHex:@"DEDEDE"]];
    [[FORMTextField appearance] setDisabledTextColor:[UIColor grayColor]];
    [[FORMTextField appearance] setValidBackgroundColor:inactiveBackgroundColor];
    [[FORMTextField appearance] setValidBorderColor:borderColor];
    [[FORMTextField appearance] setInvalidBackgroundColor:[[UIColor alloc] initWithHex:@"FFD7D7"]];
    [[FORMTextField appearance] setInvalidBorderColor:[[UIColor alloc] initWithHex:@"EC3031"]];
    [[FORMTextField appearance] setClearButtonColor:borderColor];
    [[FORMTextField appearance] setMinusButtonColor:borderColor];
    [[FORMTextField appearance] setPlusButtonColor:borderColor];
    
    [[FORMFieldValueLabel appearance] setCustomFont:[UIFont fontWithName:@"AvenirNext-Regular" size:15.0]];
    [[FORMFieldValueLabel appearance] setTextColor:textColor];
    [[FORMFieldValueLabel appearance] setBorderWidth:1.0f];
    [[FORMFieldValueLabel appearance] setBorderColor:borderColor];
    [[FORMFieldValueLabel appearance] setCornerRadius:5.0f];
    [[FORMFieldValueLabel appearance] setActiveBackgroundColor:activeBackgroundColor];
    [[FORMFieldValueLabel appearance] setActiveBorderColor:borderColor];
    [[FORMFieldValueLabel appearance] setInactiveBackgroundColor:inactiveBackgroundColor];
    [[FORMFieldValueLabel appearance] setInactiveBorderColor:borderColor];
    [[FORMFieldValueLabel appearance] setEnabledBackgroundColor:inactiveBackgroundColor];
    [[FORMFieldValueLabel appearance] setEnabledBorderColor:borderColor];
    [[FORMFieldValueLabel appearance] setEnabledTextColor:textColor];
    [[FORMFieldValueLabel appearance] setDisabledBackgroundColor:[[UIColor alloc] initWithHex:@"F5F5F8"]];
    [[FORMFieldValueLabel appearance] setDisabledBorderColor:[[UIColor alloc] initWithHex:@"DEDEDE"]];
    [[FORMFieldValueLabel appearance] setDisabledTextColor:[UIColor grayColor]];
    [[FORMFieldValueLabel appearance] setValidBackgroundColor:inactiveBackgroundColor];
    [[FORMFieldValueLabel appearance] setValidBorderColor:borderColor];
    [[FORMFieldValueLabel appearance] setInvalidBackgroundColor:[[UIColor alloc] initWithHex:@"FFD7D7"]];
    [[FORMFieldValueLabel appearance] setInvalidBorderColor:[[UIColor alloc] initWithHex:@"EC3031"]];
    
    [[FORMGroupHeaderView appearance] setHeaderLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:25.0]];
    [[FORMGroupHeaderView appearance] setHeaderLabelTextColor:textColor];
    //    [[FORMGroupHeaderView appearance] setHeaderBackgroundColor:[UIColor whiteColor]];
    [[FORMGroupHeaderView appearance] setHeaderBackgroundColor:[UIColor clearColor]];
    
    [[FORMFieldValuesTableViewHeader appearance] setTitleLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0]];
    [[FORMFieldValuesTableViewHeader appearance] setTitleLabelTextColor:textColor];
    [[FORMFieldValuesTableViewHeader appearance] setInfoLabelFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:17.0]];
    [[FORMFieldValuesTableViewHeader appearance] setInfoLabelTextColor:[[UIColor alloc] initWithHex:@"28649C"]];
    
    [[FORMTextFieldCell appearance] setTooltipLabelFont:[UIFont fontWithName:@"AvenirNext-Medium" size:14.0]];
    [[FORMTextFieldCell appearance] setTooltipLabelTextColor:borderColor];
    [[FORMTextFieldCell appearance] setTooltipBackgroundColor:inactiveBackgroundColor];
    
    [[FORMSegmentFieldCell appearance] setLabelFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
    [[FORMSegmentFieldCell appearance] setBackgroundColor:inactiveBackgroundColor];
    [[FORMSegmentFieldCell appearance] setTintColor:borderColor];
    
    //    [[FORMSwitchFieldCell appearance] setBackgroundColor:[[UIColor alloc] initWithHex:@"FFFFFF"]];
    [[FORMSwitchFieldCell appearance] setBackgroundColor:[UIColor clearColor]];
    [[FORMSwitchFieldCell appearance] setTintColor:borderColor];
    
}

@end
