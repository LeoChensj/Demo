//
//  ScreenCitySelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenCitySelectView.h"

@implementation ScreenCitySelectView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        _vBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
        _vBlack.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:_vBlack];
        
        _vContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, 0)];
        _vContent.showsVerticalScrollIndicator = NO;
        _vContent.clipsToBounds = YES;
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        _vCancel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 64)];
        _vCancel.backgroundColor = [UIColor clearColor];
        [self addSubview:_vCancel];
        
        
        [_vBlack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
        [_vCancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
        
        
        _cells = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)addScreenCitySelectViewSelectBlock:(ScreenCitySelectViewSelectBlock)blockSelect closeBlock:(ScreenCitySelectViewCloseBlock)blockClose
{
    _blockSelect = blockSelect;
    _blockClose = blockClose;
}


- (void)setViewModel:(ScreenRoomViewModel *)viewModel
{
    _viewModel = viewModel;
    
    for (NSInteger i=0;i<viewModel.cities.count;i++)
    {
        ScreenCityCell *cell = [[ScreenCityCell alloc] initWithFrame:CGRectMake(0, 44*i, MAIN_SCREEN_WIDTH, 44)];
        cell.city = viewModel.cities[i];
        [_vContent addSubview:cell];
        
        WS(ws);
        [[cell rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(ScreenCityCell *x) {
            
            if(![ws.city isEqualToString:x.city] && ws.blockSelect)
            {
                ws.blockSelect(x.city);
            }
            
            ws.city = x.city;
            
            [ws close];
            
        }];
        
        [_cells addObject:cell];
    }
    
    
    _city = viewModel.city;
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if([_cells[i].city isEqualToString:_city])
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

- (void)setCity:(NSString *)city
{
    _city = city;
    
    self.viewModel.city = city;
    
    for (NSInteger i=0;i<_cells.count;i++)
    {
        if([_cells[i].city isEqualToString:city])
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
    CGFloat showHeight = 44*_viewModel.cities.count;
    if(showHeight>MAIN_SCREEN_HEIGHT-64)
    {
        showHeight = MAIN_SCREEN_HEIGHT-64;
    }
    
    _vContent.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, 44*_viewModel.cities.count);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.size = CGSizeMake(MAIN_SCREEN_WIDTH, showHeight);
        
    }];
}

- (void)close
{
    if(_blockClose)
    {
        _blockClose();
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.size = CGSizeMake(MAIN_SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

@end
