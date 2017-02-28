//
//  CheckinInfoConfirmBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckinInfoConfirmBaseInfoView : UIView
{
@private
    UIImageView *_imgvRoom;
    UILabel *_lbTitle;
}

@property (nonatomic, strong, readonly)UILabel *lbDesc;

@property (nonatomic, strong)NSString *roomImage;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *roomType;
@property (nonatomic, strong)NSNumber *person;

@end
