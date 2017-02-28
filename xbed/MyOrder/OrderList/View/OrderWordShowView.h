//
//  OrderWordShowView.h
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//  口令

#import <UIKit/UIKit.h>
#import "LeoTextField.h"

@interface OrderWordShowCell : UIView

@property (nonatomic, strong, readonly)UILabel *lbTitle;
@property (nonatomic, strong, readonly)LeoTextField *tfValue;
@property (nonatomic, strong, readonly)UIView *line;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)NSString *placeholder;


@end


typedef void(^OrderWordShowViewBlock)(void);

@interface OrderWordShowView : UIView

@property (nonatomic, strong, readonly)UIView *vContent;
@property (nonatomic, strong, readonly)UILabel *lbTitle;
@property (nonatomic, strong, readonly)UIButton *btnClose;
@property (nonatomic, strong, readonly)OrderWordShowCell *cellWord;
@property (nonatomic, strong, readonly)OrderWordShowCell *cellName;
@property (nonatomic, strong, readonly)OrderWordShowCell *cellPhone;
@property (nonatomic, strong, readonly)UIButton *btnConfirm;

@property (nonatomic, assign)NSInteger type;//0:查看    1:输入
@property (nonatomic, strong)NSString *word;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)OrderWordShowViewBlock confirmBlock;
@property (nonatomic, strong)OrderWordShowViewBlock closeBlock;


- (instancetype)initWithType:(NSInteger)type;
- (void)addOrderWordShowViewConfirmBlock:(OrderWordShowViewBlock)block;
- (void)addOrderWordShowViewCloseBlock:(OrderWordShowViewBlock)block;

@end
