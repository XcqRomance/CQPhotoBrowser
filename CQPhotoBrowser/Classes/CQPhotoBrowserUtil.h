//
//  CQPhotoBrowserUtil.h
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoBrowserUtil : NSObject

+ (void)showPhotoWithPhotos:(NSArray *)photos index:(NSUInteger)index thumbImages:(NSArray <UIImage *> *)thumbImages thumbImagesFrame:(NSArray <NSValue *>*)thumbImagesFrame;

@end

NS_ASSUME_NONNULL_END
