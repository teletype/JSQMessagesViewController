//
//  TTYMessageAbstract.m
//  objcTox
//
//  Created by Dmytro Vorobiov on 14.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYMessageAbstract.h"
#import "TTYMessageText.h"
#import "TTYMessageFile.h"

@interface TTYMessageAbstract ()

@end

@implementation TTYMessageAbstract

#pragma mark -  Public

- (NSDate *)date
{
    if (self.dateInterval <= 0) {
        return nil;
    }

    return [NSDate dateWithTimeIntervalSince1970:self.dateInterval];
}

- (BOOL)isOutgoing
{
    return (self.sender == nil);
}

- (NSString *)description
{
    NSString *string = nil;

    if (self.messageText) {
        string = [self.messageText description];
    }
    else if (self.messageFile) {
        string = [self.messageFile description];
    }

    return [NSString stringWithFormat:@"TTYMessageAbstract with date %@, %@", self.date, string];
}

@end
