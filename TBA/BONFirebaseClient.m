//
//  BONFirebaseClient.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFirebaseClient.h"

@implementation BONFirebaseClient

+ (instancetype)sharedFirebaseClient {
    static BONFirebaseClient *sharedFirebaseClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFirebaseClient = [BONFirebaseClient new];
    });
    
    return sharedFirebaseClient;
}

- (void)configureFirebase {
    
    self.mealProperties = @{@"What Was Eaten" : @"What",
                            @"Where Was Eaten" : @"Where",
                            @"When Was Eaten" : @"When",
                            @"How You Felt" : @"How"};
    
    self.meal = @{@"Date Of Meal" : self.mealProperties};
    
    self.meals = @{@"Meals" : self.meal};
    
    self.userID = @{@"User Name Goes Here" : self.meals};
    
    self.users = @{@"Users" : self.userID};
  
    self.rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-4725.firebaseIO.com/"];
//    [self.rootReference setValue:self.users];
}

//- (void)addMealInFirebaseToUser:(NSString *)userID
//                       WithDate:(NSDate *)date {
//    
//    Firebase *usersReference = [self.rootReference]
//}

@end
