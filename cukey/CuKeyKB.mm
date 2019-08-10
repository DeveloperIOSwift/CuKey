#import "CuKeyKB.h"



@implementation CuKeyKBListController

+ (NSString *)hb_specifierPlist {

    return @"CuKeyKB";
    
}

-(void)listThatDir {
   directoryKBContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/CuKey/KeyboardSounds/" error:NULL];
}

-(void)loadView {
    [super loadView];

    [self listThatDir];

}

-(void)showExplanation:(UIAlertController *)expController {

expController = [UIAlertController alertControllerWithTitle:@"Keyboard Sounds" message:@"As of right now to make keyboard sounds work in 3rd-Party Apps You’ll need to install RocketBootstrap beta." preferredStyle:UIAlertControllerStyleAlert];
                          UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

UIAlertAction *installAction = [UIAlertAction actionWithTitle:@"Install RocketBootstrap" style:UIAlertActionStyleDefault
   handler:^(UIAlertAction * action) {
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=http://rpetri.ch/repo/&package=com.rpetrich.rocketbootstrap"] options:@{} completionHandler:nil];
}];
    

   [expController addAction: installAction];
     [expController addAction:alertAction];

                          [self presentViewController:expController animated:YES completion:nil];

}

- (void)setAndPreview:(id)value forSpecifier:(id)specifier {
// Sample sound and set
    AudioServicesDisposeSystemSoundID(soundSelected);
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/CuKey/KeyboardSounds/%@",value]],&soundSelected);
    AudioServicesPlaySystemSound(soundSelected);
    
    [super setPreferenceValue:value specifier:specifier];
}

- (NSArray *)getData:(id)target {
NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
    for (NSURL *fileURL in [directoryKBContent filteredArrayUsingPredicate:predicate]) {
	[listing addObject:fileURL];
    }
    return listing;
}

- (void)previewAndSet:(id)value forSpecifier:(id)specifier{
    // Sample sound and set
    AudioServicesDisposeSystemSoundID(selectedSound);
    AudioServicesPlaySystemSound(selectedSound);
    
    [super setPreferenceValue:value specifier:specifier];
}

// List our directory content
- (NSArray *)getValues:(id)target{
	NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
   
    return listing;
}
@end

// vim:ft=objc
