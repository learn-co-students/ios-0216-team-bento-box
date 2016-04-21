//
//  BONWelcomeViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/1/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONDataStore.h"
#import "BONFirebaseClient.h"
#import "Meal.h"
#import "BONContainerViewController.h"
#import "BONChildViewController.h"
#

@interface BONWelcomeViewController : UIViewController

@property (strong, nonatomic) BONDataStore *sharedDataStore;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

@property (weak, nonatomic) IBOutlet UILabel *welcomeBackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMealTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMealLoggedLabel;
<<<<<<< HEAD
=======
@property (strong, nonatomic) BONChildViewController * nextVC;
@property (weak, nonatomic) IBOutlet UIButton *logAMealButtonLabel;
>>>>>>> master

@property (strong, nonatomic) BONChildViewController * nextVC;

@end
