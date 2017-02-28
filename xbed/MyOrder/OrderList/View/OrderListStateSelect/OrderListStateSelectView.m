//
//  OrderListStateSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListStateSelectView.h"

#define OrderListStateSelectCellWidth (MAIN_SCREEN_WIDTH-4)/5

@implementation OrderListStateSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _cells = [NSMutableArray arrayWithCapacity:5];
        
        NSArray *titles = @[@"待支付", @"待入住", @"已入住", @"待评价", @"全部订单"];
        
        for(NSInteger i=0;i<5;i++)
        {
            OrderListStateSelectCell *cell = [[OrderListStateSelectCell alloc] init];
            cell.index = i;
            cell.title = titles[i];
            cell.isNew = NO;
            [self addSubview:cell];
            [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(OrderListStateSelectCell *x) {
                
                self.index = [NSNumber numberWithInteger:x.index];
                
            }];
            
            if(i==0)
            {
                [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(OrderListStateSelectCellWidth);
                    make.height.mas_equalTo(45);
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    
                }];
            }
            else
            {
                [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(OrderListStateSelectCellWidth);
                    make.height.mas_equalTo(45);
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(_cells[i-1].mas_right).offset(1);
                    
                }];
            }
            
            [_cells addObject:cell];
            
            
            
            if(i<4)
            {
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = Background_Color;
                [self addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(LINE_WIDTH);
                    make.height.mas_equalTo(20);
                    make.centerY.mas_equalTo(0);
                    make.left.mas_equalTo(_cells[i].mas_right).offset(0);
                    
                }];
            }
            
        }
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Background_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        self.index = @0;
    }
    
    return self;
}


-(void)setIndex:(NSNumber *)index
{
    _index = index;
    
    for(NSInteger i=0;i<_cells.count;i++)
    {
        if(i==index.integerValue)
        {
            _cells[i].states = 1;
        }
        else
        {
            _cells[i].states = 0;
        }
            
    }
}



@end
