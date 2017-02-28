//
//  RoomDetailBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomDetailBaseInfoView : UIView
{
@private
    UILabel *_lbArea;
    UILabel *_lbRoomType;
    UILabel *_lbFloor;
    UILabel *_lbRoomNo;
    UILabel *_lbPerson;
    UILabel *_lbBed;
    
    CGFloat _bedHeight;
}

@property (nonatomic, strong)NSString *roomArea;
@property (nonatomic, strong)NSString *roomType;
@property (nonatomic, strong)NSNumber *floor;
@property (nonatomic, strong)NSString *roomNo;
@property (nonatomic, strong)NSNumber *person;
@property (nonatomic, strong)NSString *bedDesc;

@end
