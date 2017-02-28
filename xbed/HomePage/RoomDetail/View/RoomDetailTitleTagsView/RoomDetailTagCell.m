//
//  RoomDetailTagCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailTagCell.h"

@implementation RoomDetailTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = Background_Color;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 12;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Secondary_Text_Color2;
        _lbTitle.font = Font(12);
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.center.mas_equalTo(0);
            
        }];
        
        
        RAC(_lbTitle, text) = RACObserve(self, title);
        
    }
    
    return self;
}

@end
