//
//  GroupTableViewCell.m
//  相册多选图片
//
//  Created by gch on 16/10/17.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self loadGroupTableViewCell];
    }
    
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


/**
 *  加载cell
 */
- (void)loadGroupTableViewCell
{
    [self loadAllViews];
  //  [self startAutoLayout];
}


/**
 *  加载所有的视图
 */
- (void)loadAllViews
{
    [self addSubview:self.headImageView];
    [self addSubview:self.lblName];
    [self addSubview:self.lblNumber];
}


#pragma mark - Getter


-(UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _headImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _headImageView;
}



-(UILabel *)lblName
{
    if (_lblName == nil)
    {
        _lblName = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 30)];
        _lblName.translatesAutoresizingMaskIntoConstraints = false;
        _lblName.font = [UIFont systemFontOfSize:14];
    }
    return _lblName;
}



-(UILabel *)lblNumber
{
    if (_lblNumber == nil)
    {
        _lblNumber = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 30)];
       // _lblNumber.translatesAutoresizingMaskIntoConstraints = false;
        _lblNumber.font = [UIFont systemFontOfSize:12];
    }
    return _lblNumber;
}

#pragma mark -

/**
 *  开始添加约束
 */
- (void)startAutoLayout
{
//    [self layoutHeadImageView];
//    [self layoutLblName];
//    [self layoutLblNumber];
    
   
}

/**
 *  给图像设置约束
 */
- (void)layoutHeadImageView
{
    NSArray * hor1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_headImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headImageView)];
    
    NSArray * ver1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_headImageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headImageView)];
    
    //设置比例约束
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:_headImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_headImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    
    [self addConstraints:hor1];
    [self addConstraints:ver1];
    [self addConstraint:constraint];
}


/**
 *  给组名称设置约束
 */
- (void)layoutLblName
{
    NSArray * hor2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-20-[_lblName]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headImageView,_lblName)];
    
    NSArray * ver2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_lblName(21)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headImageView,_lblName)];
    
    [self addConstraints:hor2];
    [self addConstraints:ver2];
}

/**
 *  给相册数量添加约束
 */
- (void)layoutLblNumber
{
    
    NSArray * hor3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-20-[_lblNumber]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headImageView,_lblNumber)];
    
    NSArray * ver3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lblName]-0-[_lblNumber(15)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblName,_lblNumber)];
    
    
    [self addConstraints:hor3];
    [self addConstraints:ver3];
}

@end
