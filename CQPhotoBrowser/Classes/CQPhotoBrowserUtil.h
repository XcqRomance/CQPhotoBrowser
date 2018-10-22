//
//  CQPhotoBrowserUtil.h
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoBrowserUtil : NSObject


/**
 进入图片浏览详情页

 @param photos 图片数据源,一般是图片urlstring的数组，
 @param index 当前点第几张图片
 @param thumbImages 列表页缩略图image
 @param thumbImagesFrame 列表页缩略图的frame
 */
+ (void)showPhotoWithPhotos:(NSArray *)photos index:(NSUInteger)index thumbImages:(NSArray <UIImage *> *)thumbImages thumbImagesFrame:(NSArray <NSValue *>*)thumbImagesFrame;

@end

NS_ASSUME_NONNULL_END
