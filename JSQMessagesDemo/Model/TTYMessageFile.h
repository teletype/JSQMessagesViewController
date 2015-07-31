//
//  TTYMessageFile.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 15.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "TTYObject.h"
#import "TTY.h"

/**
 * Message that contains file, that has been send/received. Represents pending, canceled and loaded files.
 *
 * Please note that all properties of this object are readonly.
 * You can change some of them only with appropriate method in TTYSubmanagerObjects.
 */
@interface TTYMessageFile : TTYObject

/**
 * The current state of file. Only in case if it is TTYMessageFileTypeReady
 * the file can be shown to user.
 */
@property TTYMessageFileType fileType;

/**
 * Size of file in bytes.
 */
@property TTYFileSize fileSize;

/**
 * Name of the file as specified by sender. Note that actual fileName in path
 * may differ from this fileName.
 */
@property NSString *fileName;

/**
 * Path of file on disk. If you need fileName to show to user please use
 * `fileName` property. filePath has it's own random fileName.
 */
@property NSString *filePath;

/**
 * Uniform Type Identifier of file.
 */
@property NSString *fileUTI;

@end

RLM_ARRAY_TYPE(TTYMessageFile)
