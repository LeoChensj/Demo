//
//  TextView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  如特别提醒的每一条，包括前面的点

#import <UIKit/UIKit.h>

@interface TextView : UIView
{
@private
    UIView *_vPoint;
    UILabel *_lbContent;
}

@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)UIColor *pointColor;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, assign)CGFloat contentWidth;

@property (nonatomic, assign, readonly)NSInteger height;

@end
