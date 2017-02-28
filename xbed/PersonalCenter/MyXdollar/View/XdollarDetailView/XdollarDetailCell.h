//
//  XdollarDetailCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XdollarRespModel.h"

@interface XdollarDetailCell : UITableViewCell
{
@private
    UILabel *_lbTitle;
    UILabel *_lbDate;
    UILabel *_lbValue;
}

@property (nonatomic, strong)XdollarModel *model;

@end
