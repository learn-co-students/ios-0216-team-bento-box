//
//  BONWelcomeViewController.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/1/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONWelcomeViewController.h"

@interface BONWelcomeViewController ()

@end

@implementation BONWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"In View Did Load, meals.count: %lu", self.sharedDataStore.userMeals.count);
    
    self.sharedDataStore = [BONDataStore sharedDataStore];
    [self.sharedDataStore fetchData];
    
    
    
    NSLog(@"In View Did Load, after fetch Data, meals.count: %lu", self.sharedDataStore.userMeals.count);
    NSLog(@"Meals array: %@", self.sharedDataStore.userMeals);
    
    [self updateWelcomeWithMostRecentMeal];
    [self setBackgroundAndEdits];
    [self setFontsStyle];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
}

#pragma mark - Helper Methods

-(void)updateWelcomeWithMostRecentMeal {
    
    NSLog(@"In update welcome with most recent meal");
    NSLog(@"Shared Data Store's meal count: %lu", self.sharedDataStore.userMeals.count);
    
    if (self.sharedDataStore.userMeals.count == 0) {
        
        NSLog(@"In the if of update welcome");
        
        self.lastMealTimeLabel.hidden = YES;
        self.lastMealLoggedLabel.hidden = YES;
        self.welcomeBackNameLabel.text = @"Welcome!";
    }
    else {
        
        NSLog(@"In the else of update welcome");
    
    Meal *mostRecentMeal = self.sharedDataStore.userMeals.lastObject;
    NSDate *mostRecentMealDate = mostRecentMeal.createdAt;
    NSString *mostRecentMealDateString = [BONDataStore formatDate:mostRecentMealDate];
    self.lastMealTimeLabel.text = mostRecentMealDateString;
    }
}

- (IBAction)logMealClicked:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

- (IBAction)logoutTapped:(id)sender {
    
    Firebase *rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"];
    [rootReference unauth];
}

- (void)setBackgroundAndEdits {
        self.view.backgroundColor = [UIColor colorWithRed:127.0f/255.0f
                                                    green:235.0f/255.0f
                                                     blue:197.0f/255.0f
                                                    alpha:1.0f];
    
        UIColor *gradientMaskLayer = [UIColor colorWithRed:41.0f/255.0f
                                                     green:166.0f/255.0f
                                                      blue:122.0f/255.0f
                                                     alpha:1.0f];
    
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        gradientMask.frame = self.view.bounds;
        gradientMask.colors = @[(id)gradientMaskLayer.CGColor,
                                (id)[UIColor clearColor].CGColor];
    
        [self.view.layer insertSublayer:gradientMask atIndex:0];
}

- (void)setFontsStyle {
    
    self.welcomeBackNameLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.lastMealTimeLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.lastMealLoggedLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.logAMealButtonLabel.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
