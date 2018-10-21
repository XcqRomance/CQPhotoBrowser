//
//  CQPhotoBrowserUtil.m
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import "CQPhotoBrowserUtil.h"
#import "CQPhotoBrowser.h"

@implementation CQPhotoBrowserUtil


+ (void)showPhotoWithPhotos:(NSArray *)photos index:(NSUInteger)index thumbImages:(NSArray <UIImage *> *)thumbImages thumbImagesFrame:(NSArray <NSValue *>*)thumbImagesFrame {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    CQPhotoBrowser *photoBrowser = [[CQPhotoBrowser alloc] init];
    photoBrowser.dataSourceArray = [photos mutableCopy];
    photoBrowser.currentIndex = index;
    photoBrowser.backgroundImage = [self captureWithView:topVC.navigationController.view];
    photoBrowser.thumbImages = thumbImages;
    photoBrowser.thumbImagesFrame = thumbImagesFrame;
    [topVC presentViewController:photoBrowser animated:YES completion:nil];
}

+ (UIImage *)captureWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.frame afterScreenUpdates:YES];
    } else {
        // ios7下如果用此方法navigationBar会变黑
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
