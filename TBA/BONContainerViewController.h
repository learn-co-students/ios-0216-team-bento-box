//
//  BONContainerViewController.h
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONDataStore.h"
#import "Meal.h"

@interface BONContainerViewController : UIViewController

@property (nonatomic, strong) BONDataStore *localDataStore;
@property (nonatomic, strong) Meal *userMeal;
@property (nonatomic, strong)NSMutableArray *childViewControllers;

@property (nonatomic, assign) NSInteger viewCounter;
@property (nonatomic, strong) UIViewController *fromViewController;

- (void)submitButtonHit:(id)sender;
- (void)cycleFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC;
- (void)displayContentController:(UIViewController *)contentController;

@end


