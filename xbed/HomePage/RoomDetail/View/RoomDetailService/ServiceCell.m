//
//  ServiceCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_detail_facilities_have"];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(14);
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //make.width.mas_equalTo(MAIN_SCREEN_WIDTH/3-39);
            make.width.mas_equalTo(frame.size.width-24-10);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(24);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}



@end
