//
//  RoomDetailBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailBaseInfoView.h"

@implementation RoomDetailBaseInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgv1 = [[UIImageView alloc] init];
        imgv1.image = [UIImage imageNamed:@"ic_room_information"];
        [self addSubview:imgv1];
        [imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(19);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(25);
            
        }];
        
        UILabel *lbTitle1 = [[UILabel alloc] init];
        lbTitle1.text = @"房间信息";
        lbTitle1.textColor = Main_Text_Color;
        lbTitle1.font = Font(13);
        [self addSubview:lbTitle1];
        [lbTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(imgv1.mas_right).offset(10);
            make.bottom.mas_equalTo(imgv1.mas_bottom).offset(0);
            
        }];
        
        
        UIImageView *imgv2 = [[UIImageView alloc] init];
        imgv2.image = [UIImage imageNamed:@"ic_room_position"];
        [self addSubview:imgv2];
        [imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(19);
            make.left.mas_equalTo(self.mas_centerX).offset(15);
            make.top.mas_equalTo(25);
            
        }];
        
        UILabel *lbTitle2 = [[UILabel alloc] init];
        lbTitle2.text = @"房间位置";
        lbTitle2.textColor = Main_Text_Color;
        lbTitle2.font = Font(13);
        [self addSubview:lbTitle2];
        [lbTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(imgv2.mas_right).offset(10);
            make.bottom.mas_equalTo(imgv2.mas_bottom).offset(0);
            
        }];
        
        
        UIImageView *imgv3 = [[UIImageView alloc] init];
        imgv3.image = [UIImage imageNamed:@"ic_room_person"];
        [self addSubview:imgv3];
        [imgv3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(19);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(113);
            
        }];
        
        UILabel *lbTitle3 = [[UILabel alloc] init];
        lbTitle3.text = @"宜住人数";
        lbTitle3.textColor = Main_Text_Color;
        lbTitle3.font = Font(13);
        [self addSubview:lbTitle3];
        [lbTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(imgv3.mas_right).offset(10);
            make.bottom.mas_equalTo(imgv3.mas_bottom).offset(0);
            
        }];
        
        
        UIImageView *imgv4 = [[UIImageView alloc] init];
        imgv4.image = [UIImage imageNamed:@"ic_room_number"];
        [self addSubview:imgv4];
        [imgv4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(19);
            make.left.mas_equalTo(self.mas_centerX).offset(15);
            make.top.mas_equalTo(113);
            
        }];
        
        UILabel *lbTitle4 = [[UILabel alloc] init];
        lbTitle4.text = @"床位数量";
        lbTitle4.textColor = Main_Text_Color;
        lbTitle4.font = Font(13);
        [self addSubview:lbTitle4];
        [lbTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(imgv4.mas_right).offset(10);
            make.bottom.mas_equalTo(imgv4.mas_bottom).offset(0);
            
        }];
        
        
        
        _lbArea = [[UILabel alloc] init];
        _lbArea.textColor = Secondary_Text_Color2;
        _lbArea.font = Font(12);
        [self addSubview:_lbArea];
        [_lbArea mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle1.mas_left).offset(0);
            make.top.mas_equalTo(lbTitle1.mas_bottom).offset(10);
            
        }];
        
        _lbRoomType = [[UILabel alloc] init];
        _lbRoomType.textColor = Secondary_Text_Color2;
        _lbRoomType.font = Font(12);
        [self addSubview:_lbRoomType];
        [_lbRoomType mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle1.mas_left).offset(0);
            make.top.mas_equalTo(_lbArea.mas_bottom).offset(10);
            
        }];
        
        
        _lbFloor = [[UILabel alloc] init];
        _lbFloor.textColor = Secondary_Text_Color2;
        _lbFloor.font = Font(12);
        [self addSubview:_lbFloor];
        [_lbFloor mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle2.mas_left).offset(0);
            make.top.mas_equalTo(lbTitle2.mas_bottom).offset(10);
            
        }];
        
        
        UILabel *lbRoomNo = [[UILabel alloc] init];
        lbRoomNo.text = @"房号：";
        lbRoomNo.textColor = Secondary_Text_Color2;
        lbRoomNo.font = Font(12);
        [self addSubview:lbRoomNo];
        [lbRoomNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle2.mas_left).offset(0);
            make.top.mas_equalTo(_lbFloor.mas_bottom).offset(10);
            
        }];
        
        _lbRoomNo = [[UILabel alloc] init];
        _lbRoomNo.numberOfLines = 0;
        _lbRoomNo.textColor = Secondary_Text_Color2;
        _lbRoomNo.font = Font(12);
        [self addSubview:_lbRoomNo];
        [_lbRoomNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44-40);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbRoomNo.mas_right).offset(-3);
            make.top.mas_equalTo(lbRoomNo.mas_top).offset(-1);
            
        }];
        
        
        
        _lbPerson = [[UILabel alloc] init];
        _lbPerson.textColor = Secondary_Text_Color2;
        _lbPerson.font = Font(12);
        [self addSubview:_lbPerson];
        [_lbPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle3.mas_left).offset(0);
            make.top.mas_equalTo(lbTitle3.mas_bottom).offset(10);
            
        }];
        
        
        _lbBed = [[UILabel alloc] init];
        _lbBed.numberOfLines = 0;
        _lbBed.textColor = Secondary_Text_Color2;
        _lbBed.font = Font(12);
        [self addSubview:_lbBed];
        [_lbBed mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-44);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lbTitle4.mas_left).offset(0);
            make.top.mas_equalTo(_lbPerson.mas_top).offset(0);
            
        }];

        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
    }
    
    return self;
}


