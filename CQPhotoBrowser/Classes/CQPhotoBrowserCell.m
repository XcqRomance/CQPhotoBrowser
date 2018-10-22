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
    self.imageView = [[UIImageView alloc] initWithImage:placeholder];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.frame = self.bounds; 
    [self addSubview:self.imageView];
}


@end
