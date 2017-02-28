//
//  OrderDetailRoomServiceView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailRoomServiceView.h"

@implementation OrderDetailRoomServiceView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat widthCell = MAIN_SCREEN_WIDTH/3;
        
        _cellClean = [[OrderDetailRoomServiceCell alloc] init];
        _cellClean.imageIcon = [UIImage imageNamed:@"icon_clean"];
        _cellClean.title = @"申请清洁";
        [self addSubview:_cellClean];
        [_cellClean mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(widthCell);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _cellWifi = [[OrderDetailRoomServiceCell alloc] init];
        _cellWifi.imageIcon = [UIImage imageNamed:@"ic_roomwifi"];
        _cellWifi.title = @"WiFi密码";
        [self addSubview:_cellWifi];
        [_cellWifi mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(widthCell);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_cellClean.mas_right).offset(0);
            
        }];
        
        _cellDoor = [[OrderDetailRoomServiceCell alloc] init];
        _cellDoor.imageIcon = [UIImage imageNamed:@"ic_door"];
        _cellDoor.title = @"网络开门";
        [self addSubview:_cellDoor];
        [_cellDoor mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(widthCell);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_cellWifi.mas_right).offset(0);
            
        }];
        
        _cellCheckin = [[OrderDetailRoomServiceCell alloc] init];
        _cellCheckin.imageIcon = [UIImage imageNamed:@"ic_extend_stay"];
        _cellCheckin.title = @"办理续住";
        _cellCheckin.desc = @"如需续住，请尽快办理";
        [self addSubview:_cellCheckin];
        [_cellCheckin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(widthCell);
            make.top.mas_equalTo(_cellClean.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            
        }];
        
        _cellOpinion = [[OrderDetailRoomServiceCell alloc] init];
        _cellOpinion.imageIcon = [UIImage imageNamed:@"ic_feedback"];
        _cellOpinion.title = @"意见反馈";
        [self addSubview:_cellOpinion];
        [_cellOpinion mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(widthCell);
            make.top.mas_equalTo(_cellWifi.mas_bottom).offset(0);
            make.left.mas_equalTo(_cellCheckin.mas_right).offset(0);
            
        }];
        
        _cellEvaluate = [[OrderDetailRoomServiceCell alloc] init];
        _cellEvaluate.imageIcon = [UIImage imageNamed:@"ic_evaluate"];
        _cellEvaluate.title = @"房间评价";
        [self addSubview:_cellEvaluate];
        [_cellEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.width.height.mas_equalTo(widthCell);
            make.top.mas_equalTo(_cellDoor.mas_bottom).offset(0);
            make.left.mas_equalTo(_cellOpinion.mas_right).offset(0);
        
        }];
        
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Seg_Line_Color;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Seg_Line_Color;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(widthCell*2);
            make.centerX.mas_equalTo(self.mas_left).offset(widthCell);
            make.top.mas_equalTo(0);
            
        }];
        
        UIView *line3 = [[UIView alloc] init];
        line3.backgroundColor = Seg_Line_Color;
        [self addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(widthCell*2);
            make.centerX.mas_equalTo(self.mas_left).offset(widthCell*2);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _myHeight = widthCell*2;
    }
    
    return self;
}

@end
