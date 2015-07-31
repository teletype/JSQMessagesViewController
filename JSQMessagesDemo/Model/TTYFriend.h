//
//  TTYFriend.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 10.03.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYObject.h"
#import "TTY.h"

/**
 * Class that represents friend (or just simply contact).
 *
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYFriend : TTYObject

/**
 * Friend number that is unique for Tox.
 * In case if friend will be deleted, old id may be reused on new friend creation.
 */
@property TTYFriendNumber friendNumber;

/**
 * Nickname of friend.
 *
 * When friend is created it is set to the publicKey.
 * It is set to name when obtaining name for the first time.
 * After that name is unchanged (unless it is changed explicitly).
 *
 * To change please use TTYSubmanagerObjects method.
 */
@property NSString *nickname;

/**
 * Public key of a friend, is kTTYToxPublicKeyLength length.
 * Is constant, cannot be changed.
 */
@property NSString *publicKey;

/**
 * Name of a friend.
 *
 * May be empty.
 */
@property NSString *name;

/**
 * Status message of a friend.
 *
 * May be empty.
 */
@property NSString *statusMessage;

/**
 * Status message of a friend.
 */
@property TTYUserStatus status;

/**
 * Property specifies if friend is connected. For type of connection you can check
 * connectionStatus property.
 */
@property BOOL isConnected;

/**
 * Connection status message of a friend.
 */
@property TTYConnectionStatus connectionStatus;

/**
 * The date interval when friend was last seen online.
 * Contains actual information in case if friend has connectionStatus offline.
 */
@property NSTimeInterval lastSeenOnlineInterval;

/**
 * Whether friend is typing now in current chat.
 */
@property BOOL isTyping;

/**
 * The date when friend was last seen online.
 * Contains actual information in case if friend has connectionStatus offline.
 */
- (NSDate *)lastSeenOnline;

@end

RLM_ARRAY_TYPE(TTYFriend)
