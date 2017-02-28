//
//  AuthenticationRemindLabel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AuthenticationRemindLabel.h"

@implementation AuthenticationRemindLabel

- (instancetype)init
{
    if(self = [super init])
    {
        UIView *point1 = [[UIView alloc] init];
        point1.backgroundColor = Secondary_Text_Color2;
        point1.layer.masksToBounds = YES;
        point1.layer.cornerRadius = 2.5;
        [self addSubview:point1];
        [point1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mas_top).offset(13.0/2);
            
        }];
        
        
        _lbText1 = [[UILabel alloc] init];
        _lbText1.text = @"根据公安要求，请登记所有入住人的身份信息；";
        _lbText1.textColor = Secondary_Text_Color;
        _lbText1.font = Font(13);
        [self addSubview:_lbText1];
        [_lbText1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-25-10);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(25);
            make.top.mas_equalTo(0);
            
        }];
        
        
        
        UIView *point2 = [[UIView alloc] init];
        point2.backgroundColor = Secondary_Text_Color2;
        point2.layer.masksToBounds = YES;
        point2.layer.cornerRadius = 2.5;
        [self addSubview:point2];
        [point2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mas_top).offset(30+13.0/2);
            
        }];
        
        
        WS(ws);
        NSString *temp = [NSString stringWithFormat:@"Xbed互联网酒店平台暂仅支持持有中国大陆二代身份证办理入住，如有任何问题，请联系客服 %@。", [DBManager getInstance].appUITextData.serviceTelephone];
        _lbText2 = [[LUILabel alloc] initFondSize:13 maxWidth:MAIN_SCREEN_WIDTH-25-10 stringText:temp delegate:self];
        [_lbText2 setLinkRange:NSMakeRange(44, [DBManager getInstance].appUITextData.serviceTelephone.length)];
        [_lbText2 labelBlockWithLeftGap:25 topGap:28 linkTextColor:Secondary_Text_Color otherTextColor:Blue_Color labelBlock:^(UILabel *llabel) {
            
            [ws addSubview:ws.lbText2];
            
            CGSize size = [ws.lbText2 labelSize:MAIN_SCREEN_WIDTH-25-10];
            ws.lbText2.size = size;
            
            ws.myHeight = 28+size.height;
             
        }];
        
        
    }
    
    return self;
}


#pragma mark - LUILabelDelegate
- (void)didClickLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"telprompt://%@", [DBManager getInstance].appUITextData.serviceTelephone]]];
}

@end
