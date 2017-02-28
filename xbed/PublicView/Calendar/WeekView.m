//
//  WeekView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "WeekView.h"

@implementation WeekView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        NSArray *weekText = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        
        _mArray = [NSMutableArray arrayWithCapacity:7];
        for (NSInteger i=0; i<7; i++)
        {
            UILabel *lbWeek = [[UILabel alloc] init];
            lbWeek.text = weekText[i];
            lbWeek.textColor = Main_Text_Color;
            lbWeek.textAlignment = NSTextAlignmentCenter;
            lbWeek.font = Font(14);
            [self addSubview:lbWeek];
            [lbWeek mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(self.mas_width).dividedBy(7);
                make.height.mas_equalTo(44);
                make.centerY.mas_equalTo(0);
                if(i==0)
                {
                    make.left.mas_equalTo(0);
                }
                else
                {
                    make.left.mas_equalTo(_mArray[i-1].mas_right).offset(0);
                }
                
                
            }];
            [_mArray addObject:lbWeek];
        }
        
    }
    
    return self;
}

@end
