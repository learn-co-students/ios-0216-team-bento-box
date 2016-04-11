//
//  User+CoreDataProperties.h
//  TBA
//
//  Created by Bao Tran on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSOrderedSet<Meal *> *meals;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(Meal *)value inMealsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMealsAtIndex:(NSUInteger)idx;
- (void)insertMeals:(NSArray<Meal *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMealsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMealsAtIndex:(NSUInteger)idx withObject:(Meal *)value;
- (void)replaceMealsAtIndexes:(NSIndexSet *)indexes withMeals:(NSArray<Meal *> *)values;
- (void)addMealsObject:(Meal *)value;
- (void)removeMealsObject:(Meal *)value;
- (void)addMeals:(NSOrderedSet<Meal *> *)values;
- (void)removeMeals:(NSOrderedSet<Meal *> *)values;

@end

NS_ASSUME_NONNULL_END
