//
//  CQPhotoBottomToolBarView.h
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CQPhotoBottomToolBarViewSaveImageBlock)(void);

@interface CQPhotoBottomToolBarView : UIView

@property(nonatomic, copy)CQPhotoBottomToolBarViewSaveImageBlock saveImageBlock;

- (void)setDownloadButtonHidden;

@end

NS_ASSUME_NONNULL_END
