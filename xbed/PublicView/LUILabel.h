//
//  LUILabel.h
//  TestLabel
//
//  Created by mengxianzhi on 15/11/16.
//  Copyright © 2015年 mengxianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LabelBlock)(UILabel *llabel);

@protocol LUILabelDelegate <NSObject>

- (void)didClickLink;

@end

@interface LUILabel : UILabel

/**
 *  接受点击文字的范围 (range)
 */
@property (assign,nonatomic) NSRange linkRange;

/**
 *  初始化LUILabel
 *
 *  @param foudSize   LUILabel 字体大小
 *  @param maxWidth   LUILabel 最大宽度
 *  @param stringText LUILabel 的文字
 *  @param delegate   代理
 *
 *  @return LUILabel instance
 */
- (instancetype)initFondSize:(CGFloat)foudSize maxWidth:(int)maxWidth stringText:(NSString *)stringText delegate:(id)delegate;

/**
 *  获取label位置
 *
 *  @param leftGap    距父视图左边间距
 *  @param topGap     距父视图上边间距
 *  @param color      连接文字颜色
 *  @param otherColor 其他文字颜色
 *  @param labelBlock 目标LUILabel
 */
- (void)labelBlockWithLeftGap:(CGFloat)leftGap topGap:(CGFloat)topGap linkTextColor:(UIColor *)color otherTextColor:(UIColor *)otherColor labelBlock:(LabelBlock)labelBlock;

@end
