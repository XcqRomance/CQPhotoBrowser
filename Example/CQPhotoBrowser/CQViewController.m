//
//  CQViewController.m
//  CQPhotoBrowser
//
//  Created by XcqRomance on 10/20/2018.
//  Copyright (c) 2018 XcqRomance. All rights reserved.
//

#import "CQViewController.h"
#import "CQPhotoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CQPhotoBrowserUtil.h"

@interface CQViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, nonatomic) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation CQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupDataSource];
    
    [self setupCollectionView];
}

- (void)setupDataSource {
    NSArray *datasource = @[@"https://opas-file-aliyun.firstleap.cn/image/20160823/7899760bff8bc4f5b34c0ae40910da16.png",@"https://opas-file-aliyun.firstleap.cn/image/20160826/d51285bb636281dce6974313eaf6f15d.png",@"https://opas-file-aliyun.firstleap.cn/image/20160906/8d4756e4e1ee555ef2fb5e2abda47afe.png",@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"];
    self.photos = [NSMutableArray array];
    
    for (int i = 0; i < 8; i ++) {
        [self.photos addObjectsFromArray:datasource];
    }
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((CGRectGetWidth(self.view.bounds) - 2*4)/3, 100);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.backgroundColor = [UIColor whiteColor];
    [self.photoCollectionView registerClass:[CQPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([CQPhotoCell class])];
    [self.view addSubview:self.photoCollectionView];
}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CQPhotoCell class]) forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.photos[indexPath.item]] placeholderImage:[UIImage imageNamed:@"bookDefault"]]; 
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [CQPhotoBrowserUtil showPhotoWithPhotos:self.photos index:0 thumbImages:@[] thumbImagesFrame:@[]];
    
}

@end
