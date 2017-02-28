//
//  StarSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeoRadioButton.h"

@interface StarSelectView : UIView
{
@private
    NSMutableArray <LeoRadioButton *>*_starArray;
}

@property (nonatomic, strong, readonly)UILabel *lbValue;

@property (nonatomic, strong)NSNumber *star;
@property (nonatomic, assign)BOOL enable;       //默认YES
@property (nonatomic, strong, readonly)RACSignal *signalSelect;

@end
