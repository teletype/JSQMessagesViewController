//
//  TTYBasicContainer.h
//  objcTox
//
//  Created by Dmytro Vorobiov on 16.04.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTYBasicContainer;
@protocol TTYBasicContainerDelegate <NSObject>

- (void)basicContainerUpdate:(TTYBasicContainer *)container
                 insertedSet:(NSIndexSet *)inserted
                  removedSet:(NSIndexSet *)removed
                  updatedSet:(NSIndexSet *)updated;

- (void)basicContainer:(TTYBasicContainer *)container objectUpdated:(id)object;

@end

/**
 * Basic container that saves it's objects in sorted array. Is threadsafe.
 */
@interface TTYBasicContainer : NSObject

@property (weak, nonatomic) id<TTYBasicContainerDelegate> delegate;

/**
 * @param objects Initial array with objects.
 */
- (instancetype)initWithObjects:(NSArray *)objects;

/**
 * Sets comparator, resorts objects and notifies delegate.
 *
 * @param comparator Comparator to be sorted with.
 */
- (void)setComparatorForCurrentSort:(NSComparator)comparator;

/**
 * @return Total number of objects.
 */
- (NSUInteger)count;

/**
 * Returns object at specified index. If index is out of bounds returns nil.
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 * Adds object to array. Note that one object can be added only once.
 */
- (void)addObject:(id)object;

/**
 * Remove object. Object must be in array.
 */
- (void)removeObject:(id)object;

/**
 * Remove object. Object must be in array.
 */
- (void)updateObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))testBlock
                    updateBlock:(void (^)(id object))updateBlock;

@end
