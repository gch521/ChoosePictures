//
//  PhotoCollectionViewCell.h
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YEnumConfig.h"

@interface YPhotoCollectionViewCell : UICollectionViewCell

/**
 *  展示图片的按钮
 */
@property (strong, nonatomic)UIImageView * photoImageView;


/**
 *  隐藏选中图片
 */
- (void)hiddenSelectdImage;


/**
 *  已经被选中
 */
- (void)didSelected;


/**
 *  已经不被选中
 */
- (void)didDeSelected;



/**
 *  被选中执行的回调
 *
 *  @param chooseTapBlockHandle 执行的代码块
 */
- (void)choosedImageDidTap:(YPhotoCollectionViewBlock)chooseTapBlockHandle;




/**
 *  撤销选中执行的回调
 *
 *  @param disChooseTapBlockHandle 执行的代码块
 */
- (void)disChoosedImageDidTap:(YPhotoCollectionViewBlock)disChooseTapBlockHandle;


@end
