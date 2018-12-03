//
//  CQPhotoBrowserImageView.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import "CQPhotoBrowserImageView.h"
#import "CQPhotoBrowserProgressView.h"

@interface CQPhotoBrowserImageView()

@property(nonatomic, strong)CQPhotoBrowserProgressView *progressView;

@end

@implementation CQPhotoBrowserImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
         [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
}

- (void)setupView {
    self.progressView = [[CQPhotoBrowserProgressView alloc] initWithFrame:CGRectMake(0, 0, 36*2, 36*2)];

    [self addSubview:self.progressView];
}

//- ini


@end
