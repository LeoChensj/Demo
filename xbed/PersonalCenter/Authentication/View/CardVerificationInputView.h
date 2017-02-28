//
//  CardVerificationInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputTableCell.h"
#import "QueryCheckinPersonRespModel.h"

@interface CardVerificationInputView : UIView

@property (nonatomic, strong, readonly)InputTableCell *cellName;
@property (nonatomic, strong, readonly)InputTableCell *cellCardId;

@property (nonatomic, strong)QueryCheckinPersonDataModel *checkinPerson;

@end
