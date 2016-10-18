//
//  PhotoBrowseViewController.h
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YEnumConfig.h"


/**
 *  浏览高清图片的控制器
 */
@interface PhotoBrowseViewController : UIViewController

/**
 *  当前看的资源对象
 */
@property (nonatomic, strong) ALAsset * currentAsset;

//负责只显示一个当前图
@property (nonatomic, strong) UIImageView * tempImageView;


@property (nonatomic, strong)NSString *_index; // 标记
@property (nonatomic, strong)UIImage *_indexImage;


@end
