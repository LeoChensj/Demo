//
//  OrderListHeaderView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListHeaderView.h"

@implementation OrderListHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        _vWhite = [[UIView alloc] init];
        _vWhite.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_vWhite];
        [_vWhite mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [_vWhite addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-90);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);

        }];


        _lbState = [[UILabel alloc] init];
        _lbState.textColor = Red_Color;
        _lbState.textAlignment = NSTextAlignmentRight;
        _lbState.font = Font(14);
        [_vWhite addSubview:_lbState];
        [_lbState mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}

- (void)setState:(NSNumber *)state
{
    _state = state;
    
    if(state)
    {
        if(state.integerValue==0)
        {
            _lbState.text = @"已取消";
        }
        else if(state.integerValue==1)
        {
            _lbState.text = @"待支付";
        }
        else if(state.integerValue==2 || state.integerValue==3 || state.integerValue==4 || state.integerValue==5 || state.integerValue==6)
        {
            _lbState.text = @"待入住";
        }
        else if(state.integerValue==7)
        {
            _lbState.text = @"已入住";
        }
        else if(state.integerValue==8)
        {
            _lbState.text = @"待评价";
        }
        else if(state.integerValue==9)
        {
            _lbState.text = @"已评价";
        }
        else if(state.integerValue==10)
        {
            _lbState.text = @"评价过期";
        }
        else if(state.integerValue==-1)
        {
            _lbState.text = @"状态异常";
        }
    }
}




@end
