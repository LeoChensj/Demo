//
//  HomeMainCityTableView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainCityTableView.h"
#import "NSString+Helper.h"


@implementation HomeMainCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imgvCity = [[UIImageView alloc] init];
        _imgvCity.contentMode = UIViewContentModeScaleAspectFill;
        _imgvCity.clipsToBounds = YES;
        [self.contentView addSubview:_imgvCity];
        [_imgvCity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(HomeMainCityRowHeight);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _lbCity = [[UILabel alloc] init];
        _lbCity.textColor = [UIColor whiteColor];
        _lbCity.textAlignment = NSTextAlignmentCenter;
        _lbCity.font = FontBold(21);
        [self.contentView addSubview:_lbCity];
        [_lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100);
            make.height.mas_equalTo(21);
            make.center.mas_equalTo(0);
            
        }];
        _lbCity.hidden = YES;
        
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor whiteColor];
        _vLine.layer.masksToBounds = YES;
        _vLine.layer.cornerRadius = 1;
        [self.contentView addSubview:_vLine];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(2);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(_lbCity.mas_top).offset(-18);
            
        }];
        _vLine.hidden = YES;
        
        _lbCityPinyin = [[UILabel alloc] init];
        _lbCityPinyin.textColor = [UIColor whiteColor];
        _lbCityPinyin.textAlignment = NSTextAlignmentCenter;
        _lbCityPinyin.font = FontBold(21);
        [self.contentView addSubview:_lbCityPinyin];
        [_lbCityPinyin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100);
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbCity.mas_bottom).offset(10);
            
        }];
        _lbCityPinyin.hidden = YES;
    }
    
    return self;
}

- (void)setModel:(HomeMainModel *)model
{
    _model = model;
    
    [_imgvCity sd_setImageWithURL:[NSURL URLWithString:model.picPath] placeholderImage:PlaceholderImage];
    _lbCity.text = model.name;
    _lbCityPinyin.text = model.remark;
}

@end



@implementation HomeMainCityTableView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = HomeMainCityRowHeight;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
        self.scrollsToTop = NO;
    }
    
    return self;
}

- (void)addHomeMainCityTableViewDidSelectRowBlock:(HomeMainCityTableViewDidSelectRowBlock)block
{
    _block = block;
}

- (void)setDataArray:(NSArray<HomeMainModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
    
    if(dataArray && dataArray.count>0)
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(HomeMainCityRowHeight*dataArray.count);
            
        }];
        
    }
}



#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HomeMainCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[HomeMainCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(HomeMainCityCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    if(_block)
    {
        _block(self, _dataArray[indexPath.row], indexPath);
    }
}


@end













