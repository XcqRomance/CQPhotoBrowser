//
//  CQPhotoBrowser.h
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
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
