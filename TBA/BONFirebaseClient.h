//
//  BONFirebaseClient.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface BONFirebaseClient : NSObject

@property (strong, nonatomic) Firebase *rootReference;

@property (strong, nonatomic) NSDictionary *mealProperties;
@property (strong, nonatomic) NSDictionary *meal;
@property (strong, nonatomic) NSDictionary *meals;
@property (strong, nonatomic) NSDictionary *userID;
@property (strong, nonatomic) NSDictionary *users;

@property (strong, nonatomic) NSString *userIDReference;

+ (instancetype)sharedFirebaseClient;
+(NSString *)getUID;

- (void)configureFirebase;
- (void)createNewUserInFirebaseWithEmail:(NSString *)email
                                Password:(NSString *)password;

- (void)loginUserInFirebaseWithEmail:(NSString *)email
                            Password:(NSString *)password;

@end
