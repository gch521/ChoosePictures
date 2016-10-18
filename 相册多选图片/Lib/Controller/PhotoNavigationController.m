//
//  PhotoNavigationController.m
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "PhotoNavigationController.h"
#import "GroupTableViewController.h"

@interface PhotoNavigationController ()

@property (nonatomic, copy) ImagesBlock imagesBlock; //代码块属性

@end

@implementation PhotoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTranslucent:true];
    
    //获得storyBoard对象
    self.title = @"相机图片";
    
    NSLog(@"========================");
       
    //获得组控制器
    GroupTableViewController * groupTableViewController = [[GroupTableViewController alloc] init];
    
    
   
   
    //设置回调
    [groupTableViewController imageDidSelect:^(NSArray<UIImage *> * images) {
        
        //进行回调
        self.imagesBlock(images);
        
    }];
    
    //设置类型
    groupTableViewController.photoSequenceType = self.photoSequenceType;
    
    self.viewControllers = @[groupTableViewController];
    
    
    //迅速跳转至所有图片
    [groupTableViewController pushToAllPhotosCollectionViewController];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//设置回调
- (void)imageDidSelect:(void (^)(NSArray <UIImage *> *)) images
{
    self.imagesBlock = images;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
