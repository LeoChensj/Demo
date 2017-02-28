//
//  CheckinCleanRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CheckinCleanTimeItemModel : XbedRespModel

@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSNumber *state;

@end

@interface CheckinCleanTimeModel : XbedRespModel

@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*today;
@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*tomorrow;

@end

@interface CheckinCleanStarTermListModel : XbedRespModel

@property (nonatomic, strong)NSNumber *termId;
@property (nonatomic, strong)NSString *termName;

@end

@interface CheckinCleanStarTermModel : XbedRespModel

@property (nonatomic, strong)NSNumber *star;
@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <CheckinCleanStarTermListModel *>*termList;

@end

@interface CheckinCleanEvaluationModel : XbedRespModel

@property (nonatomic, strong)NSArray <CheckinCleanStarTermModel *>*cleanStarTerm;
@property (nonatomic, strong)NSString *head;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *score;

@end

@interface CheckinCleanDataModel : XbedRespModel

@property (nonatomic, strong)CheckinCleanEvaluationModel *cleanEvaluation;
@property (nonatomic, strong)CheckinCleanTimeModel *cleanTime;
@property (nonatomic, strong)NSNumber *type;

@end

@interface CheckinCleanRespModel : XbedRespModel

@property (nonatomic, strong)CheckinCleanDataModel *data;

@end
