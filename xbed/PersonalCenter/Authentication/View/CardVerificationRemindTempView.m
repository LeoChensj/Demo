//
//  CardVerificationRemindTempView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationRemindTempView.h"

@implementation CardVerificationRemindTempView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbStar1 = [[UILabel alloc] init];
        lbStar1.text = @"*";
        lbStar1.textColor = Red_Color;
        lbStar1.font = Font(13);
        [self addSubview:lbStar1];
        [lbStar1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mas_top).offset(10+13/2+3);
            
        }];
        
        WS(ws);
        NSString *temp = @"请务必上传真实、有效、清晰的照片（查看示例模板）";
        _lbText1 = [[LUILabel alloc] initFondSize:13 maxWidth:MAIN_SCREEN_WIDTH-20-10 stringText:temp delegate:self];
        [_lbText1 setLinkRange:NSMakeRange(16, 8)];
        [_lbText1 labelBlockWithLeftGap:20 topGap:10 linkTextColor:Main_Text_Color otherTextColor:Blue_Color labelBlock:^(UILabel *llabel) {
            
            [ws addSubview:ws.lbText1];
            
            
            
            UILabel *lbStar2 = [[UILabel alloc] init];
            lbStar2.text = @"*";
            lbStar2.textColor = Red_Color;
            lbStar2.font = Font(13);
            [ws addSubview:lbStar2];
            [lbStar2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(13);
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(ws.lbText1.mas_bottom).offset(8+13/2+3);
                
            }];
            
            
            ws.lbText2 = [[UILabel alloc] init];
            ws.lbText2.text = @"Xbed绝对不会泄露您的资料";
            ws.lbText2.textColor = Main_Text_Color;
            ws.lbText2.font = Font(13);
            [ws addSubview:ws.lbText2];
            [ws.lbText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20-10);
                make.height.mas_equalTo(13);
                make.left.mas_equalTo(20);
                make.top.mas_equalTo(ws.lbText1.mas_bottom).offset(8);
                
            }];
            
            
            ws.myHeight = 10+ws.lbText1.size.height+8+13+1;
            
        }];
        
    }
    
    return self;
}

- (void)addCardVerificationRemindTempViewBlock:(CardVerificationRemindTempViewBlock)block
{
    _block = block;
}



#pragma mark - LUILabelDelegate
- (void)didClickLink
{
    if(_block)
    {
        _block();
    }
}



@end
