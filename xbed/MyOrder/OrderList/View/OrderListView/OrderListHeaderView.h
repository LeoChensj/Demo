//
//  OrderListHeaderView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListHeaderView : UITableViewHeaderFooterView
{
@private
    UIView *_vWhite;
    UILabel *_lbTitle;
    UILabel *_lbState;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSNumber *state;

@end
