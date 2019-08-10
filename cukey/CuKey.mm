#import "CuKey_prefsheader.h"



@implementation CuKeyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/CuKey.bundle/CuKeyLogo.png"];
    self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.headerView addSubview:self.headerImageView];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
                                              [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
                                              [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
                                              [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
                                              ]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
+ (NSString *)hb_specifierPlist {
    return @"CuKey";
    
}

-(void)listThatDir {
    directoryKBContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/CuKey/KeyboardSounds/" error:NULL];
}

//share button
-(void)loadView {
    [super loadView];
 [self listThatDir];
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(shareTapped)];
	
	/* Uncomment this if you want large titles for iOS 11 and higher!
self.navigationController.navigationBar.prefersLargeTitles = YES;
self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic; */
	
}

//tint color to use for toggles and buttons 
+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:43.0/255.0 green: 47.0/255.0 blue: 70.0/255.0 alpha:1.0];
}

//share button action 
- (void)shareTapped {
   
	 NSString *shareText = @"Check out #CuKey by @iKilledAppl3! It changes various UISounds with ease! Download today on the @iospackixrepo! https://cydia.saurik.com/api/share#?source=https://repo.packix.com/&package=com.ikilledappl3.roxanne";
	 NSArray * itemsToShare = @[shareText];
	 
    	UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
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
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.rightBarButtonItem;
 
}
-(void)respring {
  //thanks to @skittyblock no more system deprecation errors :P
  NSTask *task = [[[NSTask alloc] init] autorelease];
  [task setLaunchPath:@"/usr/bin/killall"];
  [task setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
  [task launch];
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
