//
//  ViewController.m
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "CellViewModel.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL filterMode;
@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"Find Similar Images";
        self.view.backgroundColor = [UIColor whiteColor];
        
        _dataSource = [[NSMutableArray alloc] initWithCapacity:8];
        
        self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80.0, 80.0);
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resetData];
    [self.collectionView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark init data
- (void)resetData {
    [self.dataSource removeAllObjects];
    for (NSInteger index = 0; index < 16; index++) {
        NSString *imageName = [NSString stringWithFormat:@"%ld.jpg", index];
        UIImage *image = [UIImage imageNamed:imageName];
        CellViewModel *viewModel = [[CellViewModel alloc] init];
        viewModel.image = image;
        [self.dataSource addObject:viewModel];
    }
    self.filterMode = NO;
}

- (void)filterData {
    [self resetData];
    NSInteger total = self.dataSource.count;
    for (NSInteger i = 0; i < total; i++) {
        CellViewModel *vm1 = (CellViewModel *)self.dataSource[i];
        for (NSInteger j = (i+1); j < total; j++) {
            CellViewModel *vm2 = (CellViewModel *)self.dataSource[j];
            NSInteger different = [UIImage differentValueCountWithString:vm1.pHashString andString:vm2.pHashString];
            if (different <= 5) {
                vm1.marked = YES;
                break;
            }
        }
    }
    self.filterMode = YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellViewModel *viewModel = (CellViewModel *)self.dataSource[indexPath.item];
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                                                         forIndexPath:indexPath];
    
    cell.imageView.image = viewModel.image;
    cell.marked = viewModel.marked;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Filter
- (void)action {
    if (self.filterMode) {
        [self resetData];
    } else {
        [self filterData];
    }
    [self.collectionView reloadData];
}

#pragma mark - Getter/Setter
- (void)setFilterMode:(BOOL)filterMode {
    _filterMode = filterMode;
    self.rightItem.title = _filterMode ? @"Reset" : @"Filter";
}
@end
