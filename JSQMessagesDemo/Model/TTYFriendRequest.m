//
//  TTYFriendRequest.m
//  objcTox
//
//  Created by Dmytro Vorobiov on 16.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYFriendRequest.h"

@implementation TTYFriendRequest

#pragma mark -  Public

- (NSDate *)date
{
    return [NSDate dateWithTimeIntervalSince1970:self.dateInterval];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"TTYFriendRequest with publicKey %@\nmessage %@", self.publicKey, self.message];
}

@end
