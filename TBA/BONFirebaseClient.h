//
//  BONFirebaseClient.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import <UIKit/UIKit.h>
#import "BONDataStore.h"
#import "BONContainerViewController.h"
#import "Meal.h"

@interface BONFirebaseClient : NSObject

@property (strong, nonatomic) Firebase *rootReference;

@property (strong, nonatomic) NSDictionary *mealProperties;
@property (strong, nonatomic) NSDictionary *meal;
@property (strong, nonatomic) NSDictionary *meals;
@property (strong, nonatomic) NSDictionary *userID;
@property (strong, nonatomic) NSDictionary *users;
@property (strong, nonatomic) NSString *userIDReference;
@property (strong, nonatomic) NSString *uidRef;

+ (instancetype)sharedFirebaseClient;
+ (NSString *)getToken;

- (void)configureFirebase;
- (void)createNewUserInFirebaseWithEmail:(NSString *)email
                                Password:(NSString *)password
                      FromViewController:(UIViewController *)viewController;

- (void)loginUserInFirebaseWithEmail:(NSString *)email
                            Password:(NSString *)password
                  FromViewController:(UIViewController *)fromViewController;

- (void)createMealWithDate:(NSString *)date;

- (void)setWhatWasEaten:(NSString *)whatWasEaten
                ForMeal:(Meal *)meal;

- (void)setWhereUserAte:(NSString *)whereUserAte
                ForMeal:(Meal *)meal;

- (void)setWhenUserAte:(NSString *)whenUserAte
               ForMeal:(Meal *)meal;

- (void)setHowUserFelt:(NSString *)howUserFelt
               ForMeal:(Meal *)meal;

@end
