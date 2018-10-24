//
//  CQPhotoBrowser.h
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import <UIKit/UIKit.h>

@protocol CQPhotoBrowserDelegate <NSObject>

- (void)photoBrowserDidResponseLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer;
- (void)photoBrowserDidChangeCurrentPhotoIndex:(NSUInteger)photoIndex;
- (UIView *)photoBrowserTopToolBarView;
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
