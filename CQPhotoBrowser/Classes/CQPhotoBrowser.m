//
//  CQPhotoBrowser.m
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import "CQPhotoBrowser.h"
#import "CQPhotoBrowserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CQPhotoTopToolBarView.h"
#import "CQPhotoBottomToolBarView.h"
#import "CQPhotoBrowserMacroDefinition.h"

static const int backgroundContainerViewTag = 10000;
static const NSTimeInterval anmationDuration = 0.35;

@interface CQPhotoBrowser () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

// 截屏显示的view
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *backgroundContainerView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UICollectionView *photoCollectionView;

@property (nonatomic, assign) NSUInteger photoIndex;

@property (nonatomic, strong) CQPhotoTopToolBarView *topView;

@property (nonatomic, strong) CQPhotoBottomToolBarView *bottomView;


@end

@implementation CQPhotoBrowser

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSAssert(self.backgroundImage != nil, @"backgroundImage can not be nil");
    NSAssert(self.thumbImages.count > 0, @"thumbImages array can not be empety");
    NSAssert(self.thumbImagesFrames.count > 0, @"thumbImagesFrame array can not be empety");
    NSAssert(self.thumbImagesFrames.count == self.thumbImages.count, @"thumbImagesFrame array count must be equal to thumbImages array count");
    NSAssert(self.dataSourceArray.count > 0, @"dataSourceArray array can not be empety");
    NSAssert(self.dataSourceArray.count == self.thumbImages.count, @"dataSourceArray array count must be equal to thumbImages array count");
    
    
    [self setupBackgroundContainerView];
    [self setupContainerView];
    
    [self setupTopView];
    
    [self setupBottomView];
    
    [self setupTopAndBottomViewHidden:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self presentAnimation];
}

- (void)dealloc {
    
}

#pragma mark - private method

- (void)presentAnimation {
    
//    UIImage *currentImage = self.thumbImages[self.currentIndex];
    UIImageView *imageView = [self.backgroundContainerView viewWithTag:backgroundContainerViewTag + self.currentIndex];
//    imageView.image = currentImage;
    imageView.hidden = NO;
    self.containerView.hidden = YES;
    NSValue *value = self.thumbImagesFrames[self.currentIndex];
    
    [UIView animateWithDuration:anmationDuration animations:^{
        imageView.frame = [self imageFrameWithImage:imageView.image];
        self.backgroundContainerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    } completion:^(BOOL finished) {
        self.containerView.hidden = NO;
        imageView.frame = [value CGRectValue];
        imageView.hidden = YES;
        [self setupTopAndBottomViewHidden:NO];
    }];
}

- (void)dismissAnimation {
    [self dismissAnimationWithImageFrameValue:nil];
}

