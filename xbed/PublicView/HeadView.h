//
//  HeadView.h
//  xclear
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
{
@protected
    UILabel *_lbTitle;
    UIImageView *_imgvLeft;
    UIImageView *_imgvRight;
    UILabel *_lbRight;
    UIView *_vLine;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIColor *titleColor;

@property (nonatomic, strong)NSString *imgLeft;
@property (nonatomic, assign)CGSize sizeLeft;

@property (nonatomic, strong)NSString *imgRight;
@property (nonatomic, strong)NSString *txtRight;
@property (nonatomic, assign)CGSize sizeRight;
@property (nonatomic, strong)UIColor *rightColor;

@property (nonatomic, assign)BOOL haveLine;

@property (nonatomic, strong, readonly)UIButton *btnLeft;
@property (nonatomic, strong, readonly)UIButton *btnRight;

@end
