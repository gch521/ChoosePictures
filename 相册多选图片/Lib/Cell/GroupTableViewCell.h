//
//  GroupTableViewCell.h
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewCell : UITableViewCell

/**
 *  显示略图的图像视图
 */
@property (strong, nonatomic) UIImageView *headImageView;


/**
 *  显示姓名标签
 */
@property (strong, nonatomic) UILabel *lblName;


/**
 *  显示图片的数量
 */
@property (strong, nonatomic) UILabel *lblNumber;



@end
