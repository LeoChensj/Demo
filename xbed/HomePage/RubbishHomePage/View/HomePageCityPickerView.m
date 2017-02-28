//
//  HomePageCityPickerView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageCityPickerView.h"

#define HomePageCityPickerViewContentHeight 0.4*MAIN_SCREEN_HEIGHT

@implementation HomePageCityPickerView

- (instancetype)initWithCity:(NSString *)city dataArray:(NSArray <NSString *>*)dataArray
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.city = city;
        self.dataArray = dataArray;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        _vCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-HomePageCityPickerViewContentHeight)];
        _vCancel.backgroundColor = [UIColor clearColor];
        [self addSubview:_vCancel];
        
        WS(ws);
        [[_vCancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close];
            
        }];
        
        
        _vContent = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, HomePageCityPickerViewContentHeight)];
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, HomePageCityPickerViewContentHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [_vContent addSubview:_pickerView];
        
        
        _btnConfirm = [[UIButton alloc] init];
        _btnConfirm.backgroundColor = Blue_Color;
        _btnConfirm.layer.masksToBounds = YES;
        _btnConfirm.layer.cornerRadius = 2;
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = Font(12);
        [_vContent addSubview:_btnConfirm];
        [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
        }];
        [[_btnConfirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close];
            
            if(ws.block)
            {
                NSInteger row = [ws.pickerView selectedRowInComponent:0];
                ws.block(ws.dataArray[row]);
            }
            
        }];
        
        
        
        
        [self indexHandle];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT-HomePageCityPickerViewContentHeight);
            
        } completion:^(BOOL finished) {
            
            [_pickerView selectRow:_index inComponent:0 animated:YES];
            
        }];
        
        
    }
    
    return self;
}

- (void)addHomePageCityPickerViewSelectedBlock:(HomePageCityPickerViewSelectedBlock)block
{
    self.block = block;
}




#pragma mark - UIPickerViewDelegate UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArray.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = Blue_Color;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont fontWithName:GlobalFontName size:15];
    }
    
    pickerLabel.text = _dataArray[row];
    
    return pickerLabel;
}









#pragma mark - Help
- (void)indexHandle
{
    for (NSInteger i=0;i<_dataArray.count;i++)
    {
        if([_city isEqualToString:_dataArray[i]])
        {
            _index = i;
            break;
        }
    }
}

- (void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

@end
