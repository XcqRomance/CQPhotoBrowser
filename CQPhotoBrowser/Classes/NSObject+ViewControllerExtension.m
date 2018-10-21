//
//  NSObject+ViewControllerExtension.m
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import "NSObject+ViewControllerExtension.h"

@implementation NSObject (ViewControllerExtension)

+ (UIViewController *)topViewController {
    return [self traverseResponderChainForFirstViewController];
}

- (id)traverseResponderChainForFirstViewController {
    id nextResponder = nil;//[self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForFirstViewController];
    } else {
        return nil;
    }
}

@end
