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
//#import <CQPhotoBrowser/CQPhotoBrowser-umbrella.h>
#import "CQPhotoBrowserUtil.h"

@interface CQViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, nonatomic) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation CQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *datasource = @[@"https://opas-file-aliyun.firstleap.cn/image/20160823/7899760bff8bc4f5b34c0ae40910da16.png",@"https://opas-file-aliyun.firstleap.cn/image/20160826/d51285bb636281dce6974313eaf6f15d.png",@"https://opas-file-aliyun.firstleap.cn/image/20160906/8d4756e4e1ee555ef2fb5e2abda47afe.png"];
    self.photos = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        [self.photos addObjectsFromArray:datasource];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    [self.photoCollectionView registerClass:[CQPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([CQPhotoCell class])];
    [self.photoCollectionView reloadData];
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
//    cqph
    [CQPhotoBrowserUtil showPhotoWithPhotos:self.photos index:0 thumbImages:nil thumbImagesFrame:nil];
}

@end
