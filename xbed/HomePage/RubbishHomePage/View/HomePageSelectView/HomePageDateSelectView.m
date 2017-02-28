//
//  HomePageDateSelectView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageDateSelectView.h"

@implementation HomePageDateSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = [UIColor whiteColor];
        
        
        UIView *lineCheckin = [[UIView alloc] init];
        lineCheckin.backgroundColor = Seg_Line_Color;
        [self addSubview:lineCheckin];
        [lineCheckin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20-30-65*XSCALE)/2);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(0);
            
        }];
        
        UIView *lineCheckout = [[UIView alloc] init];
        lineCheckout.backgroundColor = Seg_Line_Color;
        [self addSubview:lineCheckout];
        [lineCheckout mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20-30-65*XSCALE)/2);
            make.height.mas_equalTo(LINE_WIDTH);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        UILabel *lbCheckin = [[UILabel alloc] init];
        lbCheckin.text = @"入住";
        lbCheckin.textColor = Secondary_Text_Color2;
        lbCheckin.font = Font(12);
        [self addSubview:lbCheckin];
        [lbCheckin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lineCheckin.mas_left).offset(0);
            make.top.mas_equalTo(15);
            
        }];
        
        UILabel *lbCheckout = [[UILabel alloc] init];
        lbCheckout.text = @"离店";
        lbCheckout.textColor = Secondary_Text_Color2;
        lbCheckout.font = Font(12);
        [self addSubview:lbCheckout];
        [lbCheckout mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(lineCheckout.mas_left).offset(0);
            make.top.mas_equalTo(15);
            
        }];
        
        
        _lbCheckin = [[UILabel alloc] init];
        _lbCheckin.textColor = Main_Text_Color2;
        _lbCheckin.font = Font(18);
        [self addSubview:_lbCheckin];
        [_lbCheckin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(lineCheckin.mas_left).offset(0);
            make.top.mas_equalTo(lbCheckin.mas_bottom).offset(18);
            
        }];
        
        _lbCheckout = [[UILabel alloc] init];
        _lbCheckout.textColor = Main_Text_Color2;
        _lbCheckout.font = Font(18);
        [self addSubview:_lbCheckout];
        [_lbCheckout mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(lineCheckout.mas_left).offset(0);
            make.top.mas_equalTo(lbCheckout.mas_bottom).offset(18);
            
        }];
        
        
        
        _lbCheckinRemind = [[UILabel alloc] init];
        _lbCheckinRemind.textColor = Secondary_Text_Color;
        _lbCheckinRemind.textAlignment = NSTextAlignmentRight;
        _lbCheckinRemind.font = Font(13);
        [self addSubview:_lbCheckinRemind];
        [_lbCheckinRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(lineCheckin.mas_right).offset(0);
            make.bottom.mas_equalTo(_lbCheckin.mas_bottom).offset(0);
            
        }];
        
        
        _lbCheckoutRemind = [[UILabel alloc] init];
        _lbCheckoutRemind.textColor = Secondary_Text_Color;
        _lbCheckoutRemind.textAlignment = NSTextAlignmentRight;
        _lbCheckoutRemind.font = Font(13);
        [self addSubview:_lbCheckoutRemind];
        [_lbCheckoutRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(lineCheckout.mas_right).offset(0);
            make.bottom.mas_equalTo(_lbCheckout.mas_bottom).offset(0);
            
        }];
        
        
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.image = [UIImage imageNamed:@"ic_time"];
        [self addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(42);
            make.height.mas_equalTo(9);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(_lbCheckin.mas_centerY).offset(0);
            
        }];
        
        
        _lbNight = [[UILabel alloc] init];
        _lbNight.textColor = Blue_Color;
        _lbNight.textAlignment = NSTextAlignmentCenter;
        _lbNight.font = Font(10);
        [self addSubview:_lbNight];
        [_lbNight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(imgv.mas_top).offset(-5);
            
        }];
        
        
        
        
        
        
        WS(ws);
        [[RACSignal combineLatest:@[RACObserve(self, today), RACObserve(self, checkinDate), RACObserve(self, checkoutDate)] reduce:^id(NSData *today, NSData *checkinDate, NSData *checkoutDate){
            
            return @(today && 1);
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                if(ws.today && ws.checkinDate==nil && ws.checkoutDate==nil)
                {
                    ws.checkinDate = ws.today;
                    ws.checkoutDate = [ws.today dateByAddingDays:1];
                }
                else if(ws.today && ws.checkinDate && ws.checkoutDate)
                {
                    ws.lbCheckin.text = [NSString stringWithFormat:@"%02ld月%02ld日", ws.checkinDate.month, ws.checkinDate.day];
                    ws.lbCheckout.text = [NSString stringWithFormat:@"%02ld月%02ld日", ws.checkoutDate.month, ws.checkoutDate.day];
                    
                    NSInteger night = [CalendarHandle dayNightFromStart:ws.checkinDate End:ws.checkoutDate];
                    ws.lbNight.text = [NSString stringWithFormat:@"共%ld晚", night];
                    
                    ws.lbCheckinRemind.text = [ws dateRemind:ws.checkinDate];
                    ws.lbCheckoutRemind.text = [ws dateRemind:ws.checkoutDate];
                }
                
            }
            
        }];
        
    }
    
    return self;
}



- (NSString *)dateRemind:(NSDate *)date
{
    NSString *result;
    
    if([date isEqualToDay:self.today])
    {
        result = @"(今天)";
    }
    else if([date isEqualToDay:[self.today dateByAddingDays:1]])
    {
        result = @"(明天)";
    }
    else if([date isEqualToDay:[self.today dateByAddingDays:2]])
    {
        result = @"(后天)";
    }
    else
    {
        NSInteger week = date.weekday;
        
        switch (week)
        {
            case 1:
                result = @"(周日)";
                break;
            case 2:
                result = @"(周一)";
                break;
            case 3:
                result = @"(周二)";
                break;
            case 4:
                result = @"(周三)";
                break;
            case 5:
                result = @"(周四)";
                break;
            case 6:
                result = @"(周五)";
                break;
            case 7:
                result = @"(周六)";
                break;
                
            default:
                result = @"";
                break;
        }
        
    }
    
    
    return result;
}









@end
