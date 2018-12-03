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
    self.backgroundColor = [UIColor redColor];
    [self setupExternalRing];
    [self setupInternalCircle];
}

// 设置外部圆环⭕️
- (void)setupExternalRing {
    CGFloat radius = CGRectGetWidth(self.bounds)/2;
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
    // 圆环颜色
    self.externalRing.strokeColor = [UIColor whiteColor].CGColor;
    // 圆环宽度
    self.externalRing.lineWidth = lineWidth;
    CGFloat width = CGRectGetWidth(self.bounds);
    self.externalRing.frame = CGRectMake((width - radius*2)/2, (width - radius*2)/2, width, CGRectGetHeight(self.bounds));
    [self.layer addSublayer:self.externalRing];
}

// 设置内部圆形
- (void)setupInternalCircle {
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - 4;
    CGFloat lineWidth = radius;
    
    self.internalCircle = [CAShapeLayer layer];
    // 绘制圆弧的方法 ArcCenter：圆心的位置，radius半径，clockwise：是否顺时针方向
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                        radius:radius-lineWidth/2
                                                    startAngle:-M_PI/2
                                                      endAngle:M_PI/180*270
                                                     clockwise:YES];
    self.internalCircle.path = path.CGPath;
    // 圆环内部填充颜色
    self.internalCircle.fillColor = [UIColor clearColor].CGColor;
    // 圆环颜色
    self.internalCircle.strokeColor = [UIColor whiteColor].CGColor;
    // 圆环宽度
    self.internalCircle.lineWidth = lineWidth;
    CGFloat width = CGRectGetWidth(self.bounds);
    self.internalCircle.frame = CGRectMake((width - radius*2)/2, (width - radius*2)/2, width, CGRectGetHeight(self.bounds));
    [self.layer addSublayer:self.internalCircle];
    
    self.internalCircle.strokeStart = 0;
    self.internalCircle.strokeEnd = 0.5;
}

@end
