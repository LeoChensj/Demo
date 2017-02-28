//
//  GuiderView.m
//  idface_kexin
//
//  Created by macbook on 15/9/10.
//  Copyright (c) 2015年 idface. All rights reserved.
//

#import "GuiderView.h"

@interface GuiderView ()
{
    UIView * _logoView1;//画布
    UILabel * _titleLabel1;//标题
   
    CAShapeLayer * _pathLayer1;//尝试保护内存
    
    UIImageView  *_bg1;  //背景
    
    
    
}
@end
@implementation GuiderView

//单例
+ (instancetype)shared
{
    static dispatch_once_t once = 0;
    static GuiderView *alert;
    dispatch_once(&once, ^{
        alert = [[GuiderView alloc] init];
    });
    return alert;
}
+ (instancetype)title1:(NSString *)title  callBlock1:(callBack1)callBack1

{
    
    [[self shared] setClickBlock1:nil];//释放掉之前的Block
    [[self shared] setClickBlock1:callBack1];
    [[self shared] setHidden:NO];//设置为不隐藏
    return  [self shared];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = (CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size};
        self.alpha = 1;
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = NO;//不隐藏
        self.windowLevel = 100;
        
        [self setInterFace];
    }
    
    return self;
}
/**
 *
 *
 *  界面初始化
 */
- (void)setInterFace
{
    [self logoInit1];
    [self controlsInit1];
}
/**
 *  @Author wang kun
 *
 *  初始化控件
 */
- (void)controlsInit1
{
    
//    UIView  *_daoghao=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,55)];
//    
//    _daoghao.backgroundColor=[UIColor colorWithRed:18.0/255.0 green:93.0/255.0 blue:184.0/255.0 alpha:100];
//    [self addSubview:_daoghao];
//    
//    UILabel *_titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-50,23,100,18)];
//  
//    _titleLabel2.textColor = [UIColor whiteColor];//其中textColor要用UIColor类型
//    _titleLabel2.text=@"人脸验证";
//    [_titleLabel2 setFont:[UIFont systemFontOfSize:16]];
//    [_titleLabel2 setTextAlignment:NSTextAlignmentCenter];
//    [self addSubview:_titleLabel2];
    
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navBar.backgroundColor = Blue_Color;
    [self addSubview:navBar];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-50, 32, 100, 20)];
    lbTitle.text = @"人脸验证";
    lbTitle.textColor = [UIColor whiteColor];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = Font(18);
    [self addSubview:lbTitle];
    
    
    
    if (KiPhone6Plus||KiPhone6) {
      _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-97,80,200,18)];
    }else{
        _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-97,66,200,18)];
  
    }
    
    _titleLabel1.textColor = Blue_Color;//其中textColor要用UIColor类型
    _titleLabel1.text=@"验证时,请将镜头对准您的脸";
    [_titleLabel1 setFont:[UIFont systemFontOfSize:15]];
    [_titleLabel1 setTextAlignment:NSTextAlignmentCenter];
    
   if(KiPhone6Plus||KiPhone6){
    _bg1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-190*0.5,_titleLabel1.origin.y+45,180,180)];
   }else{
     _bg1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-kScreenWidth/2.3*0.5,_titleLabel1.origin.y+kScreenWidth/7.5,kScreenWidth/2.3,kScreenWidth/2.3)];
   }
    [_bg1 setImage:[UIImage imageNamed:@"caozuo1.jpg"]];
    UIImageView   *_bg2;
    
    
    if(KiPhone6Plus||KiPhone6){
    _bg2=[[UIImageView alloc] initWithFrame:CGRectMake(20,_bg1.origin.y+37+180,95,95)];
    }else{
    _bg2=[[UIImageView alloc] initWithFrame:CGRectMake(10,_bg1.origin.y+7+kScreenWidth/2,kScreenWidth/3.4,kScreenWidth/3.4)];
    }
    [_bg2 setImage:[UIImage imageNamed:@"caozuo2.png"]];

    [self addSubview:_bg2];
    UILabel  *_titleLabel21;
    if (KiPhone6Plus||KiPhone6) {
        _titleLabel21 = [[UILabel alloc] initWithFrame:CGRectMake(25,_bg2.origin.y+95+9,83,18)];
    }else{
        _titleLabel21 = [[UILabel alloc] initWithFrame:CGRectMake(15,_bg2.origin.y+kScreenWidth/3.4+5,83,18)];
    }
    
    _titleLabel21.textColor = [UIColor darkGrayColor];//其中textColor要用UIColor类型
    _titleLabel21.text=@"不要侧光";
    [_titleLabel21 setFont:[UIFont systemFontOfSize:13]];
    [_titleLabel21 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel21];

    UIImageView    *_bg3;
    if (KiPhone6Plus||KiPhone6) {
    _bg3=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3+17,_bg1.origin.y+180+37,95,95)];
    }else{
    _bg3=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3+6,_bg1.origin.y+7+kScreenWidth/2,kScreenWidth/3.4,kScreenWidth/3.4)];
  
    }
        [_bg3 setImage:[UIImage imageNamed:@"caozuo3.png"]];

 [self addSubview:_bg3];
    UILabel  *_titleLabel22;
    if (KiPhone6Plus||KiPhone6) {
  _titleLabel22 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3+21,_bg2.origin.y+95+9,88,18)];
    }else{
        _titleLabel22 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3+7,_bg2.origin.y+kScreenWidth/3.4+5,88,18)];
    }
    _titleLabel22.textColor = [UIColor darkGrayColor];//其中textColor要用UIColor类型
    _titleLabel22.text=@"不要遮挡眼睛";
    [_titleLabel22 setFont:[UIFont systemFontOfSize:13]];
    [_titleLabel22 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel22];

    UIImageView   *_bg4;
    
    if (KiPhone6Plus||KiPhone6) {
    _bg4=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3+kScreenWidth/3+6,_bg1.origin.y+37+180,95,95)];
    }else{
      _bg4=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3+kScreenWidth/3,_bg1.origin.y+7+kScreenWidth/2,kScreenWidth/3.4,kScreenWidth/3.4)];
    }
    [_bg4 setImage:[UIImage imageNamed:@"caozuo4.png"]];

    [self addSubview:_bg4];
    UILabel  *_titleLabel23;
    
    if (KiPhone6Plus||KiPhone6) {
   _titleLabel23 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3+kScreenWidth/3+16,_bg2.origin.y+95+9,83,18)];
    }else{
       _titleLabel23 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3+kScreenWidth/3.4+5,_bg2.origin.y+kScreenWidth/3.4+5,83,18)];
    }
    _titleLabel23.textColor = [UIColor darkGrayColor];//其中textColor要用UIColor类型
    _titleLabel23.text=@"不要戴帽子";
    [_titleLabel23 setFont:[UIFont systemFontOfSize:13]];
    [_titleLabel23 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel23];
    
