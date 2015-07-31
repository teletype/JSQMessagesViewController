//
//  teletype.h
//  JSQMessages
//
//  Created by Johan Sellström on 29/07/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import <Realm/Realm.h>

typedef long long TTYFileSize;
typedef int TTYFriendNumber;
typedef int TTYMessageId;
typedef uint32_t TTYFileNumber;

typedef NS_ENUM(NSInteger, TTYConnectionStatus) {
    /**
     * There is no connection.      
     */
    TTYConnectionStatusNone,
    /**
     * A TCP connection has been established.
     */
    TTYConnectionStatusTCP,
    /**
     * A UDP connection has been established.
     */
    TTYConnectionStatusUDP,
};

typedef NS_ENUM(NSInteger, TTYUserStatus) {
    /**
     * User is online and available.
     */
    TTYUserStatusNone,
    /**
     * User is away. Clients can set this e.g. after a user defined
     * inactivity time.
     */
    TTYUserStatusAway,
    /**
     * User is busy. Signals to other clients that this client does not
     * currently wish to communicate.
     */
    TTYUserStatusBusy,
};

typedef NS_ENUM(NSInteger, TTYMessageType) {
    /**
     * Normal text message. Similar to PRIVMSG on IRC.
     */
    TTYMessageTypeNormal,
    /**
     * A message describing an user action. This is similar to /me (CTCP ACTION)
     * on IRC.
     */
    TTYMessageTypeAction,
};

typedef NS_ENUM(NSUInteger, TTYFetchRequestType) {
    TTYFetchRequestTypeFriend,
    TTYFetchRequestTypeFriendRequest,
    TTYFetchRequestTypeChat,
    TTYFetchRequestTypeMessageAbstract,
};

typedef NS_ENUM(NSInteger, TTYMessageFileType) {
    /**
     * File is incoming and is waiting confirmation of user to be downloaded.
     * Please start loading or cancel it with <<placeholder>> method.
     */
    TTYMessageFileTypeWaitingConfirmation,
    
    /**
     * File is downloading or uploading.
     */
    TTYMessageFileTypeLoading,
    
    /**
     * Downloading or uploading of file is paused.
     */
    TTYMessageFileTypePaused,
    
    /**
     * Downloading or uploading of file was canceled.
     */
    TTYMessageFileTypeCanceled,
    
    /**
     * File is fully loaded.
     * In case of incoming file now it can be shown to user.
     */
    TTYMessageFileTypeReady,
};
