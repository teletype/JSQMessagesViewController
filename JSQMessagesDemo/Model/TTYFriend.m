//
//  TTYFriend.m
//  objcTox
//
//  Created by Dmytro Vorobiov on 10.03.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYFriend.h"

@interface TTYFriend ()

@end

@implementation TTYFriend

#pragma mark -  Class methods

+ (NSDictionary *)defaultPropertyValues
{
    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithDictionary:[super defaultPropertyValues]];
    values[@"name"] = @"";
    values[@"statusMessage"] = @"";

    return [values copy];
}

#pragma mark -  Public

- (NSDate *)lastSeenOnline
{
    if (self.lastSeenOnlineInterval <= 0) {
        return nil;
    }

    return [NSDate dateWithTimeIntervalSince1970:self.lastSeenOnlineInterval];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"TTYFriend with friendNumber %u, name %@", self.friendNumber, self.name];
}

@end
