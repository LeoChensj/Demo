//
//  RoomListCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomListCell.h"

@implementation RoomListCell

-  (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgvRoom = [[UIImageView alloc] init];
        _imgvRoom.image = PlaceholderImage;
        _imgvRoom.contentMode = UIViewContentModeScaleAspectFill;
        _imgvRoom.clipsToBounds = YES;
        [self.contentView addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(RoomListCellWidth);
            make.height.mas_equalTo(RoomListCellHeight-64);
            make.top.left.mas_equalTo(0);
            
        }];
        
        _vPrice = [[PriceView alloc] init];
        [self.contentView addSubview:_vPrice];
        [_vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(39);
            make.left.mas_equalTo(-5);
            make.bottom.mas_equalTo(_imgvRoom.mas_bottom).offset(-15);
            
        }];
        
        WS(ws);
        _vCollection = [[CollectionView alloc] init];
        _vCollection.normalImage = @"ic_no_collection";
        _vCollection.collectionImage = @"ic_collection";
        [self.contentView addSubview:_vCollection];
        [_vCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(34);
            make.height.mas_equalTo(32);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(15);
            
        }];
        [_vCollection addCollectionViewTouchBlock:^(CollectionView *view, BOOL flag) {
            
            if(ws.block)
            {
                ws.block(view, ws.model, flag);
            }
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(RoomListCellWidth-20);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_imgvRoom.mas_bottom).offset(15);
            
        }];
        
        
        _lbDescribe = [[RoomDescribeLabel alloc] init];
        [self.contentView addSubview:_lbDescribe];
        [_lbDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(RoomListCellWidth-20);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-15);
            
        }];
        
        
        _lbDistance = [[UILabel alloc] init];
        _lbDistance.textColor = Blue_Color;
        _lbDistance.textAlignment = NSTextAlignmentRight;
        _lbDistance.font = Font(14);
        [self.contentView addSubview:_lbDistance];
        [_lbDistance mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-15);
            
        }];
        
        
    }
    
    return self;
}

- (void)addRoomListCellCollectionTouchBlock:(RoomListCellCollectionTouchBlock)block
{
    _block = block;
}

- (void)setModel:(ScreenRoomListModel *)model
{
    _model = model;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:model.coverPic] placeholderImage:PlaceholderImage];
    
    _vPrice.rentType = model.rentType.integerValue-1;
    
    if((model.rentType.integerValue-1)==0)//短租
    {
        _vPrice.price = model.price;
    }
    else//长租
    {
        _vPrice.price = model.totalPrice;
    }
    
    _vCollection.states = model.collected.integerValue;
    
    _lbTitle.text = model.roomName;
    
    _lbDescribe.type = model.houseType;
    _lbDescribe.count = model.liveCount;
    
    if(model.roomGrade && model.cleanGrade)
    {
        _lbDescribe.score = [NSNumber numberWithFloat:(model.roomGrade.floatValue+model.cleanGrade.floatValue)*0.5];
    }
    else
    {
        _lbDescribe.score = nil;
    }
    
    if(model.distance)
    {
        _lbDistance.hidden = NO;
        
        _lbDistance.text = [self distanceHandle:model.distance];
    }
    else
    {
        _lbDistance.hidden = YES;
    }
}

- (NSString *)distanceHandle:(NSNumber *)number
{
    NSString *string = nil;
    
    NSInteger value_m = number.integerValue;
    if(value_m>=1000)
    {
        CGFloat value_km = value_m*0.001;
        string = [NSString stringWithFormat:@"距%.1fkm", value_km];
    }
    else
    {
        string = [NSString stringWithFormat:@"距%ldm", value_m];
    }
    
    return string;
}

@end
