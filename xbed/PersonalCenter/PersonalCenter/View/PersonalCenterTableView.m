//
//  PersonalCenterTableView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PersonalCenterTableView.h"

@implementation PersonalCenterTableView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.alwaysBounceVertical = YES;
        self.contentInset = UIEdgeInsetsMake(10, 0, TABBAR_HEIGHT+10, 0);
        
        _cellIdentity = [[NormalTableCell alloc] init];
        _cellIdentity.title = @"身份验证";
        _cellIdentity.titleColor = Red_Color;
        _cellIdentity.haveLine = YES;
        [self addSubview:_cellIdentity];
        [_cellIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _cellInvoice = [[NormalTableCell alloc] init];
        _cellInvoice.title = @"发票";
        _cellInvoice.haveLine = NO;
        [self addSubview:_cellInvoice];
        [_cellInvoice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellIdentity.mas_bottom).offset(0);
            
        }];
        
        
        _cellProblem = [[NormalTableCell alloc] init];
        _cellProblem.title = @"常见问题";
        _cellProblem.haveLine = YES;
        [self addSubview:_cellProblem];
        [_cellProblem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellInvoice.mas_bottom).offset(10);
            
        }];
        
        _cellOpinion = [[NormalTableCell alloc] init];
        _cellOpinion.title = @"意见反馈";
        _cellOpinion.haveLine = YES;
        [self addSubview:_cellOpinion];
        [_cellOpinion mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellProblem.mas_bottom).offset(0);
            
        }];
        
        
        _cellPhone = [[NormalTableCell alloc] init];
        _cellPhone.title = @"客服电话";
        _cellPhone.value = [DBManager getInstance].appUITextData.serviceTelephone;
        _cellPhone.valueColor = Blue_Color;
        _cellPhone.haveArrow = NO;
        _cellPhone.haveLine = NO;
        [self addSubview:_cellPhone];
        [_cellPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellOpinion.mas_bottom).offset(0);
            
        }];
        
        
        
    }
    
    return self;
}

- (void)setLoginModel:(LoginModel *)loginModel
{
    _loginModel = loginModel;
    
    if(loginModel.isIdentity.boolValue)
    {
        _cellIdentity.titleColor = Main_Text_Color;
    }
    else
    {
        _cellIdentity.titleColor = Red_Color;
    }
}

@end
