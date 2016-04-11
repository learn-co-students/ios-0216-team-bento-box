//
//  coreDataTestViewController.m
//  TBA
//
//  Created by Bao Tran on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "coreDataTestViewController.h"

@interface coreDataTestViewController ()

@end

@implementation coreDataTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.localDataStore = [BONDataStore sharedDataStore];
    [self.localDataStore fetchData];
        
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
 
    Meal *userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                   inManagedObjectContext:self.localDataStore.managedObjectContext];
    
    userMeal.whenWasItEaten = self.whenTextField.text;
    userMeal.whatWasEaten = self.whatTextField.text;
    userMeal.whereWasItEaten = self.whereTextField.text;
    userMeal.howUserFelt = self.howTextField.text;
    userMeal.createdAt = [NSDate date];
    
    [self.localDataStore saveContext];
    [self.localDataStore fetchData];
}

- (IBAction)buttonTapped:(id)sender {
    
    Meal *lastMealLogged = self.localDataStore.userMeals.lastObject;
    
    NSString *string = [NSDateFormatter localizedStringFromDate:lastMealLogged.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];

    self.whatLabel.text = string;
    
    NSLog(@"%@", lastMealLogged.createdAt.description);
}

@end
