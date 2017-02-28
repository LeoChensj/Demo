//
//  PersonalCenterTableView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalTableCell.h"

@interface PersonalCenterTableView : UIScrollView

@property (nonatomic, strong, readonly)NormalTableCell *cellIdentity;
@property (nonatomic, strong, readonly)NormalTableCell *cellInvoice;
@property (nonatomic, strong, readonly)NormalTableCell *cellProblem;
@property (nonatomic, strong, readonly)NormalTableCell *cellOpinion;
@property (nonatomic, strong, readonly)NormalTableCell *cellPhone;

@property (nonatomic, strong)LoginModel *loginModel;

@end
