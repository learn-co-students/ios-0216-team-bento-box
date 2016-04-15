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
    
    [self updateWelcomeWithMostRecentMeal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)logMealClicked:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
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
