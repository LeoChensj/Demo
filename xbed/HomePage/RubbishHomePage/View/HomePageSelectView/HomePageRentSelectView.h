//
//  HomePageRentSelectView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageRentSelectView : UIView
{
@private
    UILabel *_lbShortRent;
    UILabel *_lbLongRent;
    UIView *_vIndex;
}



@property (nonatomic, assign)NSInteger index;

@end
