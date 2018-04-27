#import "FORMBaseFieldCell.h"
#import "FORMFieldValueLabel.h"
#import "FORMFieldValuesTableViewController.h"

@interface FORMPopoverFieldCell : FORMBaseFieldCell

@property (nonatomic) FORMFieldValueLabel *fieldValueLabel; //pour les autres
@property (nonatomic) FORMTextField *fieldValueTextField; //pour le dropdown
@property (nonatomic) UIImageView *iconImageView;

@property (nonatomic) UIViewController *contentViewController;
@property (nonatomic) CGSize contentSize;

- (instancetype)initWithFrame:(CGRect)frame contentViewController:(UIViewController *)contentViewController
               andContentSize:(CGSize)contentSize dropdown:(BOOL)isDropdown;

- (void)updateContentViewController:(UIViewController *)contentViewController withField:(FORMField *)field;

@end
