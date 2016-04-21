//
//  BONResultsViewController.h
//  TBA
//
//  Created by christopher fleisher on 3/30/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "BONFirebaseClient.h"

@interface BONResultsViewController : UIViewController

@property (nonatomic, strong) Meal *resultMeal;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

-(void)showResultsOfLastMealLogged:(Meal *)meal;

@end
