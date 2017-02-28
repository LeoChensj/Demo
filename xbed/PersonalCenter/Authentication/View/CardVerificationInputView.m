//
//  CardVerificationInputView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationInputView.h"

@implementation CardVerificationInputView

- (instancetype)init
{
    if(self= [super init])
    {
        _cellName = [[InputTableCell alloc] init];
        _cellName.title = @"真实姓名";
        _cellName.placeholder = @"请填写身份证上的姓名";
        _cellName.haveLine = YES;
        [self addSubview:_cellName];
        [_cellName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _cellCardId = [[InputTableCell alloc] init];
        _cellCardId.title = @"身份证号";
        _cellCardId.haveLine = YES;
        [self addSubview:_cellCardId];
        [_cellCardId mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellName.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}

- (void)setCheckinPerson:(QueryCheckinPersonDataModel *)checkinPerson
{
    _checkinPerson = checkinPerson;
    
    _cellName.value = checkinPerson.name;
    _cellCardId.value = checkinPerson.idNo;
}

@end
