//
//  AuthenticationRemindLabel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUILabel.h"

@interface AuthenticationRemindLabel : UIView <LUILabelDelegate>
{
@private
    UILabel *_lbText1;
}

@property (nonatomic, strong, readonly)LUILabel *lbText2;
@property (nonatomic, assign)CGFloat myHeight;

@end
