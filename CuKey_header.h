//headers we need! 
#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#include <libcolorpicker.h>



//see if tweak is enabled!
BOOL kEnabled;



//default sound switches 

BOOL kUseDefaultKB;
BOOL kUseDefaultCOLOR;



HBPreferences *preferences;



//delete key file :P
NSString *deleteKeyFile = [[NSBundle bundleWithPath:@"/System/Library/Audio/UISounds/"] pathForResource:@"key_press_delete" ofType:@"caf"];

//volume control string :P
NSString *kKBSounds;

AVAudioSession *session = [AVAudioSession sharedInstance];

//interfaces 


@interface _UIKBCompatInputView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

@interface UIKeyboardDicationBackground
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end
@interface UIKBSplitImageView
    @property (nonatomic, copy, readwrite) UIColor *backgroundColor;
    
    @end

@interface UIKBRenderConfig
@property (nonatomic, assign, readwrite) BOOL lightKeyboard;
@property (nonatomic, assign, readwrite) BOOL whiteText;
@end

@interface _UIKBRenderFactory
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end



@interface UIKBTree : NSObject
@property (nonatomic, strong, readwrite) NSString * name;
+(id)sharedInstance;
+(id)key;
@end

@interface UIKeyboardLayoutStar : UIView
@property (nonatomic, copy) NSString * localizedInputKey;
-(void)setPlayKeyClickSoundOn:(int)arg1;
@end
