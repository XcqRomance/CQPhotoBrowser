//
//  CQPhotoTopToolBarView.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import "CQPhotoTopToolBarView.h"

@interface CQPhotoTopToolBarView()

@property(nonatomic, strong)UILabel *titleLabel;

@end


@implementation CQPhotoTopToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.center = self.center;
    [self addSubview:self.titleLabel];
}

- (void)setTitleWithCurrentIndex:(NSUInteger)index totalIndex:(NSUInteger)total {
    self.titleLabel.text = [NSString stringWithFormat:@"%lu/%lu",index,(unsigned long)total];
}

- (void)setTitleHidden {
    self.titleLabel.hidden = YES; 
}

@end
