//
//  ScreenSortView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenSortView.h"

@implementation ScreenSortView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        _vBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 64+49, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49)];
        _vBlack.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:_vBlack];
        
        _vContent = [[UIView alloc] initWithFrame:CGRectMake(0, 64+49, MAIN_SCREEN_WIDTH, 0)];
        _vContent.clipsToBounds = YES;
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        _vCancel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 64+49)];
        _vCancel.backgroundColor = [UIColor clearColor];
        [self addSubview:_vCancel];
        
        
        [_vBlack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
        [_vCancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
        
        
        _cells = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)setViewModel:(ScreenRoomViewModel *)viewModel
{
    _viewModel = viewModel;
    
    for (NSInteger i=0;i<viewModel.sortTags.count;i++)
    {
        ScreenSortCell *cell = [[ScreenSortCell alloc] initWithFrame:CGRectMake(0, 44*i, MAIN_SCREEN_WIDTH, 44)];
        cell.model = viewModel.sortTags[i];
        [_vContent addSubview:cell];
        
        WS(ws);
        [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(ScreenSortCell *x) {
            
            ws.selectSort = x.model;
            //ws.viewModel.sort = x.model;
            [ws close];
            
        }];
        
        [_cells addObject:cell];
    }
    
    
    _selectSort = viewModel.sort;
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if([_cells[i].model.code isEqual:_selectSort.code])
        {
            _cells[i].states = 1;
        }
        else if(_cells[i].model.code==nil && _selectSort.code==nil)//默认排序
        {
            _cells[i].states = 1;
        }
        else
        {
            _cells[i].states = 0;
        }
    }
    
    [self show];
}

- (void)setSelectSort:(ScreenRoomTagModel *)selectSort
{
    _selectSort = selectSort;
    
    self.viewModel.sort = selectSort;
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if([_cells[i].model.code isEqual:selectSort.code])
        {
            _cells[i].states = 1;
        }
        else if(_cells[i].model.code==nil && selectSort.code==nil)//默认排序
        {
            _cells[i].states = 1;
        }
        else
        {
            _cells[i].states = 0;
        }
    }
}


- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.size = CGSizeMake(MAIN_SCREEN_WIDTH, 44*_viewModel.sortTags.count);
        
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.size = CGSizeMake(MAIN_SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}



@end
