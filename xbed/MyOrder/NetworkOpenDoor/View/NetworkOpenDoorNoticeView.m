//
//  NetworkOpenDoorNoticeView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NetworkOpenDoorNoticeView.h"

@implementation NetworkOpenDoorNoticeView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"远程开门须知：";
        _lbTitle.textColor = Secondary_Text_Color;
        _lbTitle.font = Font(12);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            
        }];
        
        
        NSString *content = @"1. 请慎重使用该功能，确保申请后能马上到达房门前。\n2. 申请远程开门后，需等待约1分钟，门锁发提示声后即可开门。\n3. 解锁后3秒内不开门，将会重新上锁。\n4. 为确保安全性，需进行短信验证和身份证信息验证。\n5. 若不当地使用该功能，期间所造成的房间损失由远程开门申请人负责。\n6. 有任何疑问请联系客服400-6099222。";
        
        _lbContent = [[UILabel alloc] init];
        _lbContent.numberOfLines = 0;
        _lbContent.text = content;
        _lbContent.lineSpace = 6;
        _lbContent.textColor = Secondary_Text_Color;
        _lbContent.font = Font(12);
        [self addSubview:_lbContent];
        CGSize sizeContent = [_lbContent labelSize:(MAIN_SCREEN_WIDTH-20)];
        [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(sizeContent.height);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(15);
            
        }];
        
        _myHeight = 12+15+sizeContent.height;
        
    }
    
    return self;
}

@end
