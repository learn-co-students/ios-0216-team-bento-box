//
//  BONWelcomeViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/1/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONDataStore.h"
#import "Meal.h"

@interface BONWelcomeViewController : UIViewController

@property (strong, nonatomic) BONDataStore *sharedDataStore;

@property (weak, nonatomic) IBOutlet UILabel *welcomeBackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMealTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMealLoggedLabel;

@end
