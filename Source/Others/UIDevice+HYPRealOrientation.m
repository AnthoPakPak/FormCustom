#import "UIDevice+HYPRealOrientation.h"

@implementation UIDevice (HYPRealOrientation)

- (BOOL)hyp_isPortrait {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
        BOOL portrait = (statusBarOrientation == UIInterfaceOrientationPortrait ||
                         statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown);
        orientation = (portrait) ? UIDeviceOrientationPortrait : UIDeviceOrientationLandscapeLeft;
    }

    return UIDeviceOrientationIsPortrait(orientation);
}

- (BOOL)hyp_isLandscape {
    return ![self hyp_isPortrait];
}

@end
