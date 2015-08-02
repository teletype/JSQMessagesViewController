//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//


// Import all the things
#import "JSQMessages.h"

#ifdef NUANCE
#import <SpeechKit/SpeechKit.h>
#endif
#import <CoreLocation/CoreLocation.h>

#import "AppDelegate.h"

#import "ModelData.h"
#import "NSUserDefaults+DemoSettings.h"
#import "GMImagePickerController.h"


@class DemoMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>


- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc;

@end

#ifdef NUANCE
@interface DemoMessagesViewController : JSQMessagesViewController <UIActionSheetDelegate,CLLocationManagerDelegate,SpeechKitDelegate, SKRecognizerDelegate,SKVocalizerDelegate>
#else
@interface DemoMessagesViewController : JSQMessagesViewController <UIActionSheetDelegate,GMImagePickerControllerDelegate>
#endif

@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSDictionary *avatars;
@property (strong, nonatomic) Avatar *avatar;
@property (strong, nonatomic) Chat *chat;




#ifdef NUANCE
@property (strong, nonatomic) SKRecognizer* voiceSearch;
@property (strong, nonatomic) SKVocalizer* vocalizer;
@property BOOL isSpeaking;
#endif

- (void)loadMessages:(Chat *)chat;
- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;

@end
