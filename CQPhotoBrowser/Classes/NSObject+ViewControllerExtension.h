//
//  NSObject+ViewControllerExtension.h
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ViewControllerExtension)

+ (UIViewController *)topViewController;


+ (UIImage *)captureWithView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END
