//
//  RoomEvaluateListView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateListView.h"
#import "BKPhotoBrowser.h"

@implementation RoomEvaluateListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgvHead = [[UIImageView alloc] init];
        _imgvHead.layer.masksToBounds = YES;
        _imgvHead.layer.cornerRadius = 29;
        [self.contentView addSubview:_imgvHead];
        [_imgvHead mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(59);
            make.height.mas_equalTo(59);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            
        }];
        
        _lbPhone = [[UILabel alloc] init];
        _lbPhone.textColor = Main_Text_Color;
        _lbPhone.font = Font(16);
        [self.contentView addSubview:_lbPhone];
        [_lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(10);
            make.top.mas_equalTo(15);
            
        }];
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.textColor = Secondary_Text_Color2;
        _lbDate.textAlignment = NSTextAlignmentRight;
        _lbDate.font = Font(16);
        [self.contentView addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(15);
            
        }];
        
        _lbScore = [[UILabel alloc] init];
        _lbScore.textColor = Orange_Color;
        _lbScore.font = Font(16);
        [self.contentView addSubview:_lbScore];
        [_lbScore mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(10);
            make.bottom.mas_equalTo(_imgvHead.mas_bottom).offset(0);
            
        }];
        
        
        _tagsView = [[RoomEvaluateListTagsView alloc] init];
        [self.contentView addSubview:_tagsView];
        [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-84);
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(79);
            make.top.mas_equalTo(_lbScore.mas_bottom).offset(15);
            
        }];
        
        
        _lbComment = [[UILabel alloc] init];
        _lbComment.numberOfLines = 0;
        _lbComment.textColor = Main_Text_Color;
        _lbComment.font = Font(13);
        [self.contentView addSubview:_lbComment];
        [_lbComment mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-89);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(10);
            make.top.mas_equalTo(_tagsView.mas_bottom).offset(0);
            
        }];
        
        
        
        CGFloat imageWidth = (MAIN_SCREEN_WIDTH-89-15)/4;
        CGFloat imageHeight = imageWidth*2/3;
        
        _imgv1 = [[UIImageView alloc] init];
        _imgv1.tag = 187+0;
        _imgv1.userInteractionEnabled = YES;
        _imgv1.contentMode = UIViewContentModeScaleAspectFill;
        _imgv1.clipsToBounds = YES;
        [self.contentView addSubview:_imgv1];
        [_imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(10);
            make.top.mas_equalTo(_lbComment.mas_bottom).offset(10);
            
        }];
        
        _imgv2 = [[UIImageView alloc] init];
        _imgv2.tag = 187+1;
        _imgv2.userInteractionEnabled = YES;
        _imgv2.contentMode = UIViewContentModeScaleAspectFill;
        _imgv2.clipsToBounds = YES;
        [self.contentView addSubview:_imgv2];
        [_imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.left.mas_equalTo(_imgv1.mas_right).offset(5);
            make.top.mas_equalTo(_lbComment.mas_bottom).offset(10);
            
        }];
        
        _imgv3 = [[UIImageView alloc] init];
        _imgv3.tag = 187+2;
        _imgv3.userInteractionEnabled = YES;
        _imgv3.contentMode = UIViewContentModeScaleAspectFill;
        _imgv3.clipsToBounds = YES;
        [self.contentView addSubview:_imgv3];
        [_imgv3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.left.mas_equalTo(_imgv2.mas_right).offset(5);
            make.top.mas_equalTo(_lbComment.mas_bottom).offset(10);
            
        }];
        
        _imgv4 = [[UIImageView alloc] init];
        _imgv4.tag = 187+3;
        _imgv4.userInteractionEnabled = YES;
        _imgv4.contentMode = UIViewContentModeScaleAspectFill;
        _imgv4.clipsToBounds = YES;
        [self.contentView addSubview:_imgv4];
        [_imgv4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.left.mas_equalTo(_imgv3.mas_right).offset(5);
            make.top.mas_equalTo(_lbComment.mas_bottom).offset(10);
            
        }];
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-89);
            make.height.mas_equalTo(LINE_WIDTH);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(_imgv1.mas_bottom).offset(10);
            
        }];
        
        
        
        _lbService = [[UILabel alloc] init];
        _lbService.text = @"客服回复：";
        _lbService.textColor = Main_Text_Color;
        _lbService.font = Font(12);
        [self.contentView addSubview:_lbService];
        [_lbService mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_line.mas_bottom).offset(15);
            
        }];
        
        
        _vReplyContent = [[UIView alloc] init];
        _vReplyContent.backgroundColor = Background_Color;
        [self.contentView addSubview:_vReplyContent];
        [_vReplyContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-89);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(10);
            make.top.mas_equalTo(_lbService.mas_top).offset(0);
            
            
        }];
        
        
        _lbReplyContent = [[UILabel alloc] init];
        _lbReplyContent.numberOfLines = 0;
        _lbReplyContent.textColor = Secondary_Text_Color;
        _lbReplyContent.font = Font(12);
        [self.contentView addSubview:_lbReplyContent];
        [_lbReplyContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-89-10);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(_vReplyContent.mas_left).offset(5);
            make.top.mas_equalTo(_vReplyContent.mas_top).offset(10);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(RoomCommentListModel *)model
{
    _model = model;
    
    NSString *headStr = [NSString stringWithFormat:@"%@?imageView2/2/w/80", model.headImage];
    [_imgvHead sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:PlaceholderImage];
    
    
    _lbPhone.text = model.phone;
    _lbDate.text = [NSString stringWithFormat:@"%ld-%02ld-%02ld", model.createDate.year, model.createDate.month, model.createDate.day];
    _lbScore.text = [NSString stringWithFormat:@"%.1f分", (model.roomGrade.floatValue+model.cleanGrade.floatValue)*0.5];
    
    _tagsView.dataArray = model.tags;
    
    
    if(model.content.length)
    {
        _lbComment.textColor = Main_Text_Color;
        _lbComment.text = model.content;
        _lbComment.lineSpace = 6;
        CGSize commentSize = [_lbComment labelSize:MAIN_SCREEN_WIDTH-89];
        [_lbComment mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(commentSize.height);
            
        }];
    }
    else
    {
        _lbComment.textColor = Secondary_Text_Color;
        _lbComment.text = @"该用户没有填写详细评论！";
        [_lbComment mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(13);
            
        }];
    }
    
    
    
    if(model.pictures==nil || model.pictures.count==0)
    {
        _imgv1.hidden = YES;
        _imgv2.hidden = YES;
        _imgv3.hidden = YES;
        _imgv4.hidden = YES;
        
        [_imgv1 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_imgv2 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_imgv3 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_imgv4 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        CGFloat imageWidth = (MAIN_SCREEN_WIDTH-89-15)/4;
        CGFloat imageHeight = imageWidth*2/3;
        
        if(model.pictures.count>=1)
        {
            NSString *picStr = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", model.pictures[0], (NSInteger)((MAIN_SCREEN_WIDTH-89-30)*0.5)];
            [_imgv1 sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:PlaceholderImage];
            
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc:)];
            [_imgv1 addGestureRecognizer:tapImage];
            
            _imgv1.hidden = NO;
            
            [_imgv1 mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(imageHeight);
                
            }];
        }
        
        if(model.pictures.count>=2)
        {
            NSString *picStr = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", model.pictures[1], (NSInteger)((MAIN_SCREEN_WIDTH-89-30)*0.5)];
            [_imgv2 sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:PlaceholderImage];
            
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc:)];
            [_imgv2 addGestureRecognizer:tapImage];
            
            _imgv2.hidden = NO;
            
            [_imgv2 mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(imageHeight);
                
            }];
        }
        
        if(model.pictures.count>=3)
        {
            NSString *picStr = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", model.pictures[2], (NSInteger)((MAIN_SCREEN_WIDTH-89-30)*0.5)];
            [_imgv3 sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:PlaceholderImage];
            
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc:)];
            [_imgv3 addGestureRecognizer:tapImage];
            
            _imgv3.hidden = NO;
            
            [_imgv3 mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(imageHeight);
                
            }];
        }
        
        if(model.pictures.count>=4)
        {
            NSString *picStr = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", model.pictures[3], (NSInteger)((MAIN_SCREEN_WIDTH-89-30)*0.5)];
            [_imgv4 sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:PlaceholderImage];
            
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc:)];
            [_imgv4 addGestureRecognizer:tapImage];
            
            _imgv4.hidden = NO;
            
            [_imgv4 mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(imageHeight);
                
            }];
        }
    }
    
    
    
    if(model.replyContent.length)
    {
        _line.hidden = NO;
        _lbService.hidden = NO;
        _vReplyContent.hidden = NO;
        _lbReplyContent.hidden = NO;
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 3;
        paraStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attribute = @{NSFontAttributeName : Font(12),
                                    NSParagraphStyleAttributeName : paraStyle};
        
        CGSize labelSize = [model.replyContent boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-89-10, CGFLOAT_MAX)
                                                                                    options:NSStringDrawingTruncatesLastVisibleLine |
                            NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingUsesFontLeading
                                                                                 attributes:attribute
                                                                                    context:nil].size;
        
        _lbReplyContent.text = model.replyContent;
        _lbReplyContent.lineSpace = 3;
        
        [_lbReplyContent mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(ceil(labelSize.height));
            
        }];
        
     
        [_vReplyContent mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(ceil(labelSize.height)+20);
            
        }];
     
    }
    else
    {
        _line.hidden = YES;
        _lbService.hidden = YES;
        _vReplyContent.hidden = YES;
        _lbReplyContent.hidden = YES;
    }
}


