
#import "TTYObject.h"

@class TTYFriend;
@class TTYChat;

/**
 * An abstract message that represents one chunk of chat history.
 *
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYMessage : TTYObject

/**
 * The date interval when message was send/received.
 */
@property NSTimeInterval dateInterval;

/**
 * The sender of the message. If the message if outgoing sender is nil.
 */
@property TTYFriend *sender;


/**
 * Message has one of the following properties.
 */
@property NSString *messageText;

/**
 * The date when message was send/received.
 */
- (NSDate *)date;


@end

RLM_ARRAY_TYPE(TTYMessage)
