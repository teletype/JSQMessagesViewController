//
//  TTYMessageText.m
//  objcTox
//
//  Created by Dmytro Vorobiov on 15.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYMessageText.h"

@interface TTYMessageText ()

@end

@implementation TTYMessageText

- (NSString *)description
{
    NSString *description = [super description];

    return [description stringByAppendingFormat:@"TTYMessageText %@", self.text];
}

@end
