//
//  CQPhotoTopToolBarView.h
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoTopToolBarView : UIView

- (void)setTitleWithCurrentIndex:(NSUInteger)index totalIndex:(NSUInteger)total;
- (void)setTitleHidden;

@end

NS_ASSUME_NONNULL_END
