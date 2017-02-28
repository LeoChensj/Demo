//
//  CleanTimeSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanTimeSelectView.h"

@implementation CleanTimeSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        UILabel *lbDate = [[UILabel alloc] init];
        lbDate.text = @"日期选择";
        lbDate.textColor = Main_Text_Color;
        lbDate.font = FontBold(14);
        [self addSubview:lbDate];
        [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            
        }];
        
        UIView *dateBackView = [[UIView alloc] init];
        dateBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:dateBackView];
        [dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(lbDate.mas_bottom).offset(15);
            
        }];
        
        
        _cellToday = [[CleanTimeSelectCell alloc] init];
        _cellToday.title = @"今天";
        _cellToday.states = 2;
        [dateBackView addSubview:_cellToday];
        [_cellToday mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        WS(ws);
        [_cellToday addCleanTimeSelectCellBlock:^(NSInteger states) {
            
            ws.timeView.dataArray = ws.todayDataArray;
            ws.selectTime = nil;
            
            if(ws.cellTomorrow.states==2)
            {
                ws.cellTomorrow.states = 1;
            }
            
        }];
        
        
        _cellTomorrow = [[CleanTimeSelectCell alloc] init];
        _cellTomorrow.title = @"明天";
        _cellTomorrow.states = 1;
        [dateBackView addSubview:_cellTomorrow];
        [_cellTomorrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(_cellToday.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        [_cellTomorrow addCleanTimeSelectCellBlock:^(NSInteger states) {
            
            ws.timeView.dataArray = ws.tomorrowDataArray;
            ws.selectTime = nil;
            
            if(ws.cellToday.states==2)
            {
                ws.cellToday.states = 1;
            }
            
        }];
        
        
        
        UILabel *lbTime = [[UILabel alloc] init];
        lbTime.text = @"时间选择";
        lbTime.textColor = Main_Text_Color;
        lbTime.font = FontBold(14);
        [self addSubview:lbTime];
        [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(dateBackView.mas_bottom).offset(15);
            
        }];
        
        
        _timeView = [[CleanTimeView alloc] init];
        [self addSubview:_timeView];
        [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(lbTime.mas_bottom).offset(15);
            
        }];
        RAC(self, selectTime) = RACObserve(_timeView, selectModel);
    }
    
    return self;
}



- (void)setTodayDataArray:(NSArray<CheckinCleanTimeItemModel *> *)todayDataArray
{
    _todayDataArray = todayDataArray;
    
    _timeView.dataArray = todayDataArray;
}

@end
