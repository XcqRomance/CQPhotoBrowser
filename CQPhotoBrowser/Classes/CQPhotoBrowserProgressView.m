//
//  CQPhotoBrowserProgressView.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import "CQPhotoBrowserProgressView.h"

@implementation CQPhotoBrowserProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self setupExternalRing];
    [self setupInternalCircle];
}

// 设置外部圆环⭕️
- (void)setupExternalRing {
    CGFloat radius = 34;
    CGFloat lineWidth = 2;
    self.externalRing = [CAShapeLayer layer];
    // 绘制圆弧的方法 ArcCenter：圆心的位置，radius半径，clockwise：是否顺时针方向
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                        radius:radius//-lineWidth/2
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    self.externalRing.path = path.CGPath;
    // 圆环内部填充颜色
    self.externalRing.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
//    self.externalRing.backgroundColor = [UIColor clearColor].CGColor;
    // 圆环颜色
    self.externalRing.strokeColor = [UIColor whiteColor].CGColor;
    // 圆环宽度
    self.externalRing.lineWidth = lineWidth;
    self.layer.frame = self.bounds;
    [self.layer addSublayer:self.externalRing];
}

// 设置内部圆形
- (void)setupInternalCircle {
    
}

@end