- (void)tapImageFunc:(UIGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)gesture.view;
    NSInteger index = imageView.tag-187;
    
    NSMutableArray <BKPhotoItem *>*items = [NSMutableArray array];
    for(NSInteger i=0;i<self.model.pictures.count;i++)
    {
        BKPhotoItem *item = [[BKPhotoItem alloc] init];
        item.originImageUrl = [NSURL URLWithString:self.model.pictures[i]];
        
        if(i==0)
            item.thumbView = _imgv1;
        else if(i==1)
            item.thumbView = _imgv2;
        else if(i==2)
            item.thumbView = _imgv3;
        else if(i==3)
            item.thumbView = _imgv4;
        
        [items addObject:item];
    }
    
    BKPhotoBrowser *photoBrowser = [[BKPhotoBrowser alloc] initWithPhotoItems:items];
    photoBrowser.shouldShowPageControl = YES;
    photoBrowser.pageType = bottomPageCtrType;
    [photoBrowser showFromImageView:imageView andCurrentIndex:index completion:nil];
}


@end




@implementation RoomEvaluateListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;
        self.scrollEnabled = NO;
        //self.rowHeight = UITableViewAutomaticDimension;
        //self.estimatedRowHeight = 268;
    }
    
    return self;
}

- (void)setDataArray:(NSArray<RoomCommentListModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(self.contentSize.height);
        
    }];
}





