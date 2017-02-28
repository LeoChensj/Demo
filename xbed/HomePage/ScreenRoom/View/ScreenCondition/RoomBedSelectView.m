//
//  RoomBedSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomBedSelectView.h"

@implementation RoomBedSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"床数";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            
        }];
        
        
        _scrollViewNormal = [[UIScrollView alloc] init];
        _scrollViewNormal.layer.masksToBounds = YES;
        _scrollViewNormal.layer.cornerRadius = 3;
        _scrollViewNormal.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        _scrollViewNormal.delegate = self;
        _scrollViewNormal.showsHorizontalScrollIndicator = NO;
        _scrollViewNormal.scrollsToTop = NO;
        _scrollViewNormal.alwaysBounceHorizontal = YES;
        [self addSubview:_scrollViewNormal];
        [_scrollViewNormal mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(43);
            make.centerX.mas_equalTo(0);
            
        }];
        
        _scrollViewBlue = [[UIScrollView alloc] init];
        _scrollViewBlue.backgroundColor = [UIColor whiteColor];
        _scrollViewBlue.scrollEnabled = NO;
        _scrollViewBlue.showsHorizontalScrollIndicator = NO;
        _scrollViewBlue.scrollsToTop = NO;
        _scrollViewBlue.layer.masksToBounds = YES;
        _scrollViewBlue.userInteractionEnabled = NO;//重要，不接受事件，把事件往下传
        _scrollViewBlue.layer.cornerRadius = 57/2;
        _scrollViewBlue.layer.borderColor = Blue_Color.CGColor;
        _scrollViewBlue.layer.borderWidth = 1;
        [self addSubview:_scrollViewBlue];
        [_scrollViewBlue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(57);
            make.centerY.mas_equalTo(_scrollViewNormal.mas_centerY).offset(0);
            make.centerX.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)reset
{
    self.bedModel = nil;
}

- (void)setRoomBeds:(NSArray<ScreenRoomTagModel *> *)roomBeds
{
    _roomBeds = roomBeds;
    
    _scrollViewBlue.contentSize = _scrollViewNormal.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH-30+roomBeds.count*50, 40);
    
    for (NSInteger i=0;i<roomBeds.count+1;i++)
    {
        if(i==0)
        {
            UILabel *lbUnlimit = [[UILabel alloc] init];
            lbUnlimit.text = @"不限";
            lbUnlimit.textColor = Secondary_Text_Color2;
            lbUnlimit.textAlignment = NSTextAlignmentCenter;
            lbUnlimit.font = Font(13);
            [_scrollViewNormal addSubview:lbUnlimit];
            [lbUnlimit mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(0);
                make.centerX.mas_equalTo(0);
                
            }];
            
            UILabel *lbUnlimitBlue = [[UILabel alloc] init];
            lbUnlimitBlue.text = @"不限";
            lbUnlimitBlue.textColor = Blue_Color;
            lbUnlimitBlue.textAlignment = NSTextAlignmentCenter;
            lbUnlimitBlue.font = Font(14);
            [_scrollViewBlue addSubview:lbUnlimitBlue];
            [lbUnlimitBlue mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(0);
                make.centerX.mas_equalTo(0);
                
            }];
        }
        else
        {
            UILabel *lbValue = [[UILabel alloc] init];
            lbValue.text = _roomBeds[i-1].cname;
            lbValue.textColor = Secondary_Text_Color2;
            lbValue.textAlignment = NSTextAlignmentCenter;
            lbValue.font = Font(13);
            [_scrollViewNormal addSubview:lbValue];
            [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(0);
                make.centerX.mas_equalTo(_scrollViewNormal.mas_centerX).offset(50*i);
                
            }];
            
            UILabel *lbValueBlue = [[UILabel alloc] init];
            lbValueBlue.text = _roomBeds[i-1].cname;
            lbValueBlue.textColor = Blue_Color;
            lbValueBlue.textAlignment = NSTextAlignmentCenter;
            lbValueBlue.font = Font(14);
            [_scrollViewBlue addSubview:lbValueBlue];
            [lbValueBlue mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(0);
                make.centerX.mas_equalTo(_scrollViewBlue.mas_centerX).offset(50*i);
                
            }];
        }
        
    }
}


//- (void)setBedCode:(NSString *)bedCode
//{
//    _bedCode = bedCode;
//    
//    NSInteger index = 0;
//    for (NSInteger i=0;i<_roomBeds.count;i++)
//    {
//        if([bedCode isEqual:_roomBeds[i].code])
//        {
//            index = i+1;
//            break;
//        }
//    }
//    
//    [_scrollViewNormal setContentOffset:CGPointMake(index*50, _scrollViewNormal.contentOffset.y) animated:YES];
//}

- (void)setBedModel:(ScreenRoomTagModel *)bedModel
{
    _bedModel = bedModel;
    
    NSInteger index = 0;
    for (NSInteger i=0;i<_roomBeds.count;i++)
    {
        if([bedModel.code isEqual:_roomBeds[i].code])
        {
            index = i+1;
            break;
        }
    }
    
    [_scrollViewNormal setContentOffset:CGPointMake(index*50, _scrollViewNormal.contentOffset.y) animated:YES];
}


#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _scrollViewBlue.contentOffset = scrollView.contentOffset;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(!scrollView.dragging)
    {
        [self calibrationContentOffsetY:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        [self calibrationContentOffsetY:scrollView];
    }
}
#pragma mark - Help
- (void)calibrationContentOffsetY:(UIScrollView *)scrollView
{
    for(NSInteger i=0;i<_roomBeds.count+1;i++)
    {
        CGFloat xOff = scrollView.contentOffset.x;
        CGFloat yOff = scrollView.contentOffset.y;
        
        if(xOff>=i*50-25 && xOff<i*50+25)
        {
            if(i==0)
            {
                _bedModel = nil;
            }
            else
            {
                _bedModel = _roomBeds[i-1];
            }
            
            [scrollView setContentOffset:CGPointMake(i*50, yOff) animated:YES];
            break;
        }
    }
}








@end
