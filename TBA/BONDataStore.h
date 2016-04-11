//
//  BONDataStore.h
//  TBA
//
//  Created by Bao Tran on 4/5/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Meal.h"

@interface BONDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString *whereWasEatenString;
@property (nonatomic, strong) NSArray *userMeals;

+(instancetype)sharedDataStore;
+(NSString *)formatDate:(NSDate *)date;

-(void)saveContext;
-(void)fetchData;


@end
