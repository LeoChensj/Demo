//
//  FaceVerificationInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputTableCell.h"

@interface FaceVerificationInputView : UIView

@property (nonatomic, strong, readonly)InputTableCell *cellName;
@property (nonatomic, strong, readonly)InputTableCell *cellCardId;

@property (nonatomic, strong)LoginModel *loginModel;

@end
