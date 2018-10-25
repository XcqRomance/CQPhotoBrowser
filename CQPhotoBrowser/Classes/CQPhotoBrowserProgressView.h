//
//  CQPhotoBrowserProgressView.h
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPhotoBrowserProgressView : UIView


/**
 外部的圆环
 */
@property(nonatomic, strong)CAShapeLayer *externalRing;


/**
 内部的圆形进度
 */
@property(nonatomic, strong)CAShapeLayer *internalCircle;

@end

NS_ASSUME_NONNULL_END
