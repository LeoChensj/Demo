//
//  CustomTabBarController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UIButton
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
    UIView *_vBadge;
}

@property (nonatomic, strong)UIImage *imgNormal;
@property (nonatomic, strong)UIImage *imgSelect;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)BOOL isNotice;//是否有通知
@property (nonatomic, assign)BOOL isSelect;

@end






typedef NS_ENUM(NSInteger, TabBarIndex)
{
    TabBarIndexHome,
    TabBarIndexCollection,
    TabBarIndexOrder,
    TabBarIndexMe
};

@interface CustomTabBarController : UITabBarController
{
@private
    UIView *_vTabBarBack;
}

@property (nonatomic, strong, readonly)NSMutableArray <CustomTabBarItem *>*tabBarItems;
@property (nonatomic, assign)TabBarIndex index;

+ (CustomTabBarController *)getInstance;

@end
