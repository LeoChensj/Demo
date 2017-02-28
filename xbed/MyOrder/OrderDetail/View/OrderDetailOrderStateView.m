//
//  OrderDetailOrderStateView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailOrderStateView.h"

@implementation OrderDetailOrderStateView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        _lbState = [[UILabel alloc] init];
        _lbState.font = Font(28);
        [self addSubview:_lbState];
        [_lbState mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            
        }];
        
        
        _imgv1 = [[UIImageView alloc] init];
        _imgv1.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        [self addSubview:_imgv1];
        [_imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(17);
            make.centerY.mas_equalTo(_lbState.mas_bottom).offset(43);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/3);
            
        }];
        
        _imgv2 = [[UIImageView alloc] init];
        _imgv2.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        [self addSubview:_imgv2];
        [_imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(17);
            make.centerY.mas_equalTo(_lbState.mas_bottom).offset(43);
            make.centerX.mas_equalTo(0);
            
        }];
        
        _imgv3 = [[UIImageView alloc] init];
        _imgv3.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        [self addSubview:_imgv3];
        [_imgv3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(17);
            make.centerY.mas_equalTo(_lbState.mas_bottom).offset(43);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/3);
            
        }];
        
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = Seg_Line_Color;
        [self addSubview:_line1];
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //make.width.mas_equalTo();
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(_imgv1.mas_right).offset(0);
            make.right.mas_equalTo(_imgv2.mas_left).offset(0);
            make.centerY.mas_equalTo(_imgv1.mas_centerY).offset(0);
            
        }];
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = Seg_Line_Color;
        [self addSubview:_line2];
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(_imgv2.mas_right).offset(0);
            make.right.mas_equalTo(_imgv3.mas_left).offset(0);
            make.centerY.mas_equalTo(_imgv2.mas_centerY).offset(0);
            
        }];
        
        
        
        _lbValue1 = [[UILabel alloc] init];
        _lbValue1.text = @"支付成功";
        _lbValue1.textColor = Secondary_Text_Color;
        _lbValue1.textAlignment = NSTextAlignmentCenter;
        _lbValue1.font = Font(12);
        [self addSubview:_lbValue1];
        [_lbValue1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(_imgv1.mas_bottom).offset(15);
            make.centerX.mas_equalTo(_imgv1.mas_centerX).offset(0);
            
        }];
        
        _lbValue2 = [[UILabel alloc] init];
        _lbValue2.text = @"办理入住";
        _lbValue2.textColor = Secondary_Text_Color;
        _lbValue2.textAlignment = NSTextAlignmentCenter;
        _lbValue2.font = Font(12);
        [self addSubview:_lbValue2];
        [_lbValue2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(_imgv2.mas_bottom).offset(15);
            make.centerX.mas_equalTo(_imgv2.mas_centerX).offset(0);
            
        }];
        
        _lbValue3 = [[UILabel alloc] init];
        _lbValue3.text = @"办理退房";
        _lbValue3.textColor = Secondary_Text_Color;
        _lbValue3.textAlignment = NSTextAlignmentCenter;
        _lbValue3.font = Font(12);
        [self addSubview:_lbValue3];
        [_lbValue3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(_imgv3.mas_bottom).offset(15);
            make.centerX.mas_equalTo(_imgv3.mas_centerX).offset(0);
            
        }];
        
    }
    
    return self;
}


- (void)setOrderType:(NSNumber *)orderType
{
    _orderType = orderType;
    
    NSInteger value = orderType.integerValue;
    if(value==0)
    {
        self.hidden = NO;
        
        _lbState.text = @"已取消";
        _lbState.textColor = Secondary_Text_Color2;
        
        _imgv1.hidden = YES;
        _imgv2.hidden = YES;
        _imgv3.hidden = YES;
        _line1.hidden = YES;
        _line2.hidden = YES;
        _lbValue1.hidden = YES;
        _lbValue2.hidden = YES;
        _lbValue3.hidden = YES;
        
        _myHeight = 60;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
        
    }
    else if(value==1)
    {
        self.hidden = NO;
        
        _lbState.text = @"待支付";
        _lbState.textColor = Blue_Color;
        
        _imgv1.hidden = YES;
        _imgv2.hidden = YES;
        _imgv3.hidden = YES;
        _line1.hidden = YES;
        _line2.hidden = YES;
        _lbValue1.hidden = YES;
        _lbValue2.hidden = YES;
        _lbValue3.hidden = YES;
        
        _myHeight = 60;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
    else if(value==2 || value==3 || value==4 || value==5 || value==6)
    {
        self.hidden = NO;
        
        _lbState.text = @"已支付";
        _lbState.textColor = Blue_Color;
        
        _imgv1.hidden = NO;
        _imgv2.hidden = NO;
        _imgv3.hidden = NO;
        _line1.hidden = NO;
        _line2.hidden = NO;
        _lbValue1.hidden = NO;
        _lbValue2.hidden = NO;
        _lbValue3.hidden = NO;
        
        _imgv1.image = [UIImage imageNamed:@"ic_progress_dot_done"];
        _imgv2.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        _imgv3.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        _line1.backgroundColor = Seg_Line_Color;
        _line2.backgroundColor = Seg_Line_Color;
        _lbValue1.textColor = Blue_Color;
        _lbValue2.textColor = Secondary_Text_Color;
        _lbValue3.textColor = Secondary_Text_Color;
        
        _myHeight = 160;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
    else if(value==7)
    {
        self.hidden = NO;
        
        _lbState.text = @"已入住";
        _lbState.textColor = Blue_Color;
        
        _imgv1.hidden = NO;
        _imgv2.hidden = NO;
        _imgv3.hidden = NO;
        _line1.hidden = NO;
        _line2.hidden = NO;
        _lbValue1.hidden = NO;
        _lbValue2.hidden = NO;
        _lbValue3.hidden = NO;
        
        _imgv1.image = [UIImage imageNamed:@"ic_progress_dot_done"];
        _imgv2.image = [UIImage imageNamed:@"ic_progress_dot_done"];
        _imgv3.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        _line1.backgroundColor = Blue_Color;
        _line2.backgroundColor = Seg_Line_Color;
        _lbValue1.textColor = Blue_Color;
        _lbValue2.textColor = Blue_Color;
        _lbValue3.textColor = Secondary_Text_Color;
        
        _myHeight = 160;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
    else if(value==-1)
    {
        self.hidden = NO;
        
        _lbState.text = @"暂无法入住，请联系客服";
        _lbState.textColor = Secondary_Text_Color2;
        
        _imgv1.hidden = YES;
        _imgv2.hidden = YES;
        _imgv3.hidden = YES;
        _line1.hidden = YES;
        _line2.hidden = YES;
        _lbValue1.hidden = YES;
        _lbValue2.hidden = YES;
        _lbValue3.hidden = YES;
        
        _myHeight = 60;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
    else
    {
        self.hidden = YES;
        
        _myHeight = 0;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
}

@end
