//
//  GroupTableViewController.m
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "GroupTableViewController.h"
#import "PhotoManager.h"
#import "GroupTableViewCell.h"
#import "PhotoCollectionViewController.h"
@import AssetsLibrary;

@interface GroupTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PhotoManager * photoManager;     //请求图片的Manager
@property (nonatomic, copy) NSArray <ALAssetsGroup *> * groups; //存放资源组对象的数组
@property (nonatomic, copy) ImagesBlock imagesBlock;            //代码块属性
@property (nonatomic, assign) BOOL isPushCameraRoll;            //是否跳入胶卷相册，默认为false

@property (nonatomic, strong)UITableView *tableView;


@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //左item
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //初始化单例
    self.photoManager = [PhotoManager shareInstance];
    
    
    self.title = @"相册";
    
    //设置自定高度
    self.tableView.rowHeight = 80;
    
    
    
    //开始加载数据
    [self requestPhotoGroup];
}

//设置回调
- (void)imageDidSelect:(void (^)(NSArray <UIImage *> *)) images
{
    self.imagesBlock = images;
}


#pragma mark - Function
/**
 *  加载相片组
 */
- (void)requestPhotoGroup
{
    //避免强引用
    __block __weak typeof(self) copy_self = self;
    
    //开始请求
    [self.photoManager readAllPhotoGroups:^(NSArray<ALAssetsGroup *> *groups) {
        
        copy_self.groups = groups;
        [copy_self.tableView reloadData];
        
    } Fail:^(NSString *error) {} CameraRollHandel:^{
        
        //是第一次进入，跳转
        if (copy_self.isPushCameraRoll == true)
        {
            //跳入
            [copy_self pushCollectionViewController:copy_self.groups[0] animated:false];
            
            //置false
            copy_self.isPushCameraRoll = false;
        }
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获得当前的数据
    ALAssetsGroup * group = self.groups[indexPath.row];
    
    static NSString *reuseIdentifier = @"cell";
    
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[GroupTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    
    
    //获得当前的预览图
    CGImageRef imageRef = [group posterImage];
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    
    //获得当前组名，国际化名称
    NSString * groupName = NSLocalizedString([group valueForProperty:ALAssetsGroupPropertyName],@"");
    
    //获得照片数量
    NSInteger numberPhotoOfGroup = [group numberOfAssets];
    
    
    //设置属性
    cell.headImageView.image = image;
    cell.lblName.text = groupName;
    NSLog(@"-----%@", groupName);
    cell.lblNumber.text = [NSString stringWithFormat:@"%ld",numberPhotoOfGroup];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    //获取group模型
    ALAssetsGroup * group = self.groups[indexPath.row];
    
    //跳入照片展示控制器
    [self pushCollectionViewController:group animated:true];
}


#pragma mark - dissmiss
- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:true completion:^{}];
}


#pragma mark - Push Collection

/**
 *  跳至选择视图
 *
 *  @param group    需要传入的group值
 *  @param animated 是否动画跳入
 */
- (void)pushCollectionViewController:(ALAssetsGroup *)group animated:(BOOL)animated
{
    //初始化布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
//    获取当前控制器
    PhotoCollectionViewController * photoCollectionController = [[PhotoCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
//    传递
    [photoCollectionController setValue:group forKey:@"group"];
    
//    设置回调
    [photoCollectionController imageDidSelect:^(NSArray<UIImage *> * images) {
        
        //进行回调
        self.imagesBlock(images);
    }];
    //设置类型
    photoCollectionController.photoSequenceType = self.photoSequenceType;
    //push
    [self.navigationController pushViewController:photoCollectionController animated:YES];
}


//跳入到所有相片的控制器
-(void)pushToAllPhotosCollectionViewController
{
    self.isPushCameraRoll = true;
    
}



@end
