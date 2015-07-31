//
//  TTYMessageAbstract.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 14.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYObject.h"

@class TTYFriend;
@class TTYChat;
@class TTYMessageText;
@class TTYMessageFile;

/**
 * An abstract message that represents one chunk of chat history.
 *
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYMessageAbstract : TTYObject

/**
 * The date interval when message was send/received.
 */
@property NSTimeInterval dateInterval;

/**
 * The sender of the message. If the message if outgoing sender is nil.
 */
@property TTYFriend *sender;

/**
 * The chat message message belongs to.
 */
@property TTYChat *chat;

/**
 * Message has one of the following properties.
 */
@property TTYMessageText *messageText;
@property TTYMessageFile *messageFile;

/**
 * The date when message was send/received.
 */
- (NSDate *)date;

/**
 * Indicates if message is outgoing or incoming.
 * In case if it is incoming you can check `sender` property for message sender.
 */
- (BOOL)isOutgoing;

@end

RLM_ARRAY_TYPE(TTYMessageAbstract)
