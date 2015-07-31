//
//  TTYObject.m
//  JSQMessages
//
//  Created by Johan Sellström on 29/07/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//


#import "TTYObject.h"

@implementation TTYObject

#pragma mark -  Class methods

+ (NSString *)primaryKey
{
    return @"uniqueIdentifier";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{
             @"uniqueIdentifier" : [[NSUUID UUID] UUIDString],
             };
}

#pragma mark -  Public

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ with uniqueIdentifier %@", [self class], self.uniqueIdentifier];
}

- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    
    if (! [object isKindOfClass:[self class]]) {
        return NO;
    }
    
    TTYObject *o = object;
    
    return [self.uniqueIdentifier isEqualToString:o.uniqueIdentifier];
}

- (NSUInteger)hash
{
    return [self.uniqueIdentifier hash];
}

@end