//    MyButton *_OkButton1 = [MyButton buttonWithType:UIButtonTypeCustom];
//    [_OkButton1 setTitle:@"知道了" forState:UIControlStateNormal];
//   
//    _OkButton1.backgroundColor=[UIColor colorWithRed:192.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:100];
//    CALayer *layer_btn1 = _OkButton1.layer;
//    layer_btn1.masksToBounds = YES;
//    layer_btn1.cornerRadius = 8;
//    layer_btn1.borderWidth = 1;
//    //layer_btn1.borderColor = [UIColor orangeColor].CGColor;
//    layer_btn1.borderColor=[UIColor colorWithRed:192.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:100].CGColor;
//if (KiPhone6Plus||KiPhone6) {
//    _OkButton1.frame = CGRectMake(kScreenWidth*0.5-250*0.5,_titleLabel22.origin.y+40+10,250,40);
//}else{
//    _OkButton1.frame = CGRectMake(kScreenWidth*0.5-250*0.5,_titleLabel22.origin.y+20+10,250,40);
//}
//    
//    [self addSubview:_OkButton1];
    
    UIButton *_OkButton1 = [[UIButton alloc] init];
    if (KiPhone6Plus||KiPhone6)
        _OkButton1.frame = CGRectMake(kScreenWidth*0.5-250*0.5,_titleLabel22.origin.y+40+10,250,40);
    else
        _OkButton1.frame = CGRectMake(kScreenWidth*0.5-250*0.5,_titleLabel22.origin.y+20+10,250,40);
    _OkButton1.backgroundColor = Blue_Color;
    _OkButton1.layer.masksToBounds = YES;
    _OkButton1.layer.cornerRadius = 3;
    [_OkButton1 setTitle:@"知道了" forState:UIControlStateNormal];
    [_OkButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _OkButton1.titleLabel.font = Font(14);
    [self addSubview:_OkButton1];
    
    
    
    [self addSubview:_bg1];
    [self addSubview:_titleLabel1];
    
    [_OkButton1 addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
   
    
}
- (void)buttonClick1:(MyButton *)btn
{
   self.clickBlock1(0);

}
    
    /**
 *  @Author wang kun
 *
 *  初始化logo视图——画布
 */

- (void)logoInit1
{
    //移除画布
    [_logoView1 removeFromSuperview];
    _logoView1 = nil;
    //新建画布
    _logoView1                     = [UIView new];
    _logoView1.center              = CGPointMake(self.center.x, self.center.y);
    _logoView1.bounds              = CGRectMake(0,0,kScreenWidth,kScreenHeight);
    _logoView1.backgroundColor     = [UIColor whiteColor];
    _logoView1.layer.cornerRadius  = 0;
    _logoView1.layer.shadowColor   = [UIColor blackColor].CGColor;
    _logoView1.layer.shadowOffset  = CGSizeMake(0,1);
    _logoView1.layer.shadowOpacity = 0.1f;
    _logoView1.layer.shadowRadius  = 0.1f;
    
    //保证画布位于所有视图层级的最下方
    if (_titleLabel1 != nil) {
        [self insertSubview:_logoView1 belowSubview:_titleLabel1];
    }
    else
        [self addSubview:_logoView1];
}

@end
