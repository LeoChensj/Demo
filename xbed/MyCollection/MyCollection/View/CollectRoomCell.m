//
//  CollectRoomCell.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CollectRoomCell.h"

@implementation CollectRoomCell

-  (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
            
            if(ws.blockCollection)
            {
                ws.blockCollection(view, ws.model, flag);
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
        
        
        _vBlack = [[UIView alloc] init];
        _vBlack.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.contentView addSubview:_vBlack];
        [_vBlack mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(RoomListCellHeight);
            make.left.top.mas_equalTo(0);
            
        }];
        
        
        _btnDelete = [[UIButton alloc] init];
        [_btnDelete setImage:[UIImage imageNamed:@"ic_like_delete"] forState:UIControlStateNormal];
        [_vBlack addSubview:_btnDelete];
        [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(25);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            
        }];
        [[_btnDelete rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.blockOff)
            {
                ws.blockOff(ws.model);
            }
            
        }];
        
        _lbOff = [[UILabel alloc] init];
        _lbOff.text = @"已下架";
        _lbOff.textColor = [UIColor whiteColor];
        _lbOff.textAlignment = NSTextAlignmentCenter;
        _lbOff.font = Font(18);
        [_vBlack addSubview:_lbOff];
        [_lbOff mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
    }
    
    return self;
}

- (void)addCollectRoomCellCollectionTouchBlock:(CollectRoomCellCollectionTouchBlock)blockCollection collectRoomCellRoomOffBlock:(CollectRoomCellRoomOffBlock)blockOff;
{
    self.blockCollection = blockCollection;
    self.blockOff = blockOff;
}

- (void)setModel:(CollectRoomListModel *)model
{
    _model = model;
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", model.coverPic, (NSInteger)(MAIN_SCREEN_WIDTH*2)];
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:PlaceholderImage];
    
    _vPrice.rentType = model.rentType.integerValue-1;
    if((model.rentType.integerValue-1)==0)//短租
    {
        _vPrice.price = model.price;
    }
    else
    {
        _vPrice.price = model.totalPrice;
    }
    
    _vCollection.states = 1;
    
    _lbTitle.text = model.custRoomName;
    
    _lbDescribe.type = model.houseType;
    _lbDescribe.count = model.liveCount;
    _lbDescribe.score = model.roomGrade;
    
    
    if(model.flag.integerValue==1)
    {
        _vCollection.hidden = NO;
        _vBlack.hidden = YES;
    }
    else
    {
        _vCollection.hidden = YES;
        _vBlack.hidden = NO;
    }
}

@end