#pragma - TableView DataSourse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 74;
    
    if(_dataArray[indexPath.section].tags.count)
    {
        height = height+[self tagsViewHeightWithDataArray:_dataArray[indexPath.section].tags];
    }
    
    if(_dataArray[indexPath.section].content.length)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 6;
        paraStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attribute = @{NSFontAttributeName : Font(13),
                                    NSParagraphStyleAttributeName : paraStyle};
        
        CGSize labelSize = [_dataArray[indexPath.section].content boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-89, CGFLOAT_MAX)
                                                                           options:NSStringDrawingTruncatesLastVisibleLine |
                            NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingUsesFontLeading
                                                                        attributes:attribute
                                                                           context:nil].size;
        
        height = height+ceil(labelSize.height);
    }
    else
    {
        height = height+13;
    }
    
    height = height+10;
    
    
    if(_dataArray[indexPath.section].pictures.count>0)
    {
        CGFloat imageWidth = (MAIN_SCREEN_WIDTH-89-15)/4;
        CGFloat imageHeight = imageWidth*2/3;
        
        height = height+imageHeight;
    }
    
    height = height+10;
    
    if(_dataArray[indexPath.section].replyContent.length)
    {
        height = height+15;
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 3;
        paraStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attribute = @{NSFontAttributeName : Font(12),
                                    NSParagraphStyleAttributeName : paraStyle};
        
        CGSize labelSize = [_dataArray[indexPath.section].replyContent boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-89-10, CGFLOAT_MAX)
                                                                           options:NSStringDrawingTruncatesLastVisibleLine |
                            NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingUsesFontLeading
                                                                        attributes:attribute
                                                                           context:nil].size;
        
        height = height+(ceil(labelSize.height)+35);
    }
    
    height = height+20;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    RoomEvaluateListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[RoomEvaluateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(RoomEvaluateListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.section];
}




#pragma mark - help
- (CGFloat)tagsViewHeightWithDataArray:(NSArray <NSString *>*)dataArray
{
    if(dataArray.count)
    {
        CGFloat maxWidth = MAIN_SCREEN_WIDTH-84;
        CGFloat width = 0;
        CGFloat row = 1;
        
        for (NSInteger i=0;i<dataArray.count;i++)
        {
            width = width+(dataArray[i].length*12+24)+10;
            
            if(width-10>maxWidth)
            {
                row = row+1;
                width = (dataArray[i].length*12+24)+10;
            }
        }
        
        return row*34;
    }
    
    return 0;
}




@end
