//
//  RoomTypeSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomTypeSelectView.h"

@implementation RoomTypeSelectView

@synthesize selectRoomTypes = _selectRoomTypes;

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"户型";
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

- (void)setRoomTypes:(NSArray<ScreenRoomTagModel *> *)roomTypes
{
    _roomTypes = roomTypes;
    
    for (NSInteger i=0;i<roomTypes.count;i++)
    {
        NSInteger row = i/3;    //第几行
        NSInteger column = i%3; //第几列
        
        RoomTypeCell *cell = [[RoomTypeCell alloc] init];
        cell.model = roomTypes[i];
        cell.states = 0;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo((column-1)*100*XSCALE);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20+row*(34+15));
            
        }];
        [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(RoomTypeCell *x) {
            
            x.states = (x.states+1)%2;
            
        }];
        
        [_cells addObject:cell];
    }
    
    
    NSInteger allRow = roomTypes.count/3+(roomTypes.count%3 ? 1 : 0);   //总的行数
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(14+20+allRow*(34+15)+10);
        
    }];
}

- (void)setSelectRoomTypes:(NSArray<NSString *> *)selectRoomTypes
{
    _selectRoomTypes = selectRoomTypes;
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        BOOL flag = NO;
        for (NSInteger j=0;j<selectRoomTypes.count;j++)
        {
            if([_cells[i].model.code isEqual:selectRoomTypes[j]])
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

- (NSArray<NSString *> *)selectRoomTypes
{
    NSMutableArray <NSString *>*mArray = [NSMutableArray array];
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if(_cells[i].states==1)
        {
            [mArray addObject:_cells[i].model.code];
        }
    }
    
    _selectRoomTypes = mArray;
    
    return _selectRoomTypes;
}



- (void)reset
{
    self.selectRoomTypes = nil;
}



@end