- (void)dismissAnimationWithImageFrameValue:(NSValue *)imageFrameValue {
    [self setupTopAndBottomViewHidden:YES];
    
    UIImage *currentImage = self.thumbImages[self.currentIndex];
    UIImageView *imageView = [self.backgroundContainerView viewWithTag:backgroundContainerViewTag + self.currentIndex];
    imageView.image = currentImage;
    
    if (imageFrameValue) {
        imageView.frame = [imageFrameValue CGRectValue];
    } else {
        imageView.frame = [self imageFrameWithImage:currentImage];
    }
    
    imageView.hidden = NO;
    self.containerView.hidden = YES;
    
    NSValue *value = self.thumbImagesFrames[self.currentIndex];
    [UIView animateWithDuration:anmationDuration animations:^{
        imageView.frame = [value CGRectValue];
        self.backgroundContainerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];

}

- (CGRect)imageFrameWithImage:(UIImage *)image {
    if (image == nil) {
        return self.view.bounds;
    }
    CGSize imageSize = image.size;
    CGFloat destinationImageHeight =  CGRectGetWidth(self.view.bounds) * imageSize.height / imageSize.width;
    CGRect imageRect = CGRectMake(0, (CGRectGetHeight(self.view.bounds) - destinationImageHeight) / 2, CGRectGetWidth(self.view.bounds), destinationImageHeight);
    return imageRect;
}

- (void)setupBackgroundContainerView {
    // add background Imageview
    [self.view addSubview:self.backgroundImageView];
    
    // add animation ImageView
    if (self.thumbImagesFrames && [self.thumbImagesFrames isKindOfClass:[NSArray class]] && self.thumbImagesFrames.count > 0) {
        for (NSUInteger i = 0; i < self.thumbImagesFrames.count; i++) {
            NSValue *rectValue = self.thumbImagesFrames[i];
            CGRect rect = [rectValue CGRectValue];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.tag = backgroundContainerViewTag + i;
            imageView.image = self.thumbImages[i];
            imageView.hidden = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
//            imageView.backgroundColor = [UIColor clearColor];
            [self.backgroundContainerView addSubview:imageView];
        }
    }
    
    [self.view addSubview:self.backgroundContainerView];
}

- (void)setupContainerView {
    [self.view addSubview:self.containerView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.maximumNumberOfTouches = 1;
    panGesture.delegate = self;
    [self.containerView addGestureRecognizer:panGesture];

    [self setupCollocetionView];
}

- (void)setupCollocetionView {
    [self.containerView addSubview:self.photoCollectionView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.photoCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)setupTopView {
    // add topView
    [self.view addSubview:self.topView];
    
    // set title
    if (self.dataSourceArray.count > 1) {
        [self.topView setTitleWithCurrentIndex:self.currentIndex+1 totalIndex:self.dataSourceArray.count];
    }
    
    // set custom topView
    if ([self.delegate respondsToSelector:@selector(photoBrowserTopToolBarView)]) {
        UIView *topToolBarView = [self.delegate photoBrowserTopToolBarView];
        if (topToolBarView) {
            [self.topView setTitleHidden];
            [self.topView addSubview:topToolBarView];
            CGRect frame = topToolBarView.frame;
            frame.origin = CGPointZero;
            topToolBarView.frame = frame;
        }
    }
}

- (void)setupBottomView {
    
    [self.view addSubview:self.bottomView];
    self.bottomView.backgroundColor = [UIColor yellowColor];
    
    if ([self.delegate respondsToSelector:@selector(photoBrowserBottomToolBarView)]) {
        UIView *bottomToolBarView = [self.delegate photoBrowserBottomToolBarView];
        if (bottomToolBarView) {
            [self.bottomView setDownloadButtonHidden];
            [self.bottomView addSubview:bottomToolBarView];
            CGRect frame = bottomToolBarView.frame;
            frame.origin = CGPointZero;
            bottomToolBarView.frame = frame;
        }
    }
}

- (void)setupTopAndBottomViewHidden:(BOOL)hidden {
    self.topView.hidden = hidden;
    self.bottomView.hidden = hidden;
}

#pragma mark - event response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
//    UIImageView *imageView = [self.backgroundContainerView viewWithTag:backgroundContainerViewTag + self.currentIndex];
    CQLog(@"state:=======%ld",(long)gestureRecognizer.state);
    UIView *inview = gestureRecognizer.view.superview;
    CGPoint translate = [gestureRecognizer translationInView:inview];
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.photoCollectionView.scrollEnabled = NO;
        // 平移 containerView
        self.containerView.transform = CGAffineTransformTranslate(self.containerView.transform, translate.x, translate.y);
        // 计算偏移量，两个数平方的和的平方根
        CGFloat offset = hypotf(self.containerView.transform.tx, self.containerView.transform.ty);
        CQLog(@"offset:-----%f",offset);
        CGFloat scale = offset / 100;
        if (scale > 1) {
            scale = 1;
        }
        // 根据偏移量设置背景透明度
        self.backgroundContainerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0 - scale * 0.4];
        // 设置图片缩放 
        self.photoCollectionView.transform =  CGAffineTransformMakeScale(1 - scale*0.4, 1- scale *0.4);
        
        CQLog(@"%@",NSStringFromCGPoint(translate));
        [gestureRecognizer setTranslation:CGPointZero inView:inview];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        imageView.frame = [self imageFrameWithImage:self.thumbImages[self.currentIndex]];
        [self setupTopAndBottomViewHidden:YES];
        
    } else {
        self.photoCollectionView.scrollEnabled = YES;
        
        // 计算偏移量，两个数平方的和的平方根
        CGFloat offset = hypotf(self.containerView.transform.tx, self.containerView.transform.ty);
        if (offset > 100) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
            CQPhotoBrowserCell *cell = (CQPhotoBrowserCell *)[self.photoCollectionView cellForItemAtIndexPath:indexPath];
            UIImageView *imageView = cell.imageView;
            CGRect imageViewFrame = imageView.frame;
            CGRect windowFrame = [imageView.superview convertRect:imageViewFrame toView:[UIApplication sharedApplication].keyWindow];
            CQLog(@"");
            [self dismissAnimationWithImageFrameValue:[NSValue valueWithCGRect:windowFrame]];
        } else {
            [UIView animateWithDuration:anmationDuration animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.photoCollectionView.transform = CGAffineTransformIdentity;//CGAffineTransformMakeScale(1, 1)
                self.backgroundContainerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
            } completion:^(BOOL finished) {
                [self setupTopAndBottomViewHidden:NO];
            }];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if (otherGestureRecognizer.view == self.photoCollectionView ) {
//        return YES;
//    }
//    return NO;
//}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CQPhotoBrowserCell class]) forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSourceArray[indexPath.item]] placeholderImage:[UIImage imageNamed:@"bookDefault"]];
    cell.imageView.frame = [self imageFrameWithImage:self.thumbImages[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.item;
    [self dismissAnimation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat x = scrollView.contentOffset.x;
//    CGFloat index = x / CGRectGetWidth(scrollView.bounds);
//    self.currentIndex = (NSUInteger)index;
//    [self.topView setTitleWithCurrentIndex:self.currentIndex totalIndex:self.dataSourceArray.count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.bounds);
    CGFloat x = scrollView.contentOffset.x + width/2;
    NSUInteger index = (NSUInteger)(x / width);
    if (self.currentIndex != index) { // 翻页了才更新index值
        self.currentIndex = index;
        self.photoIndex = (NSUInteger)index + 1;
        CQLog(@"--scrollViewDidScroll---index:%lu",(unsigned long)self.photoIndex);
        [self.topView setTitleWithCurrentIndex:self.currentIndex+1 totalIndex:self.dataSourceArray.count];
//        [self.bottomView setCurrentImage:image];
        
        if ([self.delegate respondsToSelector:@selector(photoBrowserDidChangeCurrentPhotoIndex:)]) {
            [self.delegate photoBrowserDidChangeCurrentPhotoIndex:self.photoIndex];
        }
    }
}

#pragma mark - setter && getter

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        //        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _photoCollectionView.backgroundColor = [UIColor clearColor];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        [_photoCollectionView registerClass:[CQPhotoBrowserCell class] forCellWithReuseIdentifier:NSStringFromClass([CQPhotoBrowserCell class])];
        _photoCollectionView.pagingEnabled = YES;
    }
    return _photoCollectionView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
        _backgroundImageView.frame = self.view.bounds;
    }
    return _backgroundImageView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIView *)backgroundContainerView {
    if (!_backgroundContainerView) {
        _backgroundContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backgroundContainerView.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _backgroundContainerView;
}

- (CQPhotoTopToolBarView *)topView {
    if (!_topView) {
        _topView = [[CQPhotoTopToolBarView alloc] initWithFrame:CGRectMake(0, cq_liuhaiHeight, cq_kScreentWidth, 44)];
    }
    return _topView; 
}


-(CQPhotoBottomToolBarView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CQPhotoBottomToolBarView alloc] initWithFrame:CGRectMake(0, cq_kScreentHeight - cq_kHomeIndicatorHeight - 44, cq_kScreentWidth, 44)];
        weakify(weakSelf)
        _bottomView.saveImageBlock = ^{
            strongify(strongSelf)
            // 图片已经下载
            UIImage *image = [[[SDWebImageManager sharedManager] imageCache] imageFromCacheForKey:strongSelf.dataSourceArray[strongSelf.currentIndex]];
            // 图片没有下载使用缩略图
            if (!image) {
                image = strongSelf.thumbImages[strongSelf.currentIndex];
            }

            if (image) {
                UIImageWriteToSavedPhotosAlbum(image, strongSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        };
    }
    return _bottomView;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if ([self.delegate respondsToSelector:@selector(photoBrowserDidFinishSavingImageWithError:)]) {
        [self.delegate photoBrowserDidFinishSavingImageWithError:error];
    } else {
        if (error) {
            CQLog(@"failed");
        } else {
            CQLog(@"success");
        }
    }
}

@end
