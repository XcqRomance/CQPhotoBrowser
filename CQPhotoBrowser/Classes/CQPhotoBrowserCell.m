//
//  CQPhotoBrowserCell.m
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import "CQPhotoBrowserCell.h"

@implementation CQPhotoBrowserCell

- (instancetype)init {
    if (self = [super init]) {
        [self setupImageViw];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageViw];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupImageViw];
    }
    return self;
}

- (void)setupImageViw {
    UIImage *placeholder = [UIImage imageNamed:@"bookDefault"];
    self.imageView = [[CQPhotoBrowserImageView alloc] initWithImage:placeholder];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = self.bounds;
    self.imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageView];
    
    UILongPressGestureRecognizer *longPressGesture= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    [self.imageView addGestureRecognizer:longPressGesture]; 
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gestureRecognizer {
    
}


@end
