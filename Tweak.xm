#import "CuKey_header.h"


NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yakir.cukey.plist"];
NSString* keyboardColor = [prefs objectForKey:@"keyboardColor"];



%hook _UIKBCompatInputView

-(void) layoutSubviews {
if (kUseDefaultCOLOR) {
%orig;
self.backgroundColor = LCPParseColorString(keyboardColor, @"#2b2f46");

}
}
%end
/*
%hook UIKBSplitImageView

-(void) layoutSubviews {
if (kUseDefaultCOLOR) {
%orig;
self.backgroundColor = LCPParseColorString(keyboardColor, @"#2b2f46");

}
}
%end

*/
%hook UIKBRenderConfig

-(BOOL)lightKeyboard {

return 0;

}

-(BOOL) whiteText {
return 1;
}

%end



%hook UIKeyboardLayoutStar
-(void)playKeyClickSoundOnDownForKey:(UIKBTree *)key {

	if (kEnabled && !kUseDefaultKB) {


            SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/CuKey/KeyboardSounds/%@",kKBSounds]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);




}
	
	

}

-(void)setPlayKeyClickSoundOn:(int)arg1 {
	if (kEnabled && !kUseDefaultKB) {

	            UIKBTree *delKey = [%c(UIKBTree) key];
				NSString *myDelKeyString = [delKey name];

		 if ([myDelKeyString isEqualToString:@"Delete-Key"]) {
		// We are doing this to silence the delete key by default for custom sounds :P
		// Don't think people will care about this lol XD
            
		
      }
}

	else {
		%orig;
	}
}

%end


extern NSString *const HBPreferencesDidChangeNotification;

%ctor {



%init(_ungrouped);
 
    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.yakir.cukey"];

	[preferences registerBool:&kEnabled default:NO forKey:@"kEnabled"];


	[preferences registerObject:& kKBSounds default:nil forKey:@"kKBSounds"];
	[preferences registerBool:& kUseDefaultKB default:NO forKey:@"kUseDefaultKB"];
[preferences registerBool:& kUseDefaultCOLOR default:NO forKey:@"kUseDefaultCOLOR"];





}
