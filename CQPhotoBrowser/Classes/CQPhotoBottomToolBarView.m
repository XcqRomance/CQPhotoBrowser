//
//  CQPhotoBottomToolBarView.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import "CQPhotoBottomToolBarView.h"
#import "CQPhotoBrowserMacroDefinition.h"

@interface CQPhotoBottomToolBarView()

@property(nonatomic, strong)UIButton *downloadButton;
//@property(nonatomic, strong)UIImage *currentImage;

@end


@implementation CQPhotoBottomToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.downloadButton = [[UIButton alloc] init];
    self.downloadButton.frame = CGRectMake(0, 0, 60, 30);
    self.downloadButton.backgroundColor = [UIColor redColor];
    [self.downloadButton setImage:[UIImage imageNamed:@"plplayer_top_icon_download" inBundle:[NSBundle bundleWithIdentifier:@""] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    [self.downloadButton addTarget:self action:@selector(downloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.downloadButton];
}

- (void)downloadButtonAction {
//    NSAssert(self.currentImage != nil, @"currentImage can not be nil");
    if (self.saveImageBlock) {
        self.saveImageBlock();
    }
}

- (void)setDownloadButtonHidden {
    self.downloadButton.hidden = YES;
}

//- (void)setCurrentImage:(UIImage *)image {
//    self.currentImage = image;
//}


@end
