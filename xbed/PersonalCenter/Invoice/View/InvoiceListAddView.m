//
//  InvoiceListAddView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceListAddView.h"

@implementation InvoiceListAddView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"＋ 添加发票信息";
        lbTitle.textColor = Blue_Color;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = Font(14);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIImageView *imgvIcon = [[UIImageView alloc] init];
        imgvIcon.image = [UIImage imageNamed:@""];
        [self addSubview:imgvIcon];
        [imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(12);
            make.right.mas_equalTo(lbTitle.mas_left).offset(-8);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

@end
