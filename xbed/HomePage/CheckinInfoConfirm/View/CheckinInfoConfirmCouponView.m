//
//  CheckinInfoConfirmCouponView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmCouponView.h"

@implementation CheckinInfoConfirmCouponView

- (instancetype)initWithRentType:(NSInteger)rentType
{
    if(self = [super init])
    {
        self.rentType = rentType;
        self.backgroundColor = [UIColor whiteColor];
        
        _tvCoupon = [[TouchView alloc] init];
        _tvCoupon.normalColor = [UIColor whiteColor];
        _tvCoupon.touchColor = White_Click_COLOR;
        [self addSubview:_tvCoupon];
        [_tvCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _lbTitleCoupon = [[UILabel alloc] init];
        _lbTitleCoupon.text = @"活动优惠";
        _lbTitleCoupon.textColor = Main_Text_Color;
        _lbTitleCoupon.font = Font(13);
        [_tvCoupon addSubview:_lbTitleCoupon];
        [_lbTitleCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _imgvArrow = [[UIImageView alloc] init];
        _imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [_tvCoupon addSubview:_imgvArrow];
        [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        if(rentType==1)//长租
        {
            _tvCoupon.enabled = NO;
            _lbTitleCoupon.text = @"长租不参与优惠券和活动";
            _imgvArrow.hidden = YES;
        }
        
        
        _lbCouponValue = [[UILabel alloc] init];
        _lbCouponValue.textColor = Blue_Color;
        _lbCouponValue.textAlignment = NSTextAlignmentRight;
        _lbCouponValue.font = Font(13);
        [_tvCoupon addSubview:_lbCouponValue];
        [_lbCouponValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(_imgvArrow.mas_left).offset(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [_tvCoupon addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        _vXdollar = [[UIView alloc] init];
        _vXdollar.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vXdollar];
        [_vXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_tvCoupon.mas_bottom).offset(0);
            
        }];
        
        
        _lbXdollar = [[UILabel alloc] init];
        _lbXdollar.textColor = Main_Text_Color;
        _lbXdollar.font = Font(13);
        [_vXdollar addSubview:_lbXdollar];
        [_lbXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _swtXdollar = [[UISwitch alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-62, 10, 0, 0)];
        _swtXdollar.onTintColor = Blue_Color;
        [_vXdollar addSubview:_swtXdollar];
        
        
        
        WS(ws);
        
        
        [[RACSignal combineLatest:@[RACObserve(self, activityCouponFlag), RACObserve(self, selectActivity), RACObserve(self, selectCoupon)] reduce:^id(NSNumber *activityCouponFlag, ActivityContentsModel *selectActivity, CouponCardModel *selectCoupon){
            
            return @(activityCouponFlag && (selectActivity || selectCoupon));
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                if(ws.activityCouponFlag.integerValue==1)//活动
                {
                    ws.lbCouponValue.text = ws.selectActivity.title;
                }
                else if(ws.activityCouponFlag.integerValue==2)//优惠券
                {
                    ws.lbCouponValue.text = ws.selectCoupon.title;
                }
            }
            else
            {
                ws.lbCouponValue.text = @"";
            }
            
        }];
        
        
        
        [[_swtXdollar rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch *x) {
            
            ws.xdollarOn = [NSNumber numberWithBool:x.on];
            
        }];
        
    }
    
    return self;
}


- (void)setXdollar:(NSNumber *)xdollar
{
    _xdollar = xdollar;
    
    _lbXdollar.text = [NSString stringWithFormat:@"可用%@Xdollar（1Xdollar＝1元）", [NSNumber numberWithFloat:xdollar.floatValue*0.01]];
}
- (void)setXdollarOn:(NSNumber *)xdollarOn
{
    _xdollarOn = xdollarOn;
    
    _swtXdollar.on = xdollarOn.boolValue;
}


- (UIButton *)button
{
    return _tvCoupon;
}




@end
