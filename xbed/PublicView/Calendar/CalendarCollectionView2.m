//
//  CalendarCollectionView2.m
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCollectionView2.h"

@implementation CalendarCollectionView2

- (instancetype)init
{
    NSInteger width_7 = (NSInteger)(MAIN_SCREEN_WIDTH/7);
    NSInteger widthCell = width_7-10;
    NSInteger heightCell = width_7-5;
    CGFloat inset = (MAIN_SCREEN_WIDTH-widthCell*7-6*10)/2;
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout.sectionInset = UIEdgeInsetsMake(0, inset, 10, inset);
    _layout.minimumInteritemSpacing = 10;
    _layout.minimumLineSpacing = 5;
    _layout.itemSize = CGSizeMake(widthCell, heightCell);
    
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:_layout])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[CalendarCell2 class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<DatePriceModel *> *)dataArray
{
    _dataArray = dataArray;
    
    
    if(dataArray && dataArray.count)
    {
        [self reloadData];
        
        DatePriceModel *firstDay = dataArray[0];//这个月的第一天
        NSInteger count = _dataArray.count+firstDay.date.weekday-1;//cell个数，包括空白的cell
        
        if(count<=28)//4行
        {
            _layout.minimumLineSpacing = 20;
        }
        else if(count<=35)//5行
        {
            _layout.minimumLineSpacing = 15;
        }
        else//6行
        {
            _layout.minimumLineSpacing = 5;
        }
        
        [self setCollectionViewLayout:_layout];
    }
}



#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DatePriceModel *firstDay = _dataArray[0];//这个月的第一天
    
    return _dataArray.count+firstDay.date.weekday-1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CalendarCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    DatePriceModel *firstWeekDay = _dataArray[0];
    
    NSInteger weekDay = firstWeekDay.date.weekday-1;
    
    if(indexPath.row<weekDay)//小于第一天的cell，空的
    {
        cell.state = CalendarCellNull2;
        cell.date = nil;
    }
    else
    {
        DatePriceModel *curDate = _dataArray[indexPath.row-weekDay];
        
        cell.date = curDate.date;
        cell.price = curDate.price;
        
        if([curDate.date isLessDate:_today])//小于今天的cell，灰的，不可选
        {
            cell.state = CalendarCellOver2;
        }
        else//大于等于今天的
        {
            if(curDate.state==0)//不可订
            {
                cell.state = CalendarCellUnbook2;
            }
            else//可订
            {
                cell.state = CalendarCellNormal2;
            }
        }
    }
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}








@end
