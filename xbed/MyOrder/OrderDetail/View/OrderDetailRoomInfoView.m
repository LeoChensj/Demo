//
//  OrderDetailRoomInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailRoomInfoView.h"

@implementation OrderDetailRoomInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _btnRoomInfo = [[TouchView alloc] init];
        _btnRoomInfo.normalColor = [UIColor whiteColor];
        _btnRoomInfo.touchColor = White_Click_COLOR;
        [self addSubview:_btnRoomInfo];
        [_btnRoomInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(134*2/3+20);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _imgvRoom = [[UIImageView alloc] init];
        [_btnRoomInfo addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(134);
            make.height.mas_equalTo(134*2/3);
            make.left.top.mas_equalTo(10);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [_btnRoomInfo addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-154);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Secondary_Text_Color2;
        _lbDesc.font = Font(12);
        [_btnRoomInfo addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-154);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Seg_Line_Color;
        [_btnRoomInfo addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        
        _btnRoomAddress = [[TouchView alloc] init];
        _btnRoomAddress.normalColor = [UIColor whiteColor];
        _btnRoomAddress.touchColor = White_Click_COLOR;
        [self addSubview:_btnRoomAddress];
        [_btnRoomAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_btnRoomInfo.mas_bottom).offset(0);
            
        }];
        
        _lbAddress = [[UILabel alloc] init];
        _lbAddress.textColor = Main_Text_Color;
        _lbAddress.font = Font(13);
        [_btnRoomAddress addSubview:_lbAddress];
        [_lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-30);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        UIImageView *imgvArrow = [[UIImageView alloc] init];
        imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [_btnRoomAddress addSubview:imgvArrow];
        [imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Seg_Line_Color;
        [_btnRoomAddress addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        UIView *vDate = [[UIView alloc] init];
        vDate.backgroundColor = [UIColor whiteColor];
        [self addSubview:vDate];
        [vDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_btnRoomAddress.mas_bottom).offset(0);
            
        }];
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.textColor = Main_Text_Color;
        _lbDate.font = Font(13);
        [vDate addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-10);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        
        _myHeight = 134*2/3+20+98;
    }
    
    return self;
}

- (void)setOrderType:(NSNumber *)orderType
{
    _orderType = orderType;
    
    if(orderType)
    {
        if(orderType.integerValue==0 || orderType.integerValue==1)
        {
            if(_roomInfo)
            {
                _lbDesc.text = [NSString stringWithFormat:@"%@ | 可住%@人", _roomInfo.houseType, _roomInfo.liveCount];
            }
        }
        else
        {
            if(_roomInfo)
            {
                _lbDesc.text = [NSString stringWithFormat:@"%@楼%@", _roomInfo.roomFloor, _roomInfo.custRoomNo];
            }
        }
    }
}

- (void)setRoomInfo:(CheckinOrderRoomInfoModel *)roomInfo
{
    _roomInfo = roomInfo;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:roomInfo.picture] placeholderImage:PlaceholderImage];
    
    _lbTitle.text = roomInfo.custRoomName;
    _lbTitle.lineSpace = 6;
    CGSize titleSize = [_lbTitle labelSize:MAIN_SCREEN_WIDTH-164];
    CGFloat titleHeight = titleSize.height;
    if(titleHeight>39) titleHeight = 39;
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(titleHeight);
        
    }];
    
    if(_orderType)
    {
        if(_orderType.integerValue==0 || _orderType.integerValue==1)
        {
            if(roomInfo.houseType && roomInfo.houseType.length)
                _lbDesc.text = [NSString stringWithFormat:@"%@ | 可住%@人", roomInfo.houseType, roomInfo.liveCount];
            else
                _lbDesc.text = [NSString stringWithFormat:@"可住%@人", roomInfo.liveCount];
        }
        else
        {
            if(roomInfo.roomFloor)
            {
                _lbDesc.text = [NSString stringWithFormat:@"%@楼%@", roomInfo.roomFloor, roomInfo.custRoomNo];
            }
            else
            {
                _lbDesc.text = [NSString stringWithFormat:@"%@", roomInfo.custRoomNo];
            }
        }
    }
    
    _lbAddress.text = [NSString stringWithFormat:@"详细地址：%@", roomInfo.custRoomAddr];
}

- (void)setCheckinInfo:(CheckinOrderInfoModel *)checkinInfo
{
    _checkinInfo = checkinInfo;
    
    _lbDate.text = [NSString stringWithFormat:@"入离时间：%ld年%ld月%ld日 %02ld:%02ld－%ld年%ld月%ld日 %02ld:%02ld", checkinInfo.checkinDate.year-2000, checkinInfo.checkinDate.month, checkinInfo.checkinDate.day, checkinInfo.checkinDate.hour, checkinInfo.checkinDate.minute, checkinInfo.checkoutDate.year-2000, checkinInfo.checkoutDate.month, checkinInfo.checkoutDate.day, checkinInfo.checkoutDate.hour, checkinInfo.checkoutDate.minute];
}

@end
