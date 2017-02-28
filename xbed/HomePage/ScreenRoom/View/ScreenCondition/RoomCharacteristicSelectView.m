//
//  RoomCharacteristicSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  

#import "RoomCharacteristicSelectView.h"

@implementation RoomCharacteristicSelectView

@synthesize selectRoomCharacteristics = _selectRoomCharacteristics;

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"特色";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            
        }];
        
        
        _cells = [NSMutableArray array];
    }
    
    return self;
}

- (void)setRoomCharacteristics:(NSArray<ScreenRoomTagModel *> *)RoomCharacteristics
{
    _RoomCharacteristics = RoomCharacteristics;
    
    for (NSInteger i=0;i<RoomCharacteristics.count;i++)
    {
        NSInteger row = i/3;    //第几行
        NSInteger column = i%3; //第几列
        
        RoomCharacteristicCell *cell = [[RoomCharacteristicCell alloc] init];
        cell.model = RoomCharacteristics[i];
        cell.states = 0;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(110*XSCALE);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo((column-1)*120*XSCALE);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20+row*(34+15));
            
        }];
        [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(RoomTypeCell *x) {
            
            x.states = (x.states+1)%2;
            
        }];
        
        [_cells addObject:cell];
    }
    
    
    NSInteger allRow = RoomCharacteristics.count/3+(RoomCharacteristics.count%3 ? 1 : 0);   //总的行数
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(14+20+allRow*(34+15)+10);
        
    }];
}

- (void)setSelectRoomCharacteristics:(NSArray<NSString *> *)selectRoomCharacteristics
{
    _selectRoomCharacteristics = selectRoomCharacteristics;
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        BOOL flag = NO;
        for (NSInteger j=0;j<selectRoomCharacteristics.count;j++)
        {
            if([_cells[i].model.code isEqual:selectRoomCharacteristics[j]])
            {
                _cells[i].states = 1;
                flag = YES;
                break;
            }
        }
        
        if(flag==NO)
        {
            _cells[i].states = 0;
        }
    }
}

- (NSArray<NSString *> *)selectRoomCharacteristics
{
    NSMutableArray <NSString *>*mArray = [NSMutableArray array];
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if(_cells[i].states==1)
        {
            [mArray addObject:_cells[i].model.code];
        }
    }
    
    _selectRoomCharacteristics = mArray;
    
    return _selectRoomCharacteristics;
}



- (void)reset
{
    self.selectRoomCharacteristics = nil;
}

@end
