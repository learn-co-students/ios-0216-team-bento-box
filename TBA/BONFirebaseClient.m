//
//  BONFirebaseClient.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFirebaseClient.h"

@implementation BONFirebaseClient

+(NSString *)getUID{
    return [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"].authData.uid;
}


- (void)configureFirebase {
    
    self.mealProperties = @{@"Created At" : @"Date",
                        @"What Was Eaten" : @"What",
                        @"Where Was Eaten" : @"Where",
                        @"When Was Eaten" : @"When",
                        @"How You Felt" : @"How"};
    
    self.meal = @{@"Meal" : self.mealProperties};
    
    self.meals = @{@"Meals" : self.meal};
    
    self.userID = @{@"User Name Goes Here" : self.meals};
    
    NSDictionary *users = @{@"Users" : self.userID};
    
    [self.rootReference setValue:users];
        
    self.rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"];
    
    self.uidRef = self.rootReference.authData.uid;
//    [self.rootReference setValue:users];
}

@end
