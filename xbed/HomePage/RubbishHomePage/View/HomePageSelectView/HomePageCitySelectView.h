//
//  HomePageCitySelectView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"

@interface HomePageCitySelectView : TouchView
{
@private
    UILabel *_lbCity;
}

@property (nonatomic, strong)NSString *city;

@end
