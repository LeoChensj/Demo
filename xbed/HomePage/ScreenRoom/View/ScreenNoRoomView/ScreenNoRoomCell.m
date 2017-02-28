//
//  ScreenNoRoomCell.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenNoRoomCell.h"

@implementation ScreenNoRoomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = Blue_Color;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = [UIColor whiteColor];
        _lbTitle.font = Font(13);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(frame.size.width-30);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _imgvDel = [[UIImageView alloc] init];
        _imgvDel.image = [UIImage imageNamed:@"ic_like_delete"];
        [self.contentView addSubview:_imgvDel];
        [_imgvDel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(ScreenRoomTagModel *)model
{
    _model = model;
    
    _lbTitle.text = model.cname;
    
    CGSize size = [_lbTitle labelSize:MAIN_SCREEN_WIDTH-50];
    
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(size.width+10);
        
    }];
}

@end
