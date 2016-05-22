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
    
    self.sharedDataStore = [BONDataStore sharedDataStore];
    [self.sharedDataStore fetchData];
    
    [self updateWelcomeWithMostRecentMeal];
    [self setBackgroundAndEdits];
    [self setFontsStyle];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
}

#pragma mark - Helper Methods

-(void)updateWelcomeWithMostRecentMeal {
    
    if (self.sharedDataStore.userMeals.count == 0) {
        
        self.lastMealTimeLabel.hidden = YES;
        self.lastMealLoggedLabel.hidden = YES;
        self.welcomeBackNameLabel.textAlignment = NSTextAlignmentCenter;
        self.welcomeBackNameLabel.text = @"Welcome!";
    }
    else {
    
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
    self.logAMealButtonLabel.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    
    self.welcomeBackNameLabel.textColor = [UIColor colorWithRed:255.0f/255.0f
                                                          green:254.0f/255.0f
                                                           blue:245.0f/255.0f
                                                          alpha:1.0];
    self.lastMealTimeLabel.textColor = [UIColor colorWithRed:255.0f/255.0f
                                                          green:254.0f/255.0f
                                                           blue:245.0f/255.0f
                                                          alpha:1.0];
    self.lastMealLoggedLabel.textColor = [UIColor colorWithRed:255.0f/255.0f
                                                          green:254.0f/255.0f
                                                           blue:245.0f/255.0f
                                                          alpha:1.0];
    [self.logAMealButtonLabel setTitleColor:[UIColor colorWithRed:255.0f/255.0f
                                                            green:254.0f/255.0f
                                                             blue:245.0f/255.0f
                                                            alpha:1.0] forState:UIControlStateNormal];
    self.logAMealButtonLabel.layer.cornerRadius = 12;
    self.logAMealButtonLabel.clipsToBounds = NO;
    self.logAMealButtonLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                                green:254.0f/255.0f
                                                                 blue:245.0f/255.0f
                                                                alpha:.55];
    
    self.logAMealButtonLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.logAMealButtonLabel.layer.borderWidth = 1;

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
