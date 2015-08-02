//
//  TTYChat.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 25.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYObject.h"
#import "TTYMessage.h"
#import "TTYFriend.h"

@class TTYMessageAbstract;

/**
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYChat : TTYObject

/**
 * Arbitrary title of the chat thread. Default is list of friends names.
 */

@property NSString *title;


/**
 * Array with TTYFriends that participate in this chat.
 */
@property RLMArray<TTYFriend> *friends;

/**
 * The latest message that was send or received.
 */

@property RLMArray<TTYMessage> *messages;

@property TTYMessage *lastMessage;

/**
 * This property can be used for storing entered text that wasn't send yet.
 *
 * To change please use TTYSubmanagerObjects method.
 *
 * May be empty.
 */
@property NSString *enteredText;

/**
 * This property stores last date interval when chat was read.
 * `hasUnreadMessages` method use lastReadDateInterval to determine if there are unread messages.
 *
 * To change please use TTYSubmanagerObjects method.
 */
@property NSTimeInterval lastReadDateInterval;

/**
 * Date interval of lastMessage or chat creationDate if there is no last message.
 *
 * This property is workaround to support sorting. Should be replaced with keypath
 * lastMessage.dateInterval sorting in future.
 * See https://github.com/realm/realm-cocoa/issues/1277
 */
@property NSTimeInterval lastActivityDateInterval;

/**
 * The date when chat was read last time.
 */
- (NSDate *)lastReadDate;

/**
 * Returns date of lastMessage or chat creationDate if there is no last message.
 */
- (NSDate *)lastActivityDate;

/**
 * If there are unread messages in chat YES is returned. All messages that have date later than lastReadDateInterval
 * are considered as unread.
 *
 * Please note that you have to set lastReadDateInterval to make this method work.
 *
 * @return YES if there are unread messages, NO otherwise.
 */
- (BOOL)hasUnreadMessages;

@end

RLM_ARRAY_TYPE(TTYChat)
