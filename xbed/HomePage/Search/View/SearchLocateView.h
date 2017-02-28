//
//  SearchLocateView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"

@interface SearchLocateView : TouchView
{
@private
    UIImageView *_imgvLocate;
    UILabel *_lbTitle;
    UIImageView *_imgvArrow;
}

@property (nonatomic, strong, readonly)UILabel *lbCity;

@property (nonatomic, strong)NSString *locateCity;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;

- (void)startLocate;

@end
