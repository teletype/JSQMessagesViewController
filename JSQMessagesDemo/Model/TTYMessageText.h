//
//  TTYMessageText.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 15.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYObject.h"
#import "TTY.h"

@class TTYToxConstants;

/**
 * Simple text message.
 *
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYMessageText : TTYObject

/**
 * The text of the message.
 */
@property NSString *text;

/**
 * Indicate if message is delivered. Actual only for outgoing messages.
 */
@property BOOL isDelivered;

/**
 * Type of the message.
 */
@property TTYMessageType type;

@property TTYMessageId messageId;

@end

RLM_ARRAY_TYPE(TTYMessageText)
