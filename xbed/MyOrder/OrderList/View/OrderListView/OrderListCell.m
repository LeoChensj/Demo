//
//  OrderListCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListCell.h"
#import "CalendarHandle.h"

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectedBackgroundView;
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _imgvRoom = [[UIImageView alloc] init];
        _imgvRoom.clipsToBounds = YES;
        _imgvRoom.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(135*2/3);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            
        }];
        
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.textColor = Main_Text_Color;
        _lbDate.font = Font(14);
        [self.contentView addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-135-10-10);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            
        }];
        
        
        _lbRoomNo = [[UILabel alloc] init];
        _lbRoomNo.textColor = Secondary_Text_Color2;
        _lbRoomNo.font = Font(12);
        [self.contentView addSubview:_lbRoomNo];
        [_lbRoomNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-135-10-10);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.top.mas_equalTo(_lbDate.mas_bottom).offset(10);
            
        }];
        
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = Main_Text_Color;
        _lbPrice.font = Font(14);
        [self.contentView addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-135-10-10);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.bottom.mas_equalTo(_imgvRoom.mas_bottom).offset(0);
            
        }];
        
        
        _btnGetWord = [[UIButton alloc] init];
        _btnGetWord.backgroundColor = [UIColor whiteColor];
        [_btnGetWord setTitle:@"获取订单口令" forState:UIControlStateNormal];
        [_btnGetWord setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnGetWord.titleLabel.font = Font(14);
        [self.contentView addSubview:_btnGetWord];
        [_btnGetWord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_imgvRoom.mas_bottom).offset(10);
            
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [_btnGetWord addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.top.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_btnGetWord rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.block)
            {
                ws.block(ws.model);
            }
            
        }];
    }
    
    return self;
}

- (void)addOrderListCellGetWordBlock:(OrderListCellGetWordBlock)block
{
    self.block = block;
}


- (void)setModel:(CheckinOrderListModel *)model
{
    _model = model;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:model.roomInfo.picture] placeholderImage:PlaceholderImage];
    
    
    NSDate *checkinDate = [CalendarHandle dateHandle2:model.checkinDate];
    NSDate *checkoutDate = [CalendarHandle dateHandle2:model.checkoutDate];
    /*
    NSInteger dayNight = 0;
    if([checkinDate isEqualToDay:checkoutDate])
    {
        dayNight = 1;
    }
    else
    {
        dayNight = [CalendarHandle dayNightFromStart:checkinDate End:checkoutDate];
    }
    */
     
    _lbDate.text = [NSString stringWithFormat:@"%02ld/%02ld-%02ld/%02ld 共%@晚", checkinDate.month, checkinDate.day, checkoutDate.month, checkoutDate.day, model.roomDay];
    
    
    
    if(model.roomInfo.roomFloor)
    {
        _lbRoomNo.text = [NSString stringWithFormat:@"%@楼%@", model.roomInfo.roomFloor, model.roomInfo.custRoomNo];
    }
    else
    {
        _lbRoomNo.text = [NSString stringWithFormat:@"%@", model.roomInfo.custRoomNo];
    }
    
    
    _lbPrice.text = [NSString stringWithFormat:@"应付金额：￥%@", [NSNumber numberWithFloat:model.price.floatValue/100]];
    
    if(model.commandState.integerValue==1)
    {
        _btnGetWord.hidden = NO;
    }
    else
    {
        _btnGetWord.hidden = YES;
    }
}

@end
