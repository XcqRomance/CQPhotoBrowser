//
//  CQPhotoBrowser.h
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import <UIKit/UIKit.h>

@protocol CQPhotoBrowserDelegate <NSObject>

@optional

/**
 图片长按手势回调，
 当且仅当你需要自定义 长安手势显示视图 才需要实现此代理，否则没有任何相应

 @param gestureRecognizer gestureRecognizer
 */
- (void)photoBrowserDidResponseLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer;

/**
 默认的bottomview图片浏览时调用此方法，

 @param photoIndex 当前图片的index
 */
- (void)photoBrowserDidChangeCurrentPhotoIndex:(NSUInteger)photoIndex;

/**
 默认的bottomview的情况下，保存图片的回调，success：error == nil，failure：error信息
 当且仅当你需要自定义 保存图片成功或者失败时的 弹窗提示 才需要实现此代理 ，不实现此方法则使用默认的弹窗提示

 @param error 成功时：error为nil，失败时error不为空
 */
- (void)photoBrowserDidFinishSavingImageWithError:(NSError *)error;

/**
 如果需要自定义图片浏览器的topview部分，则需要实现此代理，否则使用就默认的topview
 topview的frame是(0, cq_liuhaiHeight, cq_kScreentWidth, 44)
 */
- (UIView *)photoBrowserTopToolBarView;

/**
 如果需要自定义图片浏览器的bottomview部分，则需要实现此代理，否则使用就默认的bottomview
 bottomview的frame是(0, cq_kScreentHeight - cq_kHomeIndicatorHeight - 44, cq_kScreentWidth, 44)
 */
- (UIView *)photoBrowserBottomToolBarView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoBrowser : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSArray *thumbImages;
@property (nonatomic, strong) NSArray *thumbImagesFrames;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSUInteger currentIndex; // 从0开始
@property (nonatomic, weak) id<CQPhotoBrowserDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
