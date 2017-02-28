//
//  ScreenConditionBar.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenConditionBar.h"
#import "CalendarView1.h"


@implementation ScreenConditionItem

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Secondary_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(20);
            make.center.mas_equalTo(0);
            
        }];
        
        
        _imgvDown = [[UIImageView alloc] init];
        [self addSubview:_imgvDown];
        [_imgvDown mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(6);
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-10);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setFont:(UIFont *)font
{
    _font = font;
    
    if(font)
    {
        _lbTitle.font = font;
    }
    else
    {
        _lbTitle.font = Font(13);
    }
}
- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==0)
    {
        _lbTitle.textColor = Secondary_Text_Color;
        _imgvDown.image = [UIImage imageNamed:@"ic_drop_symbo"];
    }
    else if(states==1)
    {
        _lbTitle.textColor = Blue_Color;
        _imgvDown.image = [UIImage imageNamed:@"ic_drop_symbo_pressed"];
    }
}


@end



@implementation ScreenConditionBar

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _item1 = [[ScreenConditionItem alloc] init];
        _item1.title = @"日期";
        _item1.states = 0;
        [self addSubview:_item1];
        [_item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _item2 = [[ScreenConditionItem alloc] init];
        _item2.title = @"位置";
        _item2.states = 0;
        [self addSubview:_item2];
        [_item2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(_item1.mas_right).offset(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _item3 = [[ScreenConditionItem alloc] init];
        _item3.title = @"筛选";
        _item3.states = 0;
        [self addSubview:_item3];
        [_item3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(_item2.mas_right).offset(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _item4 = [[ScreenConditionItem alloc] init];
        _item4.title = @"排序";
        _item4.states = 0;
        [self addSubview:_item4];
        [_item4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(_item3.mas_right).offset(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = Seg_Line_Color;
        [self addSubview:_line1];
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(_item1.mas_right).offset(0);
            make.top.mas_equalTo(10);
            
        }];
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = Seg_Line_Color;
        [self addSubview:_line2];
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(_item2.mas_right).offset(0);
            make.top.mas_equalTo(10);
            
        }];
        
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = Seg_Line_Color;
        [self addSubview:_line3];
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(_item3.mas_right).offset(0);
            make.top.mas_equalTo(10);
            
        }];
        
    }
    
    return self;
}


- (void)setViewModel:(ScreenRoomViewModel *)viewModel
{
    _viewModel = viewModel;
    
    
    if(viewModel.rentType==1)//长租  只有3个item
    {
        _item1.hidden = YES;
        _line1.hidden = YES;
        
        [_item2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/3);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        [_item3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/3);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(_item2.mas_right).offset(0);
            make.top.mas_equalTo(0);
            
        }];
        
        [_item4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/3);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(_item3.mas_right).offset(0);
            make.top.mas_equalTo(0);
            
        }];
    }
    
    
    WS(ws);
    if(viewModel.rentType==0)//短租才能选择日期
    {
        //日期...
        [viewModel.signalDate subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                ws.item1.title = [NSString stringWithFormat:@"%02ld/%02ld至%02ld/%02ld", ws.viewModel.checkinDate.month, ws.viewModel.checkinDate.day, ws.viewModel.checkoutDate.month, ws.viewModel.checkoutDate.day];
                ws.item1.font = Font(12);
                ws.item1.states = 1;
            }
            else
            {
                ws.item1.title = @"日期";
                ws.item1.font = Font(13);
                ws.item1.states = 0;
            }
            
        }];
    }
    
    
    //位置...
    [viewModel.signalPosition subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.item2.title = @"位置";
            ws.item2.states = 1;
        }
        else
        {
            ws.item2.title = @"位置";
            ws.item2.states = 0;
        }
        
    }];
    
    //筛选...
    [viewModel.signalCondition subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.item3.title = @"筛选";
            ws.item3.states = 1;
        }
        else
        {
            ws.item3.title = @"筛选";
            ws.item3.states = 0;
        }
        
    }];
    
    
    //排序...
    [viewModel.signalSort subscribeNext:^(ScreenRoomTagModel *x) {
        
        if(x)
        {
            ws.item4.title = x.cname;
            ws.item4.states = 1;
        }
        else
        {
            ws.item4.title = @"排序";
            ws.item4.states = 0;
        }
        
    }];
    
    
}



@end
