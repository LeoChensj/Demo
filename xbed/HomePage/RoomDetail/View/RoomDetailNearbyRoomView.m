//
//  RoomDetailNearbyRoomView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailNearbyRoomView.h"

@implementation RoomDetailNearbyRoomView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"附近更多房源";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(16);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 70, MAIN_SCREEN_WIDTH, (MAIN_SCREEN_WIDTH-96)*2/3)];
        _pageFlowView.backgroundColor = [UIColor whiteColor];
        _pageFlowView.minimumPageAlpha = 0.5;
        _pageFlowView.minimumPageScale = 0.9;
        _pageFlowView.pageCount = 0;
        [self addSubview:_pageFlowView];
        
        
        _lbRoomTitle = [[UILabel alloc] init];
        _lbRoomTitle.textColor = Main_Text_Color;
        _lbRoomTitle.font = Font(14);
        [self addSubview:_lbRoomTitle];
        [_lbRoomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-96);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(48);
            make.top.mas_equalTo(_pageFlowView.mas_bottom).offset(10);
            
        }];
        
        _lbDescribe = [[RoomDescribeLabel alloc] init];
        [self addSubview:_lbDescribe];
        [_lbDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-96-60);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(48);
            make.top.mas_equalTo(_lbRoomTitle.mas_bottom).offset(10);
            
        }];
        
        
        _lbDistance = [[UILabel alloc] init];
        _lbDistance.textColor = Secondary_Text_Color2;
        _lbDistance.textAlignment = NSTextAlignmentRight;
        _lbDistance.font = Font(12);
        [self addSubview:_lbDistance];
        [_lbDistance mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(-48);
            make.top.mas_equalTo(_lbRoomTitle.mas_bottom).offset(10);
            
        }];
        
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = Blue_Color;
        _lbPrice.font = Font(14);
        [self addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(48);
            make.top.mas_equalTo(_lbDescribe.mas_bottom).offset(15);
            
        }];
        
        _index = -1;//重要
    }
    
    return self;
}

- (void)addRoomDetailNearbyRoomViewDidSelectItemBlock:(RoomDetailNearbyRoomViewDidSelectItemBlock)block
{
    _block = block;
}

- (void)setDataArray:(NSArray<NearbyRoomModel *> *)dataArray
{
    if(dataArray)
    {
        self.hidden = NO;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(70+((MAIN_SCREEN_WIDTH-96)*2/3)+98);
            
        }];
    }
    else
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    
    if(_dataArray!=dataArray && dataArray.count>0)
    {
        _dataArray = dataArray;
        
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        
        [_pageFlowView reloadData];
        
        self.index = 0;
    }
}

- (void)setIndex:(NSInteger)index
{
    if(_index!=index)
    {
        _index = index;
        
        _lbRoomTitle.text = _dataArray[index].title;
        
        _lbDescribe.type = _dataArray[index].roomType;
        _lbDescribe.count = _dataArray[index].person;
        _lbDescribe.score = _dataArray[index].score;
        
        _lbDistance.text = [NSString stringWithFormat:@"距%@m", _dataArray[index].distance];
        
        _lbPrice.text = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:_dataArray[index].price.floatValue/100]];
    }
}




#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView
{
    return CGSizeMake(MAIN_SCREEN_WIDTH-96, (MAIN_SCREEN_WIDTH-96)*2/3);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    if(_block)
    {
        _block(self, _dataArray[subIndex], subIndex);
    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView
{
    return self.dataArray.count;
}
- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView)
    {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH-96, (MAIN_SCREEN_WIDTH-96)*2/3)];
        bannerView.clipsToBounds = YES;
        bannerView.layer.masksToBounds = YES;
        bannerView.layer.cornerRadius = 3;
        
    }
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[index].image] placeholderImage:PlaceholderImage];
    
    return bannerView;
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView
{
    self.index = pageNumber;
}





@end
