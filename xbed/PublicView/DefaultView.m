//
//  DefaultView.m
//  xbed
//
//  Created by Leo.Chen on 16/3/21.
//  Copyright © 2016年 liujialin125. All rights reserved.
//

#import "DefaultView.h"

@implementation DefaultView

- (id)init
{
    if(self = [super initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)])
    {
        self.backgroundColor = Background_Color;
        _type = 0;

        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(225);
            make.height.mas_equalTo(225);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(70*XSCALE);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = [UIFont fontWithName:GlobalFontName size:14];
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imageView.mas_bottom).offset(0);
            
        }];
        
        _button  = [[UIButton alloc] init];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 2;
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = Blue_Color.CGColor;
        _button.titleLabel.font = [UIFont fontWithName:GlobalFontName size:14];
        [_button setTitleColor:Blue_Color forState:UIControlStateNormal];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(45);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(25);
            
        }];
        
    }
    
    return self;
}

- (id)initWithType:(DefaultType)type
{
    if(self = [self init])
    {
        self.type = type;
    }
    
    return self;
}

- (void)setType:(DefaultType)type
{
    _type = type;
    
    switch (type)
    {
        case DefaultViewNoNetwork:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nowifi"];
            _lbTitle.text = @"网络不给力，点击屏幕重新刷新";
            _button.hidden = YES;
        }
            break;
        case DefaultViewNoSearchRoom:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_noroom"];
            _lbTitle.text = @"没有符合条件的房间";
            [_button setTitle:@"重新搜索" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoConditonRoom:
        {
            self.frame = CGRectMake(0, 64+49, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_noroom"];
            _lbTitle.text = @"没有符合条件的房间";
            [_button setTitle:@"修改筛选条件" forState:UIControlStateNormal];
            _button.hidden = YES;
        }
            break;
        case DefaultViewNoOrder:
        {
            self.frame = CGRectMake(0, 64+49, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_noorder"];
            _lbTitle.text = @"你还没有订单";
            [_button setTitle:@"去首页看看" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoCollectionRoom:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nocollect"];
            _lbTitle.text = @"你还没有收藏房间";
            [_button setTitle:@"去首页看看" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoMessage:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nomessage"];
            _lbTitle.text = @"你还没有消息";
            [_button setTitle:@"去首页看看" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoXdollar:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nointegral"];
            _lbTitle.text = @"你还没有Xdollar";
            [_button setTitle:@"如何赚取Xdollar" forState:UIControlStateNormal];
            _button.hidden = YES;//还没有h5页面
        }
            break;
        case DefaultViewNoCoupon:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nocoupon"];
            //_lbTitle.text = @"优惠券暂只支持微信公众号使用，请关注Xbed公众号，感谢您的支持！";
            _lbTitle.text = @"您还没有优惠券哦～";
            [_button setTitle:@"如何赚取优惠券" forState:UIControlStateNormal];
            _button.hidden = YES;//还没有h5页面
        }
            break;
        case DefaultViewNoInvoice:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_noorder"];
            _lbTitle.text = @"你还没有已保存的发票信息";
            [_button setTitle:@"添加发票信息" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoLoginWithOrder:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_noorder"];
            _lbTitle.text = @"登录后才能查看相关订单噢～";
            [_button setTitle:@"马上登录" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoLoginWithCollectionRoom:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nocollect"];
            _lbTitle.text = @"登录后才能收藏房间噢～";
            [_button setTitle:@"马上登录" forState:UIControlStateNormal];
            _button.hidden = NO;
        }
            break;
        case DefaultViewNoActivity:
        {
            self.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
            
            _imageView.image = [UIImage imageNamed:@"pic_default_nocoupon"];
            _lbTitle.text = @"没有可参加的活动～";
            [_button setTitle:@"马上查看" forState:UIControlStateNormal];
            _button.hidden = YES;
        }
            break;
            
        default:
            break;
    }
    
    
    NSDictionary *attribute = @{NSFontAttributeName : _lbTitle.font};
    CGSize labelSize = [_lbTitle.text boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-20, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(labelSize.height+5);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_imageView.mas_bottom).offset(0);
        
    }];
    
}

//- (void)addTarget:(id)target action:(SEL)action
//{
//    if(_type)
//    {
//        if(_type==DefaultViewNoNetwork)
//        {
//            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//        }
//        else
//        {
//            [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
//    else
//    {
//        NSLog(@"你咋没设type呢！");
//    }
//}





@end
