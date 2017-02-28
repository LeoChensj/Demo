//
//  AuthenticationFaceCardView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AuthenticationFaceCardView.h"

@implementation AuthenticationFaceCardView

- (instancetype)init
{
    if(self = [super init])
    {
        _cellFace = [[NormalTableCell alloc] init];
        _cellFace.title = @"人脸识别验证";
        _cellFace.haveLine = YES;
        [self addSubview:_cellFace];
        [_cellFace mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _cellCard = [[NormalTableCell alloc] init];
        _cellCard.title = @"身份证验证";
        _cellCard.haveLine = NO;
        [self addSubview:_cellCard];
        [_cellCard mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellFace.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}

- (void)setLoginModel:(LoginModel *)loginModel
{
    _loginModel = loginModel;
    
    if(loginModel.faceRecognition.boolValue)
    {
        _cellFace.value = @"已验证";
        _cellFace.valueColor = Main_Text_Color;
    }
    else
    {
        _cellFace.value = @"未验证";
        _cellFace.valueColor = Red_Color;
    }
    
    
    if(loginModel.state.integerValue==1)
    {
        _cellCard.value = @"待审核";
        _cellCard.valueColor = Red_Color;
    }
    else if(loginModel.state.integerValue==2)
    {
        _cellCard.value = @"已验证";
        _cellCard.valueColor = Main_Text_Color;
    }
    else if(loginModel.state.integerValue==3)
    {
        _cellCard.value = @"验证未通过";
        _cellCard.valueColor = Red_Color;
    }
    else
    {
        _cellCard.value = @"未验证";
        _cellCard.valueColor = Red_Color;
    }

}

@end