- (void)setRoomArea:(NSString *)roomArea
{
    _roomArea = roomArea;
    
    if(roomArea)
    {
        self.hidden = NO;
        
        _lbArea.text = [NSString stringWithFormat:@"面积：%@平米", roomArea];
    }
    else
    {
        self.hidden = YES;
    }
}
- (void)setRoomType:(NSString *)roomType
{
    _roomType = roomType;
    
    if(roomType && roomType.length)
    {
        _lbRoomType.hidden = NO;
        _lbRoomType.text = [NSString stringWithFormat:@"户型：%@", roomType];
    }
    else
    {
        _lbRoomType.hidden = YES;
    }
}
- (void)setFloor:(NSNumber *)floor
{
    _floor = floor;
    
    if(floor)
    {
        _lbFloor.hidden = NO;
        _lbFloor.text = [NSString stringWithFormat:@"楼层：%@楼", floor];
    }
    else
    {
        _lbFloor.hidden = YES;
    }
}
- (void)setRoomNo:(NSString *)roomNo
{
    _roomNo = roomNo;
    
    _lbRoomNo.text = [NSString stringWithFormat:@"%@", roomNo];
    
    _lbRoomNo.lineSpace = 3;
    CGFloat height = 0;
    CGSize size = [_lbRoomNo labelSize:MAIN_SCREEN_WIDTH/2-44-40];
    
    if(size.height>32)
    {
        height = 32;
    }
    else
    {
        height = size.height;
    }
    
    [_lbRoomNo mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(height);
        
    }];
}
- (void)setPerson:(NSNumber *)person
{
    _person = person;
    
    _lbPerson.text = [NSString stringWithFormat:@"%@人", person];
}
- (void)setBedDesc:(NSString *)bedDesc
{
    _bedDesc = bedDesc;
    
    _lbBed.text = bedDesc;
    _lbBed.lineSpace = 5;
    CGSize sizeBed = [_lbBed labelSize:MAIN_SCREEN_WIDTH/2-44];
    _bedHeight = sizeBed.height;
    [_lbBed mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_bedHeight);
        
    }];
    
    [self updateMyHeight];
}

- (void)updateMyHeight
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(200);
        
    }];
}




@end
