//
//  HomePageSelectView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageSelectView.h"

@implementation HomePageSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        _rentSelectView = [[HomePageRentSelectView alloc] init];
        [self addSubview:_rentSelectView];
        [_rentSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(52);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _citySelectView = [[HomePageCitySelectView alloc] init];
        [self addSubview:_citySelectView];
        [_citySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(54);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_rentSelectView.mas_bottom).offset(0);
            
        }];
        
        _dateSelectView = [[HomePageDateSelectView alloc] init];
        [self addSubview:_dateSelectView];
        [_dateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(73);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_citySelectView.mas_bottom).offset(0);
            
        }];
        
        _searchView = [[HomePageSearchView alloc] init];
        [self addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(53);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_dateSelectView.mas_bottom).offset(0);
            
        }];
        
        
        
        
        _btnCheck = [[BlueEnableButton alloc] init];
        _btnCheck.title = @"查询";
        _btnCheck.enabled = YES;
        [self addSubview:_btnCheck];
        [_btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-50);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
            
        }];
        
        
        _lbLongRentRemind = [[UILabel alloc] init];
        _lbLongRentRemind.text = @"说明：长留只能预订一个月以上";
        _lbLongRentRemind.textColor = Blue_Color;
        _lbLongRentRemind.textAlignment = NSTextAlignmentCenter;
        _lbLongRentRemind.font = Font(12);
        [self addSubview:_lbLongRentRemind];
        [_lbLongRentRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(_btnCheck.mas_top).offset(-15);
            
        }];
        _lbLongRentRemind.hidden = YES;
        
        
        
        WS(ws);
        [RACObserve(_rentSelectView, index) subscribeNext:^(NSNumber *x) {
            
            if(x)
            {
                if(x.integerValue==0)//短租
                {
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        [ws.dateSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
                            
                            make.height.mas_equalTo(73);
                            
                        }];
                        [ws.dateSelectView.superview layoutIfNeeded];
                        
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        ws.dateSelectView.hidden = NO;
                        ws.lbLongRentRemind.hidden = YES;
                        
                    });
                }
                else if(x.integerValue==1)//长租
                {
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        [ws.dateSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
                            
                            make.height.mas_equalTo(0);
                            
                        }];
                        [ws.dateSelectView.superview layoutIfNeeded];
                        
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        ws.dateSelectView.hidden = YES;
                        ws.lbLongRentRemind.hidden = NO;
                        
                    });
                }
                
                
                ws.rentType = x.integerValue;
            }
            
        }];
        
        
    }
    
    return self;
}





- (void)setCity:(NSString *)city
{
    _city = city;
    
    _citySelectView.city = city;
}
- (void)setToday:(NSDate *)today
{
    _today = today;
    
    _dateSelectView.today = today;
}
- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    _dateSelectView.checkinDate = checkinDate;
}
- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    _checkoutDate = checkoutDate;
    
    _dateSelectView.checkoutDate = checkoutDate;
}
- (void)setSearchModel:(SearchModel *)searchModel
{
    _searchModel = searchModel;
    
    _searchView.model = searchModel;
}






@end
