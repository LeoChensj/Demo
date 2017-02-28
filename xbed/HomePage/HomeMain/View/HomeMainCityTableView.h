//
//  HomeMainCityTableView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  热门目的地

#import <UIKit/UIKit.h>
#import "HomeMainRespModel.h"

#define HomeMainCityRowHeight (MAIN_SCREEN_WIDTH*2/3)

//cell
@interface HomeMainCityCell : UITableViewCell
{
@private
    UIImageView *_imgvCity;
    UIView *_vLine;
    UILabel *_lbCity;
    UILabel *_lbCityPinyin;//拼音
}

@property (nonatomic, strong)HomeMainModel *model;

@end



//tableView
@class HomeMainCityTableView;
typedef void (^HomeMainCityTableViewDidSelectRowBlock)(HomeMainCityTableView *tableView, HomeMainModel *model, NSIndexPath *indexPath);

@interface HomeMainCityTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <HomeMainModel *>*dataArray;
@property (nonatomic, strong)HomeMainCityTableViewDidSelectRowBlock block;



- (void)addHomeMainCityTableViewDidSelectRowBlock:(HomeMainCityTableViewDidSelectRowBlock)block;

@end



