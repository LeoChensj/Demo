//
//  CheckinInfoConfirmRemindView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmRemindView.h"

@implementation CheckinInfoConfirmRemindView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        //毛玻璃
        if(More_iOS8)
        {
            self.backgroundColor = [UIColor clearColor];
            
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] init];
            effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            [self addSubview:effectView];
            [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                make.height.mas_equalTo(39);
                make.left.top.mas_equalTo(0);
                
            }];
        }
        
        NSString *orderRetainTime = [DBManager getInstance].appUITextData.orderRetainTime;
        NSString *string = [NSString stringWithFormat:@"订单保留%@，请尽快支付", orderRetainTime];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:(NSString *)NSForegroundColorAttributeName value:Blue_Color range:NSMakeRange(4, orderRetainTime.length)];
        
        _lbRemind = [[UILabel alloc] init];
        _lbRemind.textColor = Main_Text_Color;
        _lbRemind.textAlignment = NSTextAlignmentCenter;
        _lbRemind.font = Font(13);
        _lbRemind.attributedText = (NSAttributedString *)attString;
        [self addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
            make.center.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

@end
