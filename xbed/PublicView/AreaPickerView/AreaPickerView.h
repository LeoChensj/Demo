//
//  AreaPickerView.h
//  xbed
//
//  Created by Leo.Chen on 16/4/22.
//  Copyright © 2016年 liujialin125. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalAreaModel.h"

typedef void(^AreaPickerComplete)(LocalProvinceModel *province, LocalCityModel *city, LocalCountyModel *county);

@interface AreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
{
@private
    UIView *_backView;
    UIPickerView *_pickerView;
    
    NSArray <LocalProvinceModel *>*_provinceArray;
    NSArray <LocalCityModel *>*_cityArray;
    NSArray <LocalCountyModel *>*_countyArray;
    
    NSNumber *_provinceId;
    NSNumber *_cityId;
    NSNumber *_countyId;
    
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _countyIndex;
    
    LocalAreaModel *_localAreaModel;
    
    AreaPickerComplete _listener;
}

- (id)initWithProvinceId:(NSNumber *)provinceId cityId:(NSNumber *)cityId countyId:(NSNumber *)countyId;
- (void)addAreaPickerCompleteListener:(AreaPickerComplete)listener;

@end
