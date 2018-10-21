//
//  CQPhotoBrowser.m
//  CQPhotoBrowser
//
//  Created by 谢传权 on 2018/10/21.
//

#import "CQPhotoBrowserVC.h"
#import "CQPhotoBrowserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CQPhotoBrowserVC () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, nonatomic) UICollectionView *photoCollectionView;


@end

@implementation CQPhotoBrowserVC

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

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
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
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
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSourceArray[indexPath.item]] placeholderImage:[UIImage imageNamed:@"bookDefault"]];
    return cell;
}


@end
