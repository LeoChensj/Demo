//
//  LeoTextField.h
//  LeoTextFieldDemo
//
//  Created by Leo.Chen on 2016/12/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeoTextField;
typedef void(^LeoTextFieldBlock)(LeoTextField *textField);

@interface LeoTextField : UITextField

@property (nonatomic, assign)NSInteger limitLength;//最大长度限制，默认不限制（即不设置此属性）

@property (nonatomic, strong)LeoTextFieldBlock changeBlock;
@property (nonatomic, strong)LeoTextFieldBlock lengthBlock;


/*
 设置文本改变block回调
 */
- (void)addTextDidChangeBlock:(LeoTextFieldBlock)block;

/*
 设置输入达到最大长度block回调
 */
- (void)addTextLengthDidLimitBlock:(LeoTextFieldBlock)block;

@end
