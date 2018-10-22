//
//  CQPhotoCell.m
//  CQPhotoBrowser_Example
//
//  Created by XcqRomance on 2018/10/20.
//  Copyright © 2018 XcqRomance. All rights reserved.
//

#import "CQPhotoCell.h"

@implementation CQPhotoCell

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
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES; 
    [self addSubview:self.imageView];
}

@end
