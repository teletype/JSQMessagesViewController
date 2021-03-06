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

#import "ModelData.h"

#import "NSUserDefaults+DemoSettings.h"
@import AVFoundation;

NSString * const randomResponse[] = { @"Please pay me twenty bucks", @"Where to, Sir?", @"Thank you I recieved your payment"};


@implementation Avatar
@end

@implementation Message
@end

@implementation Chat
@end

@interface ModelData () <AVSpeechSynthesizerDelegate>
@property (readwrite, nonatomic, copy) NSString *utteranceString;
@property (readwrite, nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;
@end

@implementation ModelData

CLLocationManager *locationManager;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /**
         *  Create avatar images once.
         *
         *  Be sure to create your avatars one time and reuse them for good performance.
         *
         *  If you are not using avatars, ignore this.
         */
        
        // Do this for all the contacts
        
        JSQMessagesAvatarImage *jsqImage = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:@"JSQ"
                                                                                      backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                                                            textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                                                 font:[UIFont systemFontOfSize:14.0f]
                                                                                             diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *myselfImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_myself"]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        JSQMessagesAvatarImage *cookImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *jobsImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *wozImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        JSQMessagesAvatarImage *botImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_bot"]
                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        
        self.avatars = @{ kJSQDemoAvatarIdSquires : jsqImage,
                          kJSQDemoAvatarIdCook : cookImage,
                          kJSQDemoAvatarIdJobs : jobsImage,
                          kJSQDemoAvatarIdWoz : wozImage,
                          kJSQDemoAvatarIdMyself : myselfImage,
                          kJSQDemoAvatarIdBot : botImage };
    
    
        self.users = @{ kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
                        kJSQDemoAvatarIdCook : kJSQDemoAvatarDisplayNameCook,
                        kJSQDemoAvatarIdWoz : kJSQDemoAvatarDisplayNameWoz,
                        kJSQDemoAvatarIdBot : kJSQDemoAvatarDisplayNameBot,
                        kJSQDemoAvatarIdMyself : kJSQDemoAvatarDisplayNameMyself,
                        kJSQDemoAvatarIdSquires : kJSQDemoAvatarDisplayNameSquires };
        
        
        /**
         *  Create message bubble images objects.
         *
         *  Be sure to create your bubble images one time and reuse them for good performance.
         *
         */
        
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
        
        
        self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        self.speechSynthesizer.delegate = self;
        
        // if empty load some fake messages
        
        if ([Chat allObjects].count==0)
            [self loadFakeMessages];

    }
    
    return self;
}

