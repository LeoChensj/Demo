//
//  OrderWordShowView.m
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "OrderWordShowView.h"
#import "StringCheckUtil.h"

@implementation OrderWordShowCell

@synthesize value = _value;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Secondary_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentRight;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_left).offset(80);
            
        }];
        
        _tfValue = [[LeoTextField alloc] init];
        _tfValue.textColor = Main_Text_Color;
        _tfValue.font = Font(14);
        _tfValue.borderStyle = UITextBorderStyleNone;
        _tfValue.returnKeyType = UIReturnKeyDone;
        _tfValue.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_tfValue];
        [_tfValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-30-80-10);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_lbTitle.mas_right).offset(10);
            
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-30-80-10);
            make.height.mas_equalTo(LINE_WIDTH);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(_lbTitle.mas_right).offset(10);
            
        }];
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setValue:(NSString *)value
{
    _value = value;
    
    _tfValue.text = value;
}
- (NSString *)value
{
    _value = _tfValue.text;
    
    return _value;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    _tfValue.placeholder = placeholder;
}

@end

@implementation OrderWordShowView

- (instancetype)initWithType:(NSInteger)type
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = [UIColor whiteColor];
        _vContent.layer.masksToBounds = YES;
        _vContent.layer.cornerRadius = 3;
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(300);
            make.center.mas_equalTo(0);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"订单口令";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = FontBold(18);
        [_vContent addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Main_Text_Color;
        [_vContent addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(1.5);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
            
        }];
        
        _btnClose = [[UIButton alloc] init];
        [_btnClose setImage:[UIImage imageNamed:@"ic_word_close"] forState:UIControlStateNormal];
        [_vContent addSubview:_btnClose];
        [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(24);
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-15);
            
        }];
        
        WS(ws);
        [[_btnClose rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.closeBlock)
            {
                ws.closeBlock();
            }
            
            [ws removeFromSuperview];
            
        }];
        
        
        _cellWord = [[OrderWordShowCell alloc] init];
        _cellWord.title = @"口令：";
        _cellWord.tfValue.limitLength = 20;
        [_vContent addSubview:_cellWord];
        [_cellWord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(line1.mas_bottom).offset(10);
            
        }];
        
        _cellName = [[OrderWordShowCell alloc] init];
        _cellName.title = @"姓名：";
        _cellName.tfValue.limitLength = 20;
        [_vContent addSubview:_cellName];
        [_cellName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_cellWord.mas_bottom).offset(10);
            
        }];
        
        _cellPhone = [[OrderWordShowCell alloc] init];
        _cellPhone.title = @"手机号码：";
        _cellPhone.tfValue.limitLength = 11;
        [_vContent addSubview:_cellPhone];
        [_cellPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_cellName.mas_bottom).offset(10);
            
        }];
        
        
        
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Blue_Color;
        [_vContent addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-49);
            
        }];
        
        
        
        
        _btnConfirm = [[UIButton alloc] init];
        [_btnConfirm setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = Font(16);
        [_vContent addSubview:_btnConfirm];
        [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
    
        RAC(self, word) = _cellWord.tfValue.rac_textSignal;
        RAC(self, name) = _cellName.tfValue.rac_textSignal;
        RAC(self, phone) = _cellPhone.tfValue.rac_textSignal;
        
        
        
        
        
        [[_btnConfirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.type==0)
            {
                if(ws.closeBlock)
                {
                    ws.closeBlock();
                }
                
                [ws removeFromSuperview];
            }
            else if(ws.type==1)
            {
                if(![StringCheckUtil validateWord:ws.word])
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:@"请正确输入口令"];
                }
                else if(ws.name.length==0 && ws.phone.length==0)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:@"姓名和手机号必填一项"];
                }
                else if(ws.phone.length && ![StringCheckUtil validatePhone:ws.phone])
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:@"请正确输入手机号码"];
                }
                else
                {
                    NSLog(@"输入正确");
                    
                    if(ws.confirmBlock)
                    {
                        ws.confirmBlock();
                    }
                    
                    [ws removeFromSuperview];
                }
            }
            
        }];
        
        
        
        self.type = type;
    }
    
    return self;
}

- (void)addOrderWordShowViewConfirmBlock:(OrderWordShowViewBlock)block
{
    self.confirmBlock = block;
}
- (void)addOrderWordShowViewCloseBlock:(OrderWordShowViewBlock)block
{
    self.closeBlock = block;
}


- (void)setType:(NSInteger)type
{
    _type = type;
    
    if(type==0)
    {
        _btnClose.hidden = YES;
        _cellWord.tfValue.textColor = Blue_Color;
        _cellWord.tfValue.enabled = NO;
        _cellWord.placeholder = nil;
        _cellName.tfValue.textColor = Blue_Color;
        _cellName.tfValue.enabled = NO;
        _cellName.placeholder = nil;
        _cellPhone.tfValue.textColor = Blue_Color;
        _cellPhone.tfValue.enabled = NO;
        [_btnConfirm setTitle:@"我知道了" forState:UIControlStateNormal];
    }
    else if(type==1)
    {
        _btnClose.hidden = NO;
        _cellWord.tfValue.textColor = Main_Text_Color;
        _cellWord.tfValue.enabled = YES;
        _cellWord.placeholder = @"6-20位英文或数字";
        _cellName.tfValue.textColor = Main_Text_Color;
        _cellName.tfValue.enabled = YES;
        _cellName.placeholder = @"姓名与手机号必填一项";
        _cellPhone.tfValue.textColor = Main_Text_Color;
        _cellPhone.tfValue.enabled = YES;
        [_btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    }
}

- (void)setWord:(NSString *)word
{
    _word = word;
    
    _cellWord.value = word;
}
- (void)setName:(NSString *)name
{
    _name = name;
    
    _cellName.value = name;
}
- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    
    _cellPhone.value = phone;
}


@end
