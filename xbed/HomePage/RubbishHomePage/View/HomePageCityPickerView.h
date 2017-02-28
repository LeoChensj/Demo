//
//  HomePageCityPickerView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomePageCityPickerViewSelectedBlock)(NSString *city);

@interface HomePageCityPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
@private
    UIButton *_vCancel;
    UIView *_vContent;
    UIButton *_btnConfirm;
    
    NSInteger _index;
}

@property (nonatomic, strong, readonly)UIPickerView *pickerView;
@property (nonatomic, strong)NSArray <NSString *>*dataArray;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)HomePageCityPickerViewSelectedBlock block;


- (instancetype)initWithCity:(NSString *)city dataArray:(NSArray <NSString *>*)dataArray;
- (void)addHomePageCityPickerViewSelectedBlock:(HomePageCityPickerViewSelectedBlock)block;

@end
