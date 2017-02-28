//
//  OrderDetailCheckinPersonView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailCheckinPersonView.h"

@implementation OrderDetailCheckinPersonView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"选择入住人";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = Main_Text_Color;
        lbTitle.font = FontBold(14);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(15);
            
        }];
        
        
        UIView *vWhite = [[UIView alloc] init];
        vWhite.backgroundColor = [UIColor whiteColor];
        [self addSubview:vWhite];
        [vWhite mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(15);
            
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Seg_Line_Color;
        [vWhite addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        
        UILabel *lbMyself = [[UILabel alloc] init];
        lbMyself.text = @"本人入住";
        lbMyself.textColor = Main_Text_Color;
        lbMyself.font = Font(13);
        [vWhite addSubview:lbMyself];
        [lbMyself mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        
        _swtMyself = [[UISwitch alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-62, 10, 0, 0)];
        _swtMyself.onTintColor = Blue_Color;
        [vWhite addSubview:_swtMyself];
        
        WS(ws);
        [[_swtMyself rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch *x) {
            
            ws.isMyself = [NSNumber numberWithBool:x.on];
            
        }];
        
        
        
        _btnAddCheckinPerson = [[TouchView alloc] init];
        _btnAddCheckinPerson.normalColor = [UIColor whiteColor];
        _btnAddCheckinPerson.touchColor = White_Click_COLOR;
        [self addSubview:_btnAddCheckinPerson];
        [_btnAddCheckinPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(vWhite.mas_bottom).offset(0);
            
        }];
        
        UILabel *lbAddPerson = [[UILabel alloc] init];
        lbAddPerson.text = @"添加入住人";
        lbAddPerson.textColor = Main_Text_Color;
        lbAddPerson.font = Font(13);
        [_btnAddCheckinPerson addSubview:lbAddPerson];
        [lbAddPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        
        UILabel *lbAddPersonRemind = [[UILabel alloc] init];
        lbAddPersonRemind.text = @"（被添加人可看到该订单，并办理入住）";
        lbAddPersonRemind.textColor = Red_Color;
        lbAddPersonRemind.font = Font(13);
        [_btnAddCheckinPerson addSubview:lbAddPersonRemind];
        [lbAddPersonRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-70-30);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(lbAddPerson.mas_right).offset(0);
            
        }];
        
        UIImageView *imgvAddInto = [[UIImageView alloc] init];
        imgvAddInto.image = [UIImage imageNamed:@"ic_search_into"];
        [_btnAddCheckinPerson addSubview:imgvAddInto];
        [imgvAddInto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            
        }];
        
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Seg_Line_Color;
        [_btnAddCheckinPerson addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        _checkinPersonListView = [[CheckinPersonListView alloc] init];
        [self addSubview:_checkinPersonListView];
        [_checkinPersonListView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_btnAddCheckinPerson.mas_bottom).offset(0);
            
        }];
        
        [_checkinPersonListView addCheckinPersonListViewDeleteBlock:^{
            
            ws.myHeight = 15+14+15+49*2+70*ws.sharers.count;
            [ws mas_updateConstraints:^(MASConstraintMaker *make) {

                make.height.mas_equalTo(ws.myHeight);
                
            }];
            
        }];
        
        
        _myHeight = 15+14+15+49*2;
        
        
        
        
        
        [[RACSignal combineLatest:@[RACObserve(self, checkinerType), RACObserve(self, sharers)] reduce:^id(NSNumber *checkinerType, NSMutableArray <CheckinOrderCheckinerModel *>*sharers){
            
            return @(checkinerType && 1);
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                if(ws.checkinerType.integerValue==-1)
                {
                    _btnAddCheckinPerson.hidden = NO;
                    ws.checkinPersonListView.dataArray = ws.sharers;
                    
                    ws.myHeight = 15+14+15+49*2+70*ws.sharers.count;
                    [self mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.height.mas_equalTo(ws.myHeight);
                        
                    }];
                }
                else
                {
                    _btnAddCheckinPerson.hidden = YES;
                    
                    ws.myHeight = 15+14+15+49;
                    [self mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.height.mas_equalTo(ws.myHeight);
                        
                    }];
                }
                
            }
            
        }];
    }
    
    return self;
}

//- (void)setSharers:(NSMutableArray<CheckinOrderCheckinerModel *> *)sharers
//{
//    _sharers = sharers;
//    
//    _checkinPersonListView.dataArray = sharers;
//    
//    _myHeight = 15+14+15+49*2+70*sharers.count;
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.mas_equalTo(_myHeight);
//        
//    }];
//}

@end
