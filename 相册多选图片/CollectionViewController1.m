//
//  CollectionViewController.m
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "CollectionViewController1.h"
#import "YPhotoCollectionViewCell.h"
#import "PhotoNavigationController.h"
#import "PhotoBrowseViewController.h"


@interface CollectionViewController1 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) CGFloat size;//标准大小
@property (nonatomic, copy) NSArray <UIImage *> * images;//存储图片的数组
@property (nonatomic, copy) NSMutableArray <ALAsset *> *imageArray;


@end

@implementation CollectionViewController1
{

    UICollectionView *_collectionView;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.size = (self.view.bounds.size.width - 3) / 4.0f;
    self.images = [NSArray array];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.size, self.size );
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 内边距
   
    // 利用layout 创建一个集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    _collectionView.backgroundColor = [UIColor whiteColor];

//
    
    NSLog(@"----%ld", self.images.count);
    
    
    //设置collection
    _collectionView.allowsMultipleSelection = true;
    
    
    //注册cell
    [_collectionView registerClass:[YPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:(UIBarButtonItemStyleDone) target:self action:@selector(addPhotoAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
   
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.images.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //初始化cell
    YPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.photoImageView.image = self.images[indexPath.item];
    
    [cell hiddenSelectdImage];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-----main--------%ld", self.images.count);
    
    
    
    //创建浏览控制器
    PhotoBrowseViewController * browerViewController = [[PhotoBrowseViewController alloc] init];
    
    //设置初始值
   browerViewController._index = @"main";
    browerViewController._indexImage = self.images[indexPath.row];
    
    //弹出
    [self.navigationController pushViewController:browerViewController animated:true];

    
    
}



#pragma mark <UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.size, self.size);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


#pragma mark - Add Action

- (void)addPhotoAction:(id)sender
{
    //初始化照片选择器
    PhotoNavigationController * choosePhotoController = [[PhotoNavigationController alloc]init];
    
    //设置回调
    [choosePhotoController imageDidSelect:^(NSArray<UIImage *> * images) {
        
        NSLog(@"=======%ld", images.count);
        
        self.images = images;
        [_collectionView reloadData];
        
    }];
    
    //设置类型-(默认按照选择熟悉排列，下面设置是按照片在相册的顺序排列)
    //    choosePhotoController.photoSequenceType = YChoosePhotoSequenceTypeDate;
    
    //模态跳出
    [self presentViewController:choosePhotoController animated:true completion:^{}];
    
}



@end
