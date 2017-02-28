//
//  CheckinInfoConfirmBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmBaseInfoView.h"

@implementation CheckinInfoConfirmBaseInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgvRoom = [[UIImageView alloc] init];
        [self addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(134);
            make.height.mas_equalTo(89);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-164);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Secondary_Text_Color2;
        _lbDesc.font = Font(12);
        [self addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-164);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        WS(ws);
        [[RACSignal combineLatest:@[RACObserve(self, roomType), RACObserve(self, person)] reduce:^id(NSString *roomType, NSNumber *person){
            
            if(roomType.length>0 && person)
                return @1;
            else if(roomType.length<=0 && person)
            {
                return @2;
            }
            else if(roomType.length>0 && !person)
            {
                return @3;
            }
            else
            {
                return nil;
            }
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x)
            {
                if(x.integerValue==1)
                {
                    ws.lbDesc.text = [NSString stringWithFormat:@"%@ | 可住%@人", ws.roomType, ws.person];
                }
                else if(x.integerValue==2)
                {
                    ws.lbDesc.text = [NSString stringWithFormat:@"可住%@人", ws.person];
                }
                else if(x.integerValue==3)
                {
                    ws.lbDesc.text = [NSString stringWithFormat:@"%@", ws.roomType];
                }
            }
            
        }];
        
        
    }
    
    return self;
}


- (void)setRoomImage:(NSString *)roomImage
{
    _roomImage = roomImage;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:roomImage] placeholderImage:PlaceholderImage];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
    _lbTitle.lineSpace = 6;
    
    CGSize titleSize = [_lbTitle labelSize:MAIN_SCREEN_WIDTH-164];
    CGFloat titleHeight = titleSize.height;
    if(titleHeight>39) titleHeight = 39;
    
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(titleHeight);
        
    }];
}

//- (void)setRoomType:(NSString *)roomType
//{
//    _roomType = roomType;
//    
//    if(_roomType && _person)
//    {
//        _lbDesc.text = [NSString stringWithFormat:@"%@ | 可住%@人", _roomType, _person];
//    }
//}
//- (void)setPerson:(NSNumber *)person
//{
//    _person = person;
//    
//    if(_roomType && _person)
//    {
//        _lbDesc.text = [NSString stringWithFormat:@"%@ | 可住%@人", _roomType, _person];
//    }
//}



@end
