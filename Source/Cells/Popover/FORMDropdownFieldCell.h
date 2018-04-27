//
//  FORMDropdownFieldCell.h
//
//  Created by Anthonin Cocagne on 23/04/2018.
//

#import "FORMPopoverFieldCell.h"
#import "FORMFieldValuesTableViewController.h"

static NSString * const FORMDropdownFormFieldCellIdentifier = @"FORMDropdownFormFieldCellIdentifier";

@interface FORMDropdownFieldCell : FORMPopoverFieldCell

@property (nonatomic) FORMFieldValuesTableViewController *fieldValuesController;

@end
