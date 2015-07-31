//
//  TTYObject.h
//  JSQMessages
//
//  Created by Johan Sellström on 29/07/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import <Realm/Realm.h>

/**
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYObject : RLMObject

/**
 * The unique identifier of object.
 */
@property NSString *uniqueIdentifier;

/**
 * Returns a string that represents the contents of the receiving class.
 */
- (NSString *)description;

/**
 * Returns a Boolean value that indicates whether the receiver and a given object are equal.
 */
- (BOOL)isEqual:(id)object;

/**
 * Returns an integer that can be used as a table address in a hash table structure.
 */
- (NSUInteger)hash;

@end
