//
//  CleanTimeView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanTimeView.h"

@implementation CleanTimeView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _cells = [NSMutableArray array];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<CheckinCleanTimeItemModel *> *)dataArray
{
    _dataArray = dataArray;
    
    for (CleanTimeSelectCell *cell in _cells)
    {
        [cell removeFromSuperview];
    }
    [_cells removeAllObjects];
    
    CGFloat cellWidth = (MAIN_SCREEN_WIDTH-30-20)/3;
    
    for (NSInteger i=0;i<dataArray.count;i++)
    {
        NSInteger row = i/3;    //第几行
        NSInteger column = i%3; //第几列
        
        CleanTimeSelectCell *cell = [[CleanTimeSelectCell alloc] init];
        cell.tag = i+88;
        cell.title = dataArray[i].time;
        cell.states = dataArray[i].state.integerValue;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(cellWidth);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(15+column*(cellWidth+10));
            make.top.mas_equalTo(15+row*(34+15));
            
        }];
        
        WS(ws);
        [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(CleanTimeSelectCell *x) {
            
            NSInteger index = x.tag-88;
            
            for (NSInteger i=0;i<ws.cells.count;i++)
            {
                ws.selectModel = ws.dataArray[index];
                
                if(i!=index)
                {
                    if(ws.cells[i].states==2)
                    {
                        ws.cells[i].states = 1;
                    }
                }
            }
            
        }];
        
        
        [_cells addObject:cell];
    }
    
    
    
    NSInteger allRow = dataArray.count/3+(dataArray.count%3 ? 1 : 0);   //总的行数
    CGFloat height = 0;
    if(allRow)
    {
        height = 30+allRow*34+(allRow-1)*15;
    }
    else
    {
        height = 0;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(height);
        
    }];
}

@end
