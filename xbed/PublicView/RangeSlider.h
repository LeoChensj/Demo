//
//  RangeSlider.h
//  xbed
//
//  Created by Leo.Chen on 16/3/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  范围选择控件

#import <UIKit/UIKit.h>

@interface RangeSlider : UIControl
{
@private
    UIImageView *_ivMinThumb;
    UIImageView *_ivMaxThumb;
    UIView *_vTrackNormal;
    UIView *_vTrackSelect;
    
    BOOL _minThumbOn;
    BOOL _maxThumbOn;
    
    CGSize _thumbSize;
    CGFloat _xInterval;
    
}

@property(nonatomic, assign)NSInteger valueMin;             //default 0
@property(nonatomic, assign)NSInteger valueMax;             //default 100
@property(nonatomic, assign)NSInteger limitMin;             //最小值  default 0
@property(nonatomic, assign)NSInteger limitMax;             //最大值  default 100

@property(nonatomic, assign)NSInteger interval;             //default 10

@property (nonatomic, strong)NSString *imageThumb;          //default 30*30 red
@property (nonatomic, strong)UIColor *trackNormalColor;     //default gray
@property (nonatomic, strong)UIColor *trackSelectColor;     //default blue
@property (nonatomic, assign)NSInteger trackNormalHeight;   //default 4
@property (nonatomic, assign)NSInteger trackSelectHeight;   //default 6

@end
