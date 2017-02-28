//
//  CameraViewController.h
//
//
//
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    CameraPositionBack,
    CameraPositionFront
} CameraPosition;

typedef enum : NSUInteger {
    CameraFlashOn,
    CameraFlashOff
} CameraFlash;

typedef enum : NSUInteger {
    CameraQualityLow,
    CameraQualityMedium,
    CameraQualityHigh,
    CameraQualityPhoto
} CameraQuality;

@protocol LLSimpleCameraDelegate;

@interface LLSimpleCamera : UIViewController

/**
The LLSimpleCameraDelegate delegate.
 */
@property (nonatomic, weak) id<LLSimpleCameraDelegate> delegate;

/**
 The status of the camera flash.
 */
@property (nonatomic) CameraFlash cameraFlash;
/**
 The position of the camera.
 */
@property (nonatomic) CameraPosition cameraPosition;


@property (nonatomic) BOOL fixOrientationAfterCapture;


- (instancetype)initWithQuality:(CameraQuality)quality;

/**
 Starts running the camera session.
 */
- (void)start;

/**
 Stops the running camera session. Needs to be called when the app doesn't show the view.
 */
- (void)stop;

- (void)attachToViewController:(UIViewController *)vc withDelegate:(id<LLSimpleCameraDelegate>)delegate;

/**
 Changes the posiition of the camera (either back or front) and returns the final position.
 */
- (CameraPosition)togglePosition;

/**
 Toggles the flash. If the device doesn't have a flash it returns CameraFlashOff.
 */
- (CameraFlash)toggleFlash;

/**
 Checks if flash is avilable for the currently active device.
 */
- (BOOL)isFlashAvailable;

/**
 Capture the image.
 */
- (void)capture;






@end

@protocol LLSimpleCameraDelegate <NSObject>
/**
 Triggered when the active camera device is changed. Programmer can use isFlashAvailable to check if the flash
 is available and show the related icons.
 */
- (void)cameraViewController:(LLSimpleCamera*)cameraVC
             didChangeDevice:(AVCaptureDevice *)device;

/**
 Triggered after the image is captured by the camera.
 */
- (void)cameraViewController:(LLSimpleCamera*)cameraVC
             didCaptureImage:(UIImage *)image;
@end

