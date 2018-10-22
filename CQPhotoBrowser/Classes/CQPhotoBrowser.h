//
//  CQPhotoBrowser.h
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoBrowser : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSArray *thumbImages;
@property (nonatomic, strong) NSArray *thumbImagesFrame;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSUInteger currentIndex;


@end

NS_ASSUME_NONNULL_END
