//
//  Meal+CoreDataProperties.h
//  TBA
//
//  Created by Bao Tran on 4/5/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *whereWasItEaten;
@property (nullable, nonatomic, retain) NSString *whatWasEaten;
@property (nullable, nonatomic, retain) NSString *whenWasItEaten;
@property (nullable, nonatomic, retain) NSString *howUserFelt;
@property (nullable, nonatomic, retain) NSDate *createdAt;

@end

NS_ASSUME_NONNULL_END
