//
//  CheckinInfoConfirmWordView.h
//  xbed
//
//  Created by Leo.Chen on 2017/2/15.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//  口令

#import <UIKit/UIKit.h>
#import "InputTableCell.h"

@interface CheckinInfoConfirmWordView : UIView

@property (nonatomic, strong, readonly)UILabel *lbIsWord;
@property (nonatomic, strong, readonly)UIButton *btnIsWord;
@property (nonatomic, strong, readonly)UISwitch *swtIsWord;
@property (nonatomic, strong, readonly)UIView *vContent;
@property (nonatomic, strong, readonly)InputTableCell *cellWord;
@property (nonatomic, strong, readonly)InputTableCell *cellName;
@property (nonatomic, strong, readonly)InputTableCell *cellPhone;


@property (nonatomic, assign)BOOL isWord;//是否生成口令
@property (nonatomic, strong)NSString *word;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;

@end