- (void)loadFakeMessages
{
    /**
     *  Load some fake messages for demo.
     *
     *  You should have a mutable array or orderedSet, or something.
     */
    
    
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
        Avatar *myself = [Avatar createInRealm:realm withValue:@{@"displayName": kJSQDemoAvatarDisplayNameMyself,
                                                           @"avatarId": kJSQDemoAvatarIdMyself,
                                                           // @"image": [UIImage imageNamed:@"demo_avatar_jobs"],
                                                           @"date": [NSDate date]}];
       Avatar *jobs = [Avatar createInRealm:realm withValue:@{@"displayName": kJSQDemoAvatarDisplayNameJobs,
                                                           @"avatarId": kJSQDemoAvatarIdJobs,
                                                           // @"image": [UIImage imageNamed:@"demo_avatar_jobs"],
                                                           @"date": [NSDate date]}];
        Avatar *woz = [Avatar createInRealm:realm withValue:@{@"displayName": kJSQDemoAvatarDisplayNameWoz,
                                                              @"avatarId": kJSQDemoAvatarIdWoz,
                                                             // @"image": [UIImage imageNamed:@"demo_avatar_woz"],
                                                              @"date": [NSDate date]}];
        Avatar *cook = [Avatar createInRealm:realm withValue:@{@"displayName": kJSQDemoAvatarDisplayNameCook,
                                                               @"avatarId": kJSQDemoAvatarIdCook,
                                                              // @"image": [UIImage imageNamed:@"demo_avatar_cook"],
                                                               @"date": [NSDate date]}];
        Avatar *bot = [Avatar createInRealm:realm withValue:@{@"displayName": kJSQDemoAvatarDisplayNameBot,
                                                               @"avatarId": kJSQDemoAvatarIdBot,
                                                              // @"image": [UIImage imageNamed:@"demo_avatar_bot"],
                                                               @"date": [NSDate date]}];
        
        
        Message *messageWoz = [Message createInRealm:realm  withValue:@{@"sender":woz,@"messageText":@"Hi there cowboy!",@"date":[NSDate date]}];
                                                                     
        
        Chat *chatWoz = [Chat createInRealm:realm  withValue:@{@"title": kJSQDemoAvatarDisplayNameWoz,@"date":[NSDate date]}];
        [chatWoz.avatars addObject:woz];
        [chatWoz.messages addObject:messageWoz];
        
        chatWoz.lastMessage = messageWoz;
        
        Chat *chatJobs = [Chat createInRealm:realm  withValue:@{@"title": kJSQDemoAvatarDisplayNameJobs,@"date":[NSDate date]}];
        [chatJobs.avatars addObject:jobs];
        Message *messageJobs = [Message createInRealm:realm  withValue:@{@"sender":jobs,@"messageText":@"I am dead. How are you?",@"date":[NSDate date]}];
        [chatJobs.messages addObject:messageJobs];
        chatJobs.lastMessage = messageJobs;
        
        Chat *chatBot = [Chat createInRealm:realm  withValue:@{@"title": kJSQDemoAvatarDisplayNameBot,@"date":[NSDate date]}];
        [chatBot.avatars addObject:bot];
        Message *messageBot = [Message createInRealm:realm  withValue:@{@"sender":bot,@"messageText":@"A very good day to you Sir. Where do you want to go today?",@"date":[NSDate date]}];
        [chatBot.messages addObject:messageBot];
        chatBot.lastMessage = messageBot;
       
    
        [realm commitWriteTransaction];
  

        
    self.messages = [[NSMutableArray alloc] init];
    
  /*
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate distantPast]
                                                     text:@"Welcome to JSQMessages: A messaging UI framework for iOS."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdWoz
                                        senderDisplayName:kJSQDemoAvatarDisplayNameWoz
                                                     date:[NSDate distantPast]
                                                     text:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate distantPast]
                                                     text:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdJobs
                                        senderDisplayName:kJSQDemoAvatarDisplayNameJobs
                                                     date:[NSDate date]
                                                     text:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdCook
                                        senderDisplayName:kJSQDemoAvatarDisplayNameCook
                                                     date:[NSDate date]
                                                     text:@"It is unit-tested, free, open-source, and documented."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate date]
                                                     text:@"Now with media messages!"],
                     nil];
    */
   // [self addPhotoMediaMessage];
    
    /**
     *  Setting to load extra messages for testing/demo
     */
    /*
    if ([NSUserDefaults extraMessagesSetting]) {
        NSArray *copyOfMessages = [self.messages copy];
        for (NSUInteger i = 0; i < 4; i++) {
            [self.messages addObjectsFromArray:copyOfMessages];
        }
    }
    */
    
    /**
     *  Setting to load REALLY long message for testing/demo
     *  You should see "END" twice
     */
    if ([NSUserDefaults longMessageSetting]) {
        JSQMessage *reallyLongMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                            displayName:kJSQDemoAvatarDisplayNameSquires
                                                                   text:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END"];
        
        [self.messages addObject:reallyLongMessage];
    }
}


- (void)addPhotoMediaMessage
{
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"goldengate"]];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                   displayName:kJSQDemoAvatarDisplayNameSquires
                                                         media:photoItem];
    [self.messages addObject:photoMessage];
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion
{
    
    if (!locationManager)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) { // iOS8+
        // Sending a message to avoid compile time error
        
        NSLog(@"requestWhenInUseAuthorization");
        [[UIApplication sharedApplication] sendAction:@selector(requestWhenInUseAuthorization)
                                                   to:locationManager
                                                 from:self
                                             forEvent:nil];
    }
    
    /*
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    */
    
    [locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:3.0];

    
 }

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog(@"didChangeAuthorizationStatus %d",status);
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse || status==kCLAuthorizationStatusAuthorizedAlways)
    {
        NSLog(@"Authorized location");
        
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
    }
}


- (void)locationManager:(CLLocationManager *)__unused manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)__unused oldLocation
{
    
    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    
    [locationItem setLocation:newLocation withCompletionHandler:nil];
    
   // [locationItem setLocation:newLocation withCompletionHandler:completion];
    
    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                      displayName:kJSQDemoAvatarDisplayNameSquires
                                                            media:locationItem];
    [self.messages addObject:locationMessage];
    
    
    [self stopUpdatingLocation:newLocation.description];
    
}

- (void)stopUpdatingLocation:(NSString *)state {
    NSLog(@"stopUpdatingLocation %@",state);
    [locationManager stopUpdatingLocation];
    
}
- (void)addVideoMediaMessage
{
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                   displayName:kJSQDemoAvatarDisplayNameSquires
                                                         media:videoItem];
    [self.messages addObject:videoMessage];
}

- (void)addHealthMediaMessage
{
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                   displayName:kJSQDemoAvatarDisplayNameSquires
                                                         media:videoItem];
    [self.messages addObject:videoMessage];
}

- (void)addResponse:(JSQMessage *)message;
{
    //[JSQSystemSoundPlayer jsq_playMessageReceivedSound];
    
    NSString *text = randomResponse[arc4random_uniform(3)];
    JSQMessage *response = [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdBot
                                             senderDisplayName:kJSQDemoAvatarDisplayNameBot
                                                          date:message.date
                                                          text:text];

    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:text];
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    //    utterance.pitchMultiplier = 0.5f;
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
    [self.messages addObject:response];

  
}

@end
