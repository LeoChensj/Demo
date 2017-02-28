//
//  TextsView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  多个TextView

#import <UIKit/UIKit.h>
#import "TextView.h"

@interface TextsView : UIView
{
@private
    NSMutableArray <TextView *>*_tvArray;
}

@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *content2;    //只显示3条
@property (nonatomic, strong)NSArray <NSString *>*contentArray;
@property (nonatomic, strong)UIColor *pointColor;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, assign)CGFloat contentWidth;


@property (nonatomic, assign, readonly)CGFloat height;

@end
