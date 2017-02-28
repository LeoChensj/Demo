//
//  CalendarCollectionView3.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCollectionView3.h"

@implementation CalendarCollectionView3

- (instancetype)init
{
    NSInteger widthCell = (NSInteger)(MAIN_SCREEN_WIDTH/7);
    CGFloat inset = (MAIN_SCREEN_WIDTH-widthCell*7)/2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionInset = UIEdgeInsetsMake(0, inset, 10, inset);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(widthCell, widthCell);
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[CalendarCell3 class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSArray<DatePriceModel *> *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}


#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDate *firstDay = _dataArray[section][0].date;//这个月的第一天
    
    return _dataArray[section].count+firstDay.weekday-1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CalendarCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    NSDate *firstWeekDay = _dataArray[indexPath.section][0].date;
    
    NSInteger weekDay = firstWeekDay.weekday-1;
    
    if(indexPath.row<weekDay)//小于第一天的cell，空的
    {
        cell.state = CalendarCellNull3;
        cell.date = nil;
    }
    else
    {
        DatePriceModel *curModel = _dataArray[indexPath.section][indexPath.row-weekDay];
        
        cell.date = curModel.date;
        cell.price = curModel.price;
        
        if([curModel.date isLessDate:_today])//小于今天的cell，灰的，不可选
        {
            cell.state = CalendarCellOver3;
        }
        else//大于等于今天
        {
            if(curModel.state==0)//不可订
            {
                if([cell.date isEqualToDay:_unbookCheckout])
                {
                    if([_checkoutDate isEqualToDate:_unbookCheckout])
                    {
                        cell.state = CalendarCellCheckout3;
                        
                    }
                    else
                    {
                        cell.state = CalendarCellNormal3;
                    }
                    
                }
                else
                {
                    cell.state = CalendarCellUnbook3;
                }
            }
            else//可订
            {
                //当前cell日期是入住或离店日期，蓝色
                if(_checkinDate && [curModel.date isEqualToDay:_checkinDate])
                {
                    cell.state = CalendarCellCheckin3;
                }
                else if(_checkoutDate && [curModel.date isEqualToDay:_checkoutDate])
                {
                    cell.state = CalendarCellCheckout3;
                }
                else if(_checkinDate && _checkoutDate &&
                        [curModel.date isGreaterDate:_checkinDate] &&
                        [curModel.date isLessDate:_checkoutDate])//浅蓝色
                {
                    
                    cell.state = CalendarCellBetween3;
                }
                else//普通的
                {
                    cell.state = CalendarCellNormal3;
                }
            }
        }
    }
    
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MAIN_SCREEN_WIDTH, 56);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        
        NSDate *monthFirstDay = _dataArray[indexPath.section][0].date;
        
        UILabel *lbMonthDate = [[UILabel alloc] init];
        lbMonthDate.backgroundColor = [UIColor whiteColor];
        lbMonthDate.textColor = Main_Text_Color;
        lbMonthDate.textAlignment = NSTextAlignmentCenter;
        lbMonthDate.font = FontBold(16);
        lbMonthDate.text = [NSString stringWithFormat:@"%ld年%02ld月", monthFirstDay.year, monthFirstDay.month];
        [headerView addSubview:lbMonthDate];
        [lbMonthDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
    }
    
    return headerView;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell3 *cell = (CalendarCell3 *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if([cell.date isLessDate:_today] || cell.state==CalendarCellUnbook3)//小于今天或不可订的不可选
    {
        return;
    }
    
    
    if(!_checkinDate && !_checkoutDate)//还没有选中的
    {
        self.checkinDate = cell.date;
    }
    else if(_checkinDate && !_checkoutDate)//已选中了入住
    {
        if([cell.date isEqualToDay:_checkinDate])//取消选中
        {
            if(_isOverstay)//续住
            {
                return;
            }
            
            //取消改为可选的不可选日期
            if(_unbookCheckout && ![_unbookCheckout isEqualToDay:_checkoutDate])
            {
                CalendarCell3 *unbookCell = [self cellForDate:_unbookCheckout];
                unbookCell.state = CalendarCellUnbook3;
                
                _unbookCheckout = nil;
            }
            
            _checkinDate = nil;
            cell.state = CalendarCellNormal3;
        }
        else if([cell.date isLessDate:_checkinDate])//选中的比原来的早
        {
            if(_isOverstay)//续住
            {
                return;
            }
            
            CalendarCell3 *oldCell = [self cellForDate:_checkinDate];
            oldCell.state = CalendarCellNormal3;
            
            self.checkinDate = cell.date;
        }
        else//选中的比原来的晚
        {
            NSInteger index = 0;
            for (NSInteger i=0;i<_roomStatus.count;i++)
            {
                if(_roomStatus.count>i)
                {
                    if([_roomStatus[i].calendarDate isEqualToDate:_checkinDate])
                    {
                        index = i;
                        break;
                    }
                }
                else
                {
                    return;
                }
                
            }
            BOOL flagUnbook = NO;
            for (NSInteger i=index+1;i<[CalendarHandle dayNightFromStart:_checkinDate End:cell.date]+index;i++)
            {
                if(_roomStatus.count>i)
                {
                    if(_roomStatus[i].state.integerValue!=1)
                    {
                        flagUnbook = YES;
                        break;
                    }
                }
                else
                {
                    return;
                }
            }
            
            //if([CalendarHandle haveDateWithCheckinDate:_checkinDate checkoutDate:cell.date inUnbookDates:_unbooks])
            
            if(flagUnbook)//入住和退房时间跨过了不可选日期
            {
                if(_isOverstay)//续住
                {
                    return;
                }
                
                CalendarCell3 *oldCell = [self cellForDate:_checkinDate];
                oldCell.state = CalendarCellNormal3;
                
                self.checkinDate = cell.date;
            }
            else//正常选中退房日期
            {
                if(self.rentType==1)//长租
                {
                    if([CalendarHandle dayNightFromStart:self.checkinDate End:cell.date]<30)//小于30天
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:@"至少要预订30天以上"];
                        return;
                    }
                }
                
                
                self.checkoutDate = cell.date;
                
                //block回调
                if(_block)
                {
                    _block(self, _checkinDate, _checkoutDate);
                }
            }
        }
    }
    else//入住和离店都已经选了
    {
        NSArray <NSDate *>*dates = [CalendarHandle getDatesBetween2:_checkinDate And:_checkoutDate];
        
        for (NSDate *date in dates)
        {
            CalendarCell3 *curCell = [self cellForDate:date];
            curCell.state = CalendarCellNormal3;
        }
        
        if(_isOverstay)//续住
        {
            if([cell.date isLessOrEqualToDate:_checkinDate])//选中的日期小于等于入住日期
            {
                _checkoutDate = nil;
                self.checkinDate = _checkinDate;
            }
            else//选中日期比入住日期晚
            {
                //入住和退房时间跨过了不可选日期
                NSInteger index = 0;
                for (NSInteger i=0;i<_roomStatus.count;i++)
                {
                    if(_roomStatus.count>i)
                    {
                        if([_roomStatus[i].calendarDate isEqualToDate:_checkinDate])
                        {
                            index = i;
                            break;
                        }
                    }
                    else
                    {
                        return;
                    }
                    
                }
                BOOL flagUnbook = NO;
                for (NSInteger i=index+1;i<[CalendarHandle dayNightFromStart:_checkinDate End:cell.date]+index;i++)
                {
                    if(_roomStatus.count>i)
                    {
                        if(_roomStatus[i].state.integerValue!=1)
                        {
                            flagUnbook = YES;
                            break;
                        }
                    }
                    else
                    {
                        return;
                    }
                }
                
                if(flagUnbook)//包含不可选日期
                {
                    self.checkinDate = _checkinDate;
                    _checkoutDate = nil;
                }
                else
                {
                    self.checkinDate = _checkinDate;
                    self.checkoutDate = cell.date;
                    
                    //block回调
                    if(_block)
                    {
                        _block(self, _checkinDate, _checkoutDate);
                    }
                }
            }
        }
        else
        {
            _checkoutDate = nil;
            self.checkinDate = cell.date;
        }
    }
}




- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    if(checkinDate)
    {
        //取消改为可选的不可选日期
        if(_unbookCheckout && ![_unbookCheckout isEqualToDay:_checkoutDate])
        {
            CalendarCell3 *unbookCell = [self cellForDate:_unbookCheckout];
            unbookCell.state = CalendarCellUnbook3;
            
            if([_unbookCheckout isEqualToDay:checkinDate])//入住日期不能选择锁定日期 优化
            {
                _checkinDate = nil;
            }
            else
            {
                CalendarCell3 *cell = [self cellForDate:checkinDate];
                cell.date = checkinDate;
                cell.state = CalendarCellCheckin3;
            }
            
            _unbookCheckout = nil;
        }
        else
        {
            CalendarCell3 *cell = [self cellForDate:checkinDate];
            cell.date = checkinDate;
            cell.state = CalendarCellCheckin3;
        }
        
        
        
        
        //入住日期之后的第一个不可选日期改成可选，即可作为退房日期
        NSInteger index = 0;
        for (NSInteger i=0;i<_roomStatus.count;i++)
        {
            if(_roomStatus.count>i)
            {
                if([_roomStatus[i].calendarDate isEqualToDate:_checkinDate])
                {
                    index = i;
                    break;
                }
            }
            else
            {
                return;
            }
            
        }
        for (NSInteger i=index+1;i<_roomStatus.count;i++)
        {
            if(_roomStatus.count>i)
            {
                if(_roomStatus[i].state.integerValue!=1)
                {
                    _unbookCheckout = _roomStatus[i].calendarDate;
                    break;
                }
            }
            else
            {
                return;
            }
        }
        
        //_unbookCheckout = [CalendarHandle lateDate:checkinDate Dates:_unbooks];
        if(_unbookCheckout)
        {
            CalendarCell3 *unbookCell = [self cellForDate:_unbookCheckout];
            unbookCell.state = CalendarCellNormal3;
        }
    }
}

- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    if(checkoutDate)
    {
        if(_isOverstay==NO)//如果是续住，选了离店时间也不取消
        {
            //取消改为可选的不可选日期
            if(_unbookCheckout && ![_unbookCheckout isEqualToDay:checkoutDate])
            {
                CalendarCell3 *unbookCell = [self cellForDate:_unbookCheckout];
                unbookCell.state = CalendarCellUnbook3;
                
                _unbookCheckout = nil;
            }
        }
        
        if(_checkinDate && [checkoutDate isGreaterDate:_checkinDate])//入住时间存在，离店时间晚于入住时间
        {
            _checkoutDate = checkoutDate;
            
            CalendarCell3 *cellCheckout = [self cellForDate:checkoutDate];
            cellCheckout.date = checkoutDate;
            cellCheckout.state = CalendarCellCheckout3;
            
            
            //中间设为浅蓝色
            NSArray <NSDate *>*dates = [CalendarHandle getDatesBetween:_checkinDate And:checkoutDate];
            
            for (NSDate *date in dates)
            {
                CalendarCell3 *cell = [self cellForDate:date];
                cell.date = date;
                cell.state = CalendarCellBetween3;
            }
            
        }
    }
}






#pragma mark - Helper
- (CalendarCell3 *)cellForDate:(NSDate *)date
{
    NSIndexPath *indexPath = nil;
    
    for(NSInteger i=0;i<_dataArray.count;i++)
        for(NSInteger j=0;j<_dataArray[i].count;j++)
        {
            if([_dataArray[i][j].date isEqualToDay:date])
            {
                NSDate *firstDay = _dataArray[i][0].date;//这个月第一天
                
                indexPath = [NSIndexPath indexPathForRow:j+firstDay.weekday-1 inSection:i];
                break;
            }
        }
    
    CalendarCell3 *cell = (CalendarCell3 *)[self cellForItemAtIndexPath:indexPath];
    
    return cell;
}


@end
