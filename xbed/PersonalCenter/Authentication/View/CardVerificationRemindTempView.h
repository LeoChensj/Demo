//
//  CardVerificationRemindTempView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUILabel.h"

typedef void (^CardVerificationRemindTempViewBlock)(void);

@interface CardVerificationRemindTempView : UIView <LUILabelDelegate>

@property (nonatomic, strong, readonly)LUILabel *lbText1;
@property (nonatomic, strong)UILabel *lbText2;

@property (nonatomic, assign)CGFloat myHeight;
@property (nonatomic, strong)CardVerificationRemindTempViewBlock block;

- (void)addCardVerificationRemindTempViewBlock:(CardVerificationRemindTempViewBlock)block;

@end
