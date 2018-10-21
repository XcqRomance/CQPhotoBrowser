//
//  CQPhotoViewController.m
//  CQPhotoBrowser
//
//  Created by xcqromance on 2018/10/20.
//

#import "CQPhotoBrowser.h"
#import "CQPhotoBrowserCell.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@interface CQPhotoBrowser () <UICollectionViewDataSource>

@property (nonatomic, nonatomic) UICollectionView *photoCollectionView;


@end

@implementation CQPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCollocetionView];
}

- (void)setupCollocetionView {
    [self.view addSubview:self.photoCollectionView];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter && getter

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        layout.minimumInteritemSpacing = 0;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_photoCollectionView registerClass:[CQPhotoBrowserCell class] forCellWithReuseIdentifier:NSStringFromClass([CQPhotoBrowserCell class])];
    }
    return _photoCollectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CQPhotoBrowserCell class]) forIndexPath:indexPath];
//    [cell.imageView ]
    return cell;
}

@end
