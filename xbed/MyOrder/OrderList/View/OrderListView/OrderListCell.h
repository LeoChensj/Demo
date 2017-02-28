//
//  OrderListCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListRespModel.h"

typedef void(^OrderListCellGetWordBlock)(CheckinOrderListModel *model);

@interface OrderListCell : UITableViewCell
{
@private
    UIImageView *_imgvRoom;
    UILabel *_lbDate;
    UILabel *_lbRoomNo;
    UILabel *_lbPrice;
    UIView *_line;
}

@property (nonatomic, strong, readonly)UIButton *btnGetWord;

@property (nonatomic, strong)CheckinOrderListModel *model;
@property (nonatomic, strong)OrderListCellGetWordBlock block;


- (void)addOrderListCellGetWordBlock:(OrderListCellGetWordBlock)block;

@end
