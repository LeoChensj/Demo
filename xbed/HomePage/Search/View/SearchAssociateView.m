//
//  SearchAssociateView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchAssociateView.h"

@implementation SearchAssociateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectView;
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(12);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setAssociateContent:(NSString *)associateContent
{
    _associateContent = associateContent;
    
    NSString *string = _title;
    NSRange range = [string rangeOfString:associateContent];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:(NSString *)NSForegroundColorAttributeName value:Blue_Color range:range];
    
    _lbTitle.attributedText = attString;
}

@end




@implementation SearchAssociateView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 49;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _lbNoResult = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*0.5-75, 15, 150, 13)];
        _lbNoResult.text = @"关键词无搜索结果";
        _lbNoResult.textAlignment = NSTextAlignmentCenter;
        _lbNoResult.textColor = Secondary_Text_Color2;
        _lbNoResult.font = Font(13);
        [self addSubview:_lbNoResult];
        _lbNoResult.hidden = YES;
    }
    
    return self;
}

- (void)setDataArray:(NSArray<SearchDataModel *> *)dataArray
{
    _dataArray = dataArray;
    
    if(_dataArray==nil)
    {
        self.hidden = YES;
        _lbNoResult.hidden = YES;
    }
    else
    {
        self.hidden = NO;
        
        if(dataArray.count==0 && self.associateContent.length)
        {
            _lbNoResult.hidden = NO;
        }
        else
        {
            _lbNoResult.hidden = YES;
        }
        
        [self reloadData];
    }
}

- (void)addSearchAssociateViewDidSelectRowBlock:(SearchAssociateViewDidSelectRowBlock)block
{
    _block = block;
}



#pragma - TableView DataSourse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray[section].datalist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    SearchAssociateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[SearchAssociateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(SearchAssociateCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.title = [NSString stringWithFormat:@"%@ · %@", _dataArray[indexPath.section].datalist[indexPath.row].cname, _dataArray[indexPath.section].datalist[indexPath.row].city];
    cell.associateContent = _associateContent;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = Background_Color;
    
    UILabel *lbHeader = [[UILabel alloc] init];
    lbHeader.text = _dataArray[section].title;
    lbHeader.textColor = Main_Text_Color;
    lbHeader.font = FontBold(14);
    [header addSubview:lbHeader];
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        
    }];
    
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    if(_block)
    {
        _block(self, _dataArray[indexPath.section].datalist[indexPath.row], indexPath);
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}



@end
