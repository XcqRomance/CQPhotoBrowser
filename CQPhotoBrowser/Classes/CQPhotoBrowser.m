//
//  CQPhotoBrowser.m
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import "CQPhotoBrowser.h"
#import "CQPhotoBrowserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static const int backgroundContainerViewTag = 10000;
static const NSTimeInterval anmationDuration = 1;

@interface CQPhotoBrowser () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

// 截屏显示的view
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *backgroundContainerView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UICollectionView *photoCollectionView;


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
    }];
}

- (void)dismissAnimation {
    UIImage *currentImage = self.thumbImages[self.currentIndex];
    UIImageView *imageView = [self.backgroundContainerView viewWithTag:backgroundContainerViewTag + self.currentIndex];
    imageView.image = currentImage;
    
    imageView.frame = [self imageFrameWithImage:currentImage];
    
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
    panGesture.delegate = self;
    [self.containerView addGestureRecognizer:panGesture];
    
    [self setupCollocetionView];
}

- (void)setupCollocetionView {
    [self.containerView addSubview:self.photoCollectionView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.photoCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - event response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
}

#pragma mark - UIGestureRecognizerDelegate

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

#pragma mark - setter && getter

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        //        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
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
        _containerView.backgroundColor = [UIColor whiteColor];
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

@end
