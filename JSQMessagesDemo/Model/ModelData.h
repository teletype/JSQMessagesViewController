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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Realm/Realm.h>

#import "JSQMessages.h"


static NSString * const kJSQDemoAvatarDisplayNameSquires = @"Jesse Squires";
static NSString * const kJSQDemoAvatarDisplayNameMyself = @"Myself";
static NSString * const kJSQDemoAvatarDisplayNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarDisplayNameJobs = @"Jobs";
static NSString * const kJSQDemoAvatarDisplayNameWoz = @"Steve Wozniak";
static NSString * const kJSQDemoAvatarDisplayNameBot = @"Uber Bot";

static NSString * const kJSQDemoAvatarIdSquires = @"053496-4509-289";
static NSString * const kJSQDemoAvatarIdMyself = @"xxx";
static NSString * const kJSQDemoAvatarIdCook = @"468-768355-23123";
static NSString * const kJSQDemoAvatarIdJobs = @"707-8956784-57";
static NSString * const kJSQDemoAvatarIdWoz = @"309-41802-93823";
static NSString * const kJSQDemoAvatarIdBot = @"309-41802-12345";


@interface ModelData : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *chats;

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSDictionary *users;

- (void)addPhotoMediaMessage;

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)addVideoMediaMessage;

- (void)addHealthMediaMessage;

- (void)addResponse:(JSQMessage *)message;

- (void)loadFakeMessages;

@end


@interface Avatar : RLMObject

@property NSString *displayName;
@property NSString *avatarId;
//@property UIImage *image;
//@property JSQMessagesAvatarImage *image;
@property NSDate *date;
@end

RLM_ARRAY_TYPE(Avatar)

@interface Message : RLMObject
//@property NSTimeInterval dateInterval;
@property Avatar *sender;
@property NSString *messageText;
@property NSDate *date;
@end

RLM_ARRAY_TYPE(Message)

@interface Chat : RLMObject
@property NSString *title;
@property NSDate   *date;
@property Message  *lastMessage;
@property RLMArray<Avatar> *avatars;
@property RLMArray<Message> *messages;
@end


