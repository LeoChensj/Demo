//
//  SearchHeadView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeadView : UIView
{
@private
    UIView *_searchBar;
    UIImageView *_imgvIcon;
}

@property (nonatomic, strong, readonly)UITextField *tfSearch;
@property (nonatomic, strong, readonly)UIButton *btnCancel;

@end
