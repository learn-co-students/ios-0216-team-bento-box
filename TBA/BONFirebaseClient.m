//
//  BONFirebaseClient.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFirebaseClient.h"

@implementation BONFirebaseClient

- (void)configureFirebase {
    
    self.mealProperties = @{@"Created At" : @"Date",
                                      @"What Was Eaten" : @"What",
                                      @"Where Was Eaten" : @"Where",
                                      @"When Was Eaten" : @"When",
                                      @"How You Felt" : @"How"};
    
    self.meal = @{@"Meal" : self.mealProperties};
    
    self.meals = @{@"Meals" : self.meal};
    
    self.userID = @{@"User Name Goes Here2" : self.meals};
    
    NSDictionary *users = @{@"Users" : self.userID};
    
    self.rootReference = [[Firebase alloc] initWithUrl:@"https://blazing-inferno-253.firebaseio.com/"];
//    [self.rootReference setValue:users];
}

@end
