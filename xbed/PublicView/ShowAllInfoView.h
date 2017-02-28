//
//  ShowAllInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "TextsView.h"

@interface ShowAllInfoView : UIView
{
@private
    UIView *_vContent;
    UILabel *_lbtitle;
    UIScrollView *_scrollView;
    TextsView *_textsView;
    UIButton *_btnClose;
}

- (instancetype)initWithContentHeight:(CGFloat)contentHeight;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray <NSString *>*contentArray;

@end
