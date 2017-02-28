//
//  HomeMainNavigationView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchView.h"

@interface HomeMainNavigationView : UIView
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
}

@property (nonatomic, strong, readonly)TouchView *searchBar;

@end
