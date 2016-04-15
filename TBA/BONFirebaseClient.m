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
        static BONFirebaseClient *sharedFireBaseClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedFireBaseClient = [BONFirebaseClient new];
        });
        
        return sharedFireBaseClient;
}

+ (NSString *)getUID{
    
    Firebase *rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"];
    NSString *userID = rootReference.authData.uid;
    return userID;
}

- (void)configureFirebase {
    
    self.mealProperties = @{@"What Was Eaten" : @"What",
                            @"Where Was Eaten" : @"Where",
                            @"When Was Eaten" : @"When",
                            @"How You Felt" : @"How"};
    
    self.meal = @{@"Meal Date" : self.mealProperties};
    
    self.meals = @{@"Meals" : self.meal};
    
    self.userID = @{@"User Name Goes Here" : self.meals};
    
    self.users = @{@"Users" : self.userID};
    
    self.rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"];
    
//    self.userIDReference = self.rootReference.authData.uid;
    
//    [self.rootReference setValue:users];
}

- (void)createNewUserInFirebaseWithEmail:(NSString *)email
                                Password:(NSString *)password {
    
    [self.rootReference createUser:email
                          password:password
          withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
                                   
                                   if (error) {
                                       NSLog(@"User not created:%@", error.description);
                                   }
                                   
                                   else {
                                       
                                       self.userIDReference = [result objectForKey:@"uid"];
                                       
                                       NSLog(@"Successfully created user account with uid: %@", self.userIDReference);
                                       
                                       Firebase *usersReference = [self.rootReference childByAppendingPath:@"Users"];
                                       Firebase *currentUserReference = [usersReference childByAppendingPath:self.userIDReference];
                                       
                                       [currentUserReference setValue:self.meal];
                                   }
          }];
}

- (void)loginUserInFirebaseWithEmail:(NSString *)email
                            Password:(NSString *)password {
    
    [self.rootReference authUser:email
                        password:password
             withCompletionBlock:^(NSError *error, FAuthData *authData) {
                 
                 if (error) {
                     NSLog(@"Login Failed: %@", error.description);
                 }
                 else {
                     NSLog(@"Logged in, UID: %@", authData.uid);
                 }
             }];
}

@end
