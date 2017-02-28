//
//  AreaPickerView.m
//  xbed
//
//  Created by Leo.Chen on 16/4/22.
//  Copyright © 2016年 liujialin125. All rights reserved.
//

#import "AreaPickerView.h"

#define AreaPickerViewHeight 0.4*MAIN_SCREEN_HEIGHT

@implementation AreaPickerView

- (id)initWithProvinceId:(NSNumber *)provinceId cityId:(NSNumber *)cityId countyId:(NSNumber *)countyId
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        [self getAreaData];
        
        [self AreaIndexHandleWithProvinceId:provinceId cityId:cityId countyId:countyId];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        [self addSubview:_backView];
        
        
        UIView *tapClearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-AreaPickerViewHeight)];
        tapClearView.backgroundColor = [UIColor clearColor];
        [_backView addSubview:tapClearView];
        
        UITapGestureRecognizer *tapMe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAreaView)];
        [tapClearView addGestureRecognizer:tapMe];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT-AreaPickerViewHeight, MAIN_SCREEN_WIDTH, AreaPickerViewHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [_backView addSubview:_pickerView];
        
        UIButton *btnAreaComplete = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-70, MAIN_SCREEN_HEIGHT-AreaPickerViewHeight+10, 60, 30)];
        btnAreaComplete.backgroundColor = Blue_Color;
        btnAreaComplete.titleLabel.font = Font(12);
        btnAreaComplete.layer.cornerRadius = 2;
        [btnAreaComplete setTitle:@"确定" forState:UIControlStateNormal];
        [btnAreaComplete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backView addSubview:btnAreaComplete];
        [btnAreaComplete addTarget:self action:@selector(btnAreaCompleteFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _backView.origin = CGPointZero;
            
        } completion:^(BOOL finished){
            
            [_pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
            [self pickerView:_pickerView didSelectRow:_provinceIndex inComponent:0];
            
            [_pickerView selectRow:_cityIndex inComponent:1 animated:YES];
            [self pickerView:_pickerView didSelectRow:_cityIndex inComponent:1];
            
            [_pickerView selectRow:_countyIndex inComponent:2 animated:YES];
            [self pickerView:_pickerView didSelectRow:_countyIndex inComponent:2];
            
        }];
        
    }
    
    return self;
}

- (void)AreaIndexHandleWithProvinceId:(NSNumber *)provinceId cityId:(NSNumber *)cityId countyId:(NSNumber *)countyId
{
    _provinceId = provinceId;
    _cityId = cityId;
    _countyId = countyId;
    
    for(NSInteger i=0;i<_provinceArray.count;i++)
    {
        if([_provinceId isEqual:_provinceArray[i].id])
        {
            _provinceIndex = i;
            _cityArray = _provinceArray[i].childList;
            break;
        }
        
    }
    
    for(NSInteger i=0;i<_cityArray.count;i++)
    {
        if([_cityId isEqual:_cityArray[i].id])
        {
            _cityIndex = i;
            _countyArray = _cityArray[i].childList;
            break;
        }
    }
    
    for(NSInteger i=0;i<_countyArray.count;i++)
    {
        if([_countyId isEqual:_countyArray[i].id])
        {
            _countyIndex = i;
            break;
        }
    }
    
}

- (void)getAreaData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AllArea" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *tempAreaDict = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    NSDictionary *allAreaDict = [NSDictionary dictionaryWithObject:tempAreaDict forKey:@"area"];

    _localAreaModel = [MTLJSONAdapter modelOfClass:[LocalAreaModel class] fromJSONDictionary:allAreaDict error:nil];
    
    //NSLog(@"areaModel=%@", _localAreaModel);
    
    _provinceArray = _localAreaModel.area;
    _cityArray = _localAreaModel.area[0].childList;
    _countyArray = _localAreaModel.area[0].childList[0].childList;
}

#pragma mark - UIPickerViewDelegate UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _provinceArray.count;
    }
    else if (component == 1)
    {
        return _cityArray.count;
    }
    else
    {
        return _countyArray.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = Blue_Color;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont fontWithName:GlobalFontName size:14];
    }
    
    switch (component)
    {
        case 0:
            pickerLabel.text = _provinceArray[row].name;
            break;
        case 1:
            pickerLabel.text = _cityArray[row].name;
            break;
        case 2:
            pickerLabel.text = _countyArray[row].name;
            break;
            
        default:
            break;
    }

    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0)
    {
        if(_provinceArray[row].childList.count>0)
        {
            _cityArray = _provinceArray[row].childList;
        }
        
        if(_cityArray[0].childList.count>0)
        {
            _countyArray = _cityArray[0].childList;
        }
        
        [_pickerView reloadAllComponents];
        
        [_pickerView selectRow:0 inComponent:1 animated:YES];
        [_pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    
    if(component==1)
    {
        if(_cityArray[row].childList.count>0)
        {
            _countyArray = _cityArray[row].childList;
        }
        
        [_pickerView reloadAllComponents];
        
        [_pickerView selectRow:0 inComponent:2 animated:YES];
    }
}


- (void)btnAreaCompleteFunc:(UIButton *)button
{
    if(_listener)
    {
        _provinceIndex = [_pickerView selectedRowInComponent:0];
        if(_provinceArray.count<=_provinceIndex)
        {
            _provinceIndex = 0;
        }
        
        _cityArray = _provinceArray[_provinceIndex].childList;
        _cityIndex = [_pickerView selectedRowInComponent:1];
        if(_cityArray.count<=_cityIndex)
        {
            _cityIndex = 0;
        }
        
        _countyArray = _cityArray[_cityIndex].childList;
        _countyIndex = [_pickerView selectedRowInComponent:2];
        if(_countyArray.count<=_countyIndex)
        {
            _countyIndex = 0;
        }
        
        
        _listener(_provinceArray[_provinceIndex],
                  _cityArray[_cityIndex],
                  _countyArray[_countyIndex]);
    }
    
    [self removeAreaView];
}

- (void)removeAreaView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _backView.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished){
        
        [self removeFromSuperview];
        
    }];
    
}

- (void)addAreaPickerCompleteListener:(AreaPickerComplete)listener
{
    _listener = listener;
}


@end
