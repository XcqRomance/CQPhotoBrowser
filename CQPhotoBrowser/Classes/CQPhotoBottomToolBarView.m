//
//  CQPhotoBottomToolBarView.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import "CQPhotoBottomToolBarView.h"
#import "CQPhotoBrowserMacroDefinition.h"
#import "UIImage+PhotoBrowserExtensioin.h"
#import "CQPhotoBrowserMacroDefinition.h"

@interface CQPhotoBottomToolBarView()

@property(nonatomic, strong)UIButton *downloadButton;
@property(nonatomic, strong)UIButton *shareButton;

@end


@implementation CQPhotoBottomToolBarView

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - private method
- (void)buildUI {
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.shareButton];
    [self addSubview:self.downloadButton];

}

#pragma mark - public method

- (void)setDownloadButtonHidden {
    self.downloadButton.hidden = YES;
}

#pragma mark - event response

- (void)downloadButtonAction {
    //    NSAssert(self.currentImage != nil, @"currentImage can not be nil");
    if (self.saveImageBlock) {
        self.saveImageBlock();
    }
}

- (void)shareButtonAction {
    
}

#pragma mark - setter && getter
- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [[UIButton alloc] init];
        CGFloat width = 60;
        _downloadButton.frame = CGRectMake(CGRectGetMinX(self.shareButton.frame) - width, 0, width, CGRectGetHeight(self.bounds));
//        _downloadButton.backgroundColor = [UIColor redColor];
        UIImage *image = [UIImage cq_imageNamed:@"icon_download"];
        [_downloadButton setImage:image forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] init];
        CGFloat width = 60;
        _shareButton.frame = CGRectMake(cq_kScreentWidth - width, 0, width, CGRectGetHeight(self.bounds));
//        _shareButton.backgroundColor = [UIColor redColor];
        UIImage *image = [UIImage cq_imageNamed:@"icon_share"];
        [_shareButton setImage:image forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}




@end
