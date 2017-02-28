//
//  ActivityCollectionViewCell.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ActivityCollectionViewCell.h"

@implementation ActivityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        
        _vTitle = [[UIView alloc] init];
        _vTitle.backgroundColor = Blue_Color;
        [self addSubview:_vTitle];
        [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(45);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = [UIColor whiteColor];
        _lbTitle.font = FontBold(18);
        [_vTitle addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-70);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _btnRadio = [[LeoRadioButton alloc] init];
        _btnRadio.normalImage = [UIImage imageNamed:@"ic_coupon_uncheck"];
        _btnRadio.selectImage = [UIImage imageNamed:@"ic_coupon_check"];
        [_vTitle addSubview:_btnRadio];
        [_btnRadio mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(20);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = Background_Color;
        view1.layer.masksToBounds = YES;
        view1.layer.cornerRadius = 5;
        [self addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(10);
            make.centerX.mas_equalTo(self.mas_left).offset(0);
            make.centerY.mas_equalTo(_vTitle.mas_bottom).offset(0);
            
        }];
        
        UIView *view2 = [[UIView alloc] init];
        view2.backgroundColor = Background_Color;
        view2.layer.masksToBounds = YES;
        view2.layer.cornerRadius = 5;
        [self addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(10);
            make.centerX.mas_equalTo(self.mas_right).offset(0);
            make.centerY.mas_equalTo(_vTitle.mas_bottom).offset(0);
            
        }];
        
        //画小圆点 波浪线
        CGFloat circle = 4;
        CGFloat interval = 2;
        CGFloat couponWidth = MAIN_SCREEN_WIDTH-20-10;
        
        NSInteger circleNumber = (couponWidth-interval)/(circle+interval);
        interval = (couponWidth-circle*circleNumber)/(circleNumber+1);
        
        for(NSInteger i=0;i<circleNumber;i++)
        {
            UIView *vCircle = [[UIView alloc] init];
            vCircle.backgroundColor = [UIColor whiteColor];
            vCircle.layer.masksToBounds = YES;
            vCircle.layer.cornerRadius = circle/2;
            [self addSubview:vCircle];
            [vCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(circle);
                make.centerY.mas_equalTo(_vTitle.mas_bottom).offset(0);
                make.left.mas_equalTo(5+interval+(circle+interval)*i);
                
            }];
        }
        
        
        
        _lbCondition = [[UILabel alloc] init];
        _lbCondition.textColor = Main_Text_Color;
        _lbCondition.font = Font(13);
        [self addSubview:_lbCondition];
        [_lbCondition mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-40);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_vTitle.mas_bottom).offset(15);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Secondary_Text_Color;
        _lbDesc.numberOfLines = 0;
        _lbDesc.font = Font(13);
        [self addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-40);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_lbCondition.mas_bottom).offset(15);
            
        }];
        
    }
    
    return self;
}



- (void)setActivityModel:(ActivityContentsModel *)activityModel
{
    _activityModel = activityModel;
    
    _lbTitle.text = activityModel.title;
    
    
    NSNumber *discount = [NSNumber numberWithFloat:activityModel.discount.floatValue*0.01];
    _lbCondition.text = [NSString stringWithFormat:@"立减%@元", discount];
    
    
    _lbDesc.text = activityModel.describes;
    _lbDesc.lineSpace = 5;
    CGSize sizeDesc = [_lbDesc labelSize:MAIN_SCREEN_WIDTH-40];
    [_lbDesc mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(sizeDesc.height);
        
    }];
}

@end
