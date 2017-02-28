//
//  CalendarCollectionView1.m
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCollectionView1.h"
#import "CalendarHandle.h"

@implementation CalendarCollectionView1

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
        [self registerClass:[CalendarCell1 class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        
        
        [RACObserve(self, dataArray) subscribeNext:^(id x) {
            
            [self reloadData];
            
        }];
        
    }
    
    return self;
}






#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDate *firstDay = _dataArray[section][0];//这个月的第一天
    
    return _dataArray[section].count+firstDay.weekday-1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CalendarCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    NSDate *firstWeekDay = _dataArray[indexPath.section][0];
    
    NSInteger weekDay = firstWeekDay.weekday-1;
    
    if(indexPath.row<weekDay)//小于第一天的cell，空的
    {
        cell.state = CalendarCellNull;
        cell.date = nil;
    }
    else
    {
        NSDate *curDate = _dataArray[indexPath.section][indexPath.row-weekDay];
        
        cell.date = curDate;
        
        if([curDate isLessDate:_today])//小于今天的cell，灰的，不可选
        {
            //NSLog(@"day=%ld, today=%ld", curDate.day, _today.day);
            cell.state = CalendarCellOver;
        }
        else//大于等于今天的
        {
            //当前cell日期是入住或离店日期，蓝色
            if(_checkinDate && [curDate isEqualToDay:_checkinDate])
            {
                cell.state = CalendarCellCheckin;
            }
            else if(_checkoutDate && [curDate isEqualToDay:_checkoutDate])
            {
                cell.state = CalendarCellCheckout;
            }
            else if(_checkinDate && _checkoutDate &&
                    [curDate isGreaterDate:_checkinDate] &&
                    [curDate isLessDate:_checkoutDate])//浅蓝色
            {
                
                cell.state = CalendarCellBetween;
            }
            else//普通的
            {
                cell.state = CalendarCellNormal;
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
        
        NSDate *monthFirstDay = _dataArray[indexPath.section][0];
        
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
    CalendarCell1 *cell = (CalendarCell1 *)[collectionView cellForItemAtIndexPath:indexPath];
    //NSLog(@"indexPath=(%ld, %ld)", indexPath.section, indexPath.item);
    
    if([cell.date isLessDate:_today])//小于今天不可选
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
            _checkinDate = nil;
            cell.state = CalendarCellNormal;
        }
        else if([cell.date isLessDate:_checkinDate])//选中的比原来的早
        {
            CalendarCell1 *oldCell = [self cellForDate:_checkinDate];
            oldCell.state = CalendarCellNormal;
            
            self.checkinDate = cell.date;
        }
        else//选中的比原来的晚
        {
            self.checkoutDate = cell.date;
            
            //block回调
            if(_block)
            {
                _block(self, _checkinDate, _checkoutDate);
            }
        }
    }
    else//入住和离店都已经选了
    {
        NSArray <NSDate *>*dates = [CalendarHandle getDatesBetween2:_checkinDate And:_checkoutDate];
        
        for (NSDate *date in dates)
        {
            CalendarCell1 *curCell = [self cellForDate:date];
            curCell.state = CalendarCellNormal;
        }
        
        _checkoutDate = nil;
        self.checkinDate = cell.date;
    }
    
    
}




- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    CalendarCell1 *cell = [self cellForDate:checkinDate];
    cell.date = checkinDate;
    cell.state = CalendarCellCheckin;
}

- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    if(_checkinDate && [checkoutDate isGreaterDate:_checkinDate])//入住时间存在，离店时间晚于入住时间
    {
        _checkoutDate = checkoutDate;
        
        CalendarCell1 *cellCheckout = [self cellForDate:checkoutDate];
        cellCheckout.date = checkoutDate;
        cellCheckout.state = CalendarCellCheckout;
        
        
        //中间设为浅蓝色
        NSArray <NSDate *>*dates = [CalendarHandle getDatesBetween:_checkinDate And:checkoutDate];
        
        for (NSDate *date in dates)
        {
            CalendarCell1 *cell = [self cellForDate:date];
            cell.date = date;
            cell.state = CalendarCellBetween;
        }
        
    }
}





#pragma mark - Helper
- (CalendarCell1 *)cellForDate:(NSDate *)date
{
    NSIndexPath *indexPath = nil;
    
    for(NSInteger i=0;i<_dataArray.count;i++)
        for(NSInteger j=0;j<_dataArray[i].count;j++)
        {
            if([_dataArray[i][j] isEqualToDay:date])
            {
                NSDate *firstDay = _dataArray[i][0];//这个月第一天
                
                indexPath = [NSIndexPath indexPathForRow:j+firstDay.weekday-1 inSection:i];
                break;
            }
        }
    
    CalendarCell1 *cell = (CalendarCell1 *)[self cellForItemAtIndexPath:indexPath];
    
    return cell;
}






@end
