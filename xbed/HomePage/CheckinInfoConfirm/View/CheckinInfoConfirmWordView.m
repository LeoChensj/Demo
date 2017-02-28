//
//  CheckinInfoConfirmWordView.m
//  xbed
//
//  Created by Leo.Chen on 2017/2/15.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmWordView.h"

@implementation CheckinInfoConfirmWordView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbIsWord = [[UILabel alloc] init];
        _lbIsWord.text = @"是否生成口令";
        _lbIsWord.textColor = Main_Text_Color;
        _lbIsWord.font = Font(13);
        [self addSubview:_lbIsWord];
        [_lbIsWord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(79);
            make.height.mas_equalTo(19);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(16);
            
        }];
        
        _btnIsWord = [[UIButton alloc] init];
        [_btnIsWord setImage:[UIImage imageNamed:@"ic_word_why"] forState:UIControlStateNormal];
        [self addSubview:_btnIsWord];
        [_btnIsWord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(18);
            make.left.mas_equalTo(_lbIsWord.mas_right).mas_equalTo(20);
            make.centerY.mas_equalTo(_lbIsWord.mas_centerY).offset(0);
            
        }];
        
        _swtIsWord = [[UISwitch alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-62, 10, 0, 0)];
        _swtIsWord.onTintColor = Blue_Color;
        [self addSubview:_swtIsWord];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(49);
            
        }];
        
        
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = [UIColor whiteColor];
        _vContent.clipsToBounds = YES;
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        _cellWord = [[InputTableCell alloc] init];
        _cellWord.title = @"口令：";
        _cellWord.placeholder = @"6-20位数字或英文";
        _cellWord.haveLine = YES;
        _cellWord.tfValue.limitLength = 20;
        [_vContent addSubview:_cellWord];
        [_cellWord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _cellName = [[InputTableCell alloc] init];
        _cellName.title = @"姓名：";
        _cellName.placeholder = @"姓名与手机号码必填一项";
        _cellName.haveLine = YES;
        _cellName.tfValue.limitLength = 20;
        [_vContent addSubview:_cellName];
        [_cellName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellWord.mas_bottom).offset(0);
            
        }];
        
        _cellPhone = [[InputTableCell alloc] init];
        _cellPhone.title = @"手机号码：";
        _cellPhone.haveLine = NO;
        _cellPhone.tfValue.limitLength = 11;
        [_vContent addSubview:_cellPhone];
        [_cellPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellName.mas_bottom).offset(0);
            
        }];
        
        
        RAC(self, word) = _cellWord.tfValue.rac_textSignal;
        RAC(self, name) = _cellName.tfValue.rac_textSignal;
        RAC(self, phone) = _cellPhone.tfValue.rac_textSignal;
        
        
        
        
        [_swtIsWord addTarget:self action:@selector(isCreateWordFunc:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}




- (void)isCreateWordFunc:(UISwitch *)button
{
    self.isWord = button.on;
    
    if(button.on)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(49*4);
                
            }];
            [self.superview layoutIfNeeded];
            
        }];
        
        
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(49);
                
            }];
            [self.superview layoutIfNeeded];
            
        }];
        
    }
}

@end
