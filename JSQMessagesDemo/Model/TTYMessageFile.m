//
//  TTYMessageFile.m
//  objcTox
//
//  Created by Dmytro Vorobiov on 15.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYMessageFile.h"

@interface TTYMessageFile ()

@end

@implementation TTYMessageFile

#pragma mark -  Public

- (NSString *)description
{
    NSString *description = [super description];

    return [description stringByAppendingFormat:@"TTYMessageFile with fileName = %@, fileSize = %llu", self.fileName, self.fileSize];
}

@end
