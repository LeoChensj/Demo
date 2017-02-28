//
//  MyXdollarRulesView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyXdollarRulesView : UIView
{
@private
    UILabel *_lbTitle;
    NSMutableArray <UILabel *>*_labels;
}

@property (nonatomic, strong)NSArray <NSString *>*rules;

@end
