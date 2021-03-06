//
//  CQPhotoBrowserUtil.m
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import "CQPhotoBrowserUtil.h"
#import "CQPhotoBrowser.h"
#import "NSObject+ViewControllerExtension.h"



@implementation CQPhotoBrowserUtil


+ (void)showPhotoWithPhotos:(NSArray *)photos
                      index:(NSUInteger)index
                thumbImages:(NSArray <UIImage *> *)thumbImages
           thumbImagesFrame:(NSArray <NSValue *>*)thumbImagesFrame {
    UIViewController *topVC = [NSObject topViewController];
    CQPhotoBrowser *photoBrowser = [[CQPhotoBrowser alloc] init];
    photoBrowser.dataSourceArray = [photos mutableCopy];
    photoBrowser.currentIndex = index;
    photoBrowser.backgroundImage = [NSObject captureWithView:topVC.navigationController.view];
    photoBrowser.thumbImages = thumbImages;
    photoBrowser.thumbImagesFrames = thumbImagesFrame;
    [topVC presentViewController:photoBrowser animated:NO completion:nil];
}


+ (void)showPhotoWithPhotos:(NSArray *)photos
                      index:(NSUInteger)index
                thumbImages:(NSArray<UIImage *> *)thumbImages
           thumbImagesFrame:(NSArray<NSValue *> *)thumbImagesFrame
       photoBrowserDelegate:(id <CQPhotoBrowserDelegate>)delegate
         customToolBarBlock:(CQPhotoBrowserCustomToolBarBlock)customToolBarBlock {
    UIViewController *topVC = [NSObject topViewController];
    CQPhotoBrowser *photoBrowser = [[CQPhotoBrowser alloc] init];
    photoBrowser.dataSourceArray = [photos mutableCopy];
    photoBrowser.currentIndex = index;
    photoBrowser.backgroundImage = [NSObject captureWithView:topVC.navigationController.view];
    photoBrowser.thumbImages = thumbImages;
    photoBrowser.thumbImagesFrames = thumbImagesFrame;
    photoBrowser.delegate = delegate;
    [topVC presentViewController:photoBrowser animated:NO completion:nil];

}

@end
