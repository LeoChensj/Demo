//
//  HomeViewController.h
//
//
//
//

#import <UIKit/UIKit.h>
#import "LLSimpleCamera.h"
#import "GuiderView.h"

#import "FaceVerificationViewModel.h"
#import "PhotoAlbumUtil.h"
#import "KXPicModel.h"
#import "CanFaceVerificationRequest.h"
#import "QiniuTokenRequest.h"
#import "LeoUploadQiniuManager.h"
#import "FaceVerificationRequest.h"
#import "STAlertView.h"
#import "CardVerificationViewController.h"

@interface CameraViewController : UIViewController <LLSimpleCameraDelegate>
{
    int  seconds;
    NSTimer   *miaotimer1;
    
    AMTumblrHud *tumblrHUD;
}

@property (nonatomic, strong)UIWindow  *guideview;


@property (nonatomic, strong)FaceVerificationViewModel *viewModel;
@property (nonatomic, strong)NSMutableArray <KXPicModel *>*picModels;
@property (nonatomic, strong)STAlertView *alertView;

@end


