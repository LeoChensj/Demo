//
//  HomePageSearchView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"
#import "SearchRespModel.h"

@interface HomePageSearchView : TouchView
{
@private
    UILabel *_lbTitle;
    UIImageView *_imgvArr;
    UIImageView *_imgvClear;
}

@property (nonatomic, strong, readonly)UIButton *btnClear;
@property (nonatomic, strong)SearchModel *model;


@end
