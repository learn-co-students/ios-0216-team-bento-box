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
    
    NSLog(@"Welcome view did load");
    NSLog(@"Welcome's parent: %@", self.parentViewController);
    
    [super viewDidLoad];
    
    [self updateWelcomeWithMostRecentMeal];
    
    self.parentContainerViewController = (BONContainerViewController *)self.parentViewController;
}

#pragma mark - Helper Methods

-(void)updateWelcomeWithMostRecentMeal {
    
    self.sharedDataStore = [BONDataStore sharedDataStore];
    [self.sharedDataStore fetchData];
    
    if (self.sharedDataStore.userMeals.count == 0) {
        self.lastMealTimeLabel.hidden = YES;
        self.lastMealLoggedLabel.hidden = YES;
        self.welcomeBackNameLabel.text = @"Welcome!";
    }
    
    Meal *mostRecentMeal = self.sharedDataStore.userMeals.lastObject;
    
    NSDate *mostRecentMealDate = mostRecentMeal.createdAt;
    
    NSString *mostRecentMealDateString = [BONDataStore formatDate:mostRecentMealDate];
    
    self.lastMealTimeLabel.text = mostRecentMealDateString;
}

- (IBAction)logAMealTapped:(UIButton *)sender {
    
    NSLog(@"Log a meal tapped");
    
    [self.parentContainerViewController submitButtonHit:sender];
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
