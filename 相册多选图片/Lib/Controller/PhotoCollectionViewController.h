//
//  PhotoCollectionViewController.h
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YEnumConfig.h"

@interface PhotoCollectionViewController : UICollectionViewController


/**
 *  返回图片的顺序
 */
@property (nonatomic, assign) YChoosePhotoSequenceType photoSequenceType;

/**
 *  Done按钮被点击进行的回调设置
 *
 *  @param images 返回选中的数组
 */
- (void)imageDidSelect:(void (^)(NSArray <UIImage *> *)) images;

@end
