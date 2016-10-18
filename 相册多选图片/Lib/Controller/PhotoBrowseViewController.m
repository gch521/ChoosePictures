//
//  PhotoBrowseViewController.m
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "PhotoBrowseViewController.h"

@interface PhotoBrowseViewController ()



@end

@implementation PhotoBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加组件
    [self.view addSubview:self.tempImageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置大图
    UIImage * image = [UIImage imageWithCGImage:self.currentAsset.defaultRepresentation.fullScreenImage];
    
    if ([self._index isEqualToString:@"main"]) {
        self.tempImageView.image = self._indexImage;
    } else {
        self.tempImageView.image = image;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Getter

//显示的视图
-(UIImageView *)tempImageView
{
    if (_tempImageView == nil)
    {
        _tempImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _tempImageView.contentMode = UIViewContentModeScaleAspectFit;
        _tempImageView.backgroundColor = [UIColor blackColor];
    }
    return _tempImageView;
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
