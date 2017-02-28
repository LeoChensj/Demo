//
//  GuiderView.m
//  idface_kexin
//
//  Created by macbook on 15/9/10.
//  Copyright (c) 2015年 idface. All rights reserved.
//

#import "DialogView.h"
#import "FaceRecognitionHeader.h"

@interface DialogView ()
{
    UIView * _logoView;//画布
    UILabel * _titleLabel;//标题
    UILabel * _detailLabel;//内容
    CAShapeLayer * _pathLayer;//尝试保护内存
    UIImageView  *_rightorwring1;
    UIImageView  *_rightorwring2;
    UIImageView  *_bg;  //背景
    MyButton *yanzheng;
    UIImageView  *_daoghao;
   }
@end
@implementation DialogView

//单例
+ (instancetype)shared
{
    static dispatch_once_t once = 0;
    static DialogView *alert;
    dispatch_once(&once, ^{
        alert = [[DialogView alloc] init];
    });
    return alert;
}
+ (instancetype)title:(NSString *)title  title2:(NSString *)title2  callBlock:(callBack)callBack

{
    //[[self shared] addButtonTitleWithCancle:canle OK:ok];
    [[self shared] addTitle:title title2:title2];
    [[self shared] setClickBlock:nil];//释放掉之前的Block
    [[self shared] setClickBlock:callBack];
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

- (void)addTitle:(NSString *)title title2:(NSString *)detail
{
    
    _detailLabel.text = detail;

    _titleLabel.text  = title;
    _detailLabel.text = detail;
    if ([title isEqualToString:@"检测成功!"]) {
        _rightorwring1.hidden=NO;
        _rightorwring2.hidden=YES;
        [_daoghao setImage:[UIImage imageNamed:@"nav_sucess.png"]];
 
    }
    if ([title isEqualToString:@"检测失败!"]) {
        _rightorwring2.hidden=NO;
        _rightorwring1.hidden=YES;
        [_daoghao setImage:[UIImage imageNamed:@"nav_error.png"]];
    }

    

}



/**
 *
 *
 *  界面初始化
 */
- (void)setInterFace
{
    [self logoInit];
    [self controlsInit];
}
/**
 *  @Author wang kun
 *
 *  初始化控件
 */
- (void)controlsInit
{
    
    if(IS_IPHONE_6P||IS_IPHONE_6){
        _daoghao=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.7*0.214,kScreenHeight*0.5-kScreenWidth*0.7*0.5-4, kScreenWidth*0.7,88)];
        
    }else{
        _daoghao=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.7*0.214,kScreenHeight*0.5-kScreenWidth*0.7*0.5, kScreenWidth*0.7,79)];
    }
    
    
    [_logoView addSubview:_daoghao];
    
    if(IS_IPHONE_6P){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.49,kScreenHeight*0.5-kScreenWidth*0.7*0.5+30,130,18)];
        
    }
    
    else  if(IS_IPHONE_5||IS_IPHONE_4_OR_LESS){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.43,kScreenHeight*0.5-kScreenWidth*0.7*0.5+29,130,18)];
        
    }
    else {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.45,kScreenHeight*0.5-kScreenWidth*0.7*0.5+29,130,18)];
        
    }
    
    
    _titleLabel.textColor = [UIColor whiteColor];//其中textColor要用UIColor类型
    //_titleLabel2.text=@"人脸验证";
    [_titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    
    
    if (IS_IPHONE_6P) {
        _rightorwring1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+133,50,50)];
    }
    
    else if (IS_IPHONE_4_OR_LESS) {
        _rightorwring1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+87,50,50)];
    }
    
    else if (IS_IPHONE_6) {
        _rightorwring1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+125,45,45)];
    }
    else{
        _rightorwring1=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+115,45,45)];
    }
    
    [_rightorwring1 setImage:[UIImage imageNamed:@"right.png"]];
    [self addSubview:_rightorwring1];
    _rightorwring1.hidden=YES;
    
    if (IS_IPHONE_6P) {
        _rightorwring2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+133,50,50)];
    }
    
    else if (IS_IPHONE_4_OR_LESS) {
        _rightorwring2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+87,50,50)];
    }
    
    else if (IS_IPHONE_6) {
        _rightorwring2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+125,45,45)];
    }
    else{
        _rightorwring2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.62,(kScreenHeight*0.5-kScreenHeight*0.6*0.5)+115,45,45)];
    }
    [_rightorwring2 setImage:[UIImage imageNamed:@"wrong.png"]];
    [self addSubview:_rightorwring2];
    _rightorwring2.hidden=YES;
    //   if (KiPhone6Plus||KiPhone6) {
    //    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.5-40*0.5,_rightorwring1.origin.y-15,150,48)];
    //   }else{
    //     _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.5-40*0.5,_rightorwring1.origin.y-15,150,30)];
    //   }
    //    _titleLabel.textColor = [UIColor whiteColor];//其中textColor要用UIColor类型
    //    if(KiPhone6||KiPhone6Plus){
    //        [_titleLabel setFont:[UIFont systemFontOfSize:21]];
    //
    //    }else{
    //     [_titleLabel setFont:[UIFont systemFontOfSize:18]];
    //    }
    //
    //
    //    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    //    [self addSubview:_titleLabel];
    
    
    //    _detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.42,_titleLabel.origin.y+15,135,150)];
    
    if (IS_IPHONE_6P||IS_IPHONE_6) {
        _detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.42,_titleLabel.origin.y+50,148,150)];
        
    }else{
        _detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.42,_titleLabel.origin.y+25,135,150)];
        
    }
    
    
    _detailLabel.textColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:100];//其中textColor要用UIColor类型
    if(KiPhone6||IS_IPHONE_6P){
        [_detailLabel setFont:[UIFont systemFontOfSize:14]];
        
    }else{
        [_detailLabel setFont:[UIFont systemFontOfSize:13]];
    }
    
    _detailLabel.numberOfLines = 0;
    [_detailLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_detailLabel];
    
    
    yanzheng= [MyButton buttonWithType:UIButtonTypeCustom];
    
    yanzheng.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:100];
    CALayer *layer_btn1 = yanzheng.layer;
    layer_btn1.masksToBounds = YES;
    layer_btn1.cornerRadius = 0;
    layer_btn1.borderWidth = 1;
    layer_btn1.borderColor=[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:100].CGColor;
    
    if (IS_IPHONE_6P) {
        
        yanzheng.frame = CGRectMake(kScreenWidth*0.7*0.3,_titleLabel.origin.y+185,kScreenWidth*0.7-45, 40);
    }
    
    else if (KiPhone6) {
        
        yanzheng.frame = CGRectMake(kScreenWidth*0.7*0.3,_titleLabel.origin.y+168,kScreenWidth*0.7-45, 40);
    }else{
        yanzheng.frame = CGRectMake(kScreenWidth*0.7*0.3,_titleLabel.origin.y+131,kScreenWidth*0.7-45, 40);
    }
    
    
        [self addSubview:yanzheng];
    UILabel   *_Label=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.7*0.5-45*0.5-40,13,80,15)];
    _Label.textColor = [UIColor darkTextColor];//其中textColor要用UIColor类型
    [_Label setFont:[UIFont systemFontOfSize:13]];
    _Label.text = @"重新验证";
    
    [_Label setTextAlignment:NSTextAlignmentCenter];
    [yanzheng addSubview:_Label];
    
    [yanzheng addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];


}
- (void)buttonClick:(UIButton *)sender
{
    self.clickBlock(0);
}


/**
 *  @Author wang kun
 *
 *  初始化logo视图——画布
 */

- (void)logoInit
{
    //移除画布
    [_logoView removeFromSuperview];
    _logoView = nil;
    //新建画布
    _logoView                     = [UIView new];
    _logoView.center              = CGPointMake(self.center.x, self.center.y);
   
    _logoView.bounds              = CGRectMake(kScreenWidth*0.5-kScreenWidth*0.7*0.5,kScreenHeight*0.5-kScreenWidth*0.7*0.5,kScreenWidth*0.7,kScreenWidth*0.7);
    //_logoView.backgroundColor     = [UIColor whiteColor];
    _logoView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:100];
    _logoView.layer.cornerRadius  = 10;
    _logoView.layer.shadowColor   = [UIColor blackColor].CGColor;
    _logoView.layer.shadowOffset  = CGSizeMake(0, 5);
    _logoView.layer.shadowOpacity = 0.3f;
    _logoView.layer.shadowRadius  = 10.0f;

    
    //保证画布位于所有视图层级的最下方
    if (_titleLabel!= nil) {
        [self insertSubview:_logoView belowSubview:_titleLabel];
    }
    else
        [self addSubview:_logoView];
}

@end
