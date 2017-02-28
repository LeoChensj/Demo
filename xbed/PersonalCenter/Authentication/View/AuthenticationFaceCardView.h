//
//  AuthenticationFaceCardView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalTableCell.h"

@interface AuthenticationFaceCardView : UIView

@property (nonatomic, strong, readonly)NormalTableCell *cellFace;
@property (nonatomic, strong, readonly)NormalTableCell *cellCard;

@property (nonatomic, strong)LoginModel *loginModel;

@end
