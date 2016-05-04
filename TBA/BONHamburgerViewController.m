//
//  BONHamburgerViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHamburgerViewController.h"
#import "BONContainerViewController.h"
#import "BONFirebaseClient.h"
#import "BONWhenViewController.h"
#import "BONChildViewController.h"

@interface BONHamburgerViewController ()
@property (nonatomic, strong)NSArray * arr;
@property (nonatomic, strong)UIButton * closeButton;
@end

@implementation BONHamburgerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  

    

    [self buildCloseButton];
    [self buildNavbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)buildCloseButton{
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"x" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [closeButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10].active = YES;
    [closeButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [closeButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.20].active = YES;
    self.closeButton = closeButton;
}

-(void)closeButtonTouched:(UIButton *)closeButton{

    NSLog(@"close");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMenu" object:self];
    //self.swipeRight.enabled = NO;
}


-(void)buildNavbar {
    UIButton * notificationsButton = [[UIButton alloc]init];
    [notificationsButton addTarget:self action:@selector(goToVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notificationsButton];
    notificationsButton.translatesAutoresizingMaskIntoConstraints=NO;
    [notificationsButton.topAnchor constraintEqualToAnchor:self.closeButton.bottomAnchor].active=YES;
    [notificationsButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [notificationsButton setTitle:@"Notifications" forState:UIControlStateNormal];
    
    UIButton * pastMealsButton = [[UIButton alloc]init];
    [self.view addSubview:pastMealsButton];
    pastMealsButton.translatesAutoresizingMaskIntoConstraints=NO;
    [pastMealsButton.topAnchor constraintEqualToAnchor:notificationsButton.bottomAnchor].active=YES;
    [pastMealsButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [pastMealsButton setTitle:@"Past Meals" forState:UIControlStateNormal];
    [pastMealsButton addTarget:self action:@selector(goToVC:) forControlEvents:UIControlEventTouchUpInside];


    UIButton * insightsButton = [[UIButton alloc]init];
    [self.view addSubview:insightsButton];
    insightsButton.translatesAutoresizingMaskIntoConstraints=NO;
    [insightsButton.topAnchor constraintEqualToAnchor:pastMealsButton.bottomAnchor].active=YES;
    [insightsButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [insightsButton setTitle:@"Insights" forState:UIControlStateNormal];
    
    UIButton * newMealButton = [[UIButton alloc]init];
    [self.view addSubview:newMealButton];
    newMealButton.translatesAutoresizingMaskIntoConstraints=NO;
    [newMealButton.topAnchor constraintEqualToAnchor:insightsButton.bottomAnchor].active=YES;
    [newMealButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [newMealButton setTitle:@"New Meal" forState:UIControlStateNormal];
    [newMealButton addTarget:self action:@selector(newMeal) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * logoutButton = [[UIButton alloc]init];
    [self.view addSubview:logoutButton];
    logoutButton.translatesAutoresizingMaskIntoConstraints=NO;
    [logoutButton.topAnchor constraintEqualToAnchor:newMealButton.bottomAnchor].active=YES;
    [logoutButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(goToVC:) forControlEvents:UIControlEventTouchUpInside];

 
}

-(void)goToVC: (UIButton *)button{
    BONContainerViewController * parent= [self parentViewController];
    UIViewController *oldController = parent.fromViewController;
    
    UIViewController *newController;
    if ([button.titleLabel.text isEqual:@"Notifications"]) {
        newController = parent.childViewControllers[6];
        if([self isFromController:oldController EqualToNewController:newController]){
            [self closeButtonTouched:nil];
            return;
        }
    } else if ([button.titleLabel.text isEqual:@"Past Meals"]) {
        newController = parent.childViewControllers[5];
        if([self isFromController:oldController EqualToNewController:newController]){
            [self closeButtonTouched:nil];
            return;
        }
    } else if ([button.titleLabel.text isEqual:@"Insights"]) {
        newController = parent.childViewControllers[5];
        if([self isFromController:oldController EqualToNewController:newController]){
            [self closeButtonTouched:nil];
            return;
        }
    } else if ([button.titleLabel.text isEqual:@"Logout"]) {
        newController = parent.childViewControllers[1];
        [self logOutButtonHit];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BONLogin" bundle:nil];
        UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [parent displayContentController:loginViewController];
        return;
        
    }
    
    
    [parent cycleFromViewController:oldController toViewController:newController];
    parent.fromViewController = newController;
    [self closeButtonTouched:nil];
    
}

-(BOOL)isFromController: (UIViewController *) fromController EqualToNewController: (UIViewController *)newController{
    
    return fromController==newController;
}

-(void)logOutButtonHit {
    Firebase *rootReference = [[Firebase alloc] initWithUrl:@"https://crackling-fire-2900.firebaseio.com"];
    [rootReference unauth];
}

-(void)newMeal {
    
    BONContainerViewController *parentViewController = (BONContainerViewController *)self.parentViewController;
    
    parentViewController.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                                  inManagedObjectContext:parentViewController.localDataStore.managedObjectContext];
    
    parentViewController.userMeal.createdAt = [NSDate date];
    
    parentViewController.viewCounter = 0;
    [parentViewController.childViewControllers removeAllObjects];
    
    UIStoryboard *arielStoryboard = [UIStoryboard storyboardWithName:@"Ariel's Storyboard"
                                                              bundle:nil];
    UIStoryboard *whenStoryboard = [UIStoryboard storyboardWithName:@"BONWhenView"
                                                             bundle:nil];
    UIStoryboard *history= [UIStoryboard storyboardWithName:@"BONHistoryStoryboard"
                                                     bundle:nil];
    
    BONChildViewController *whatViewController = [BONChildViewController new];
    BONChildViewController *whenViewController = [BONChildViewController new];
    
    [whatViewController getQuestionLabel];
    [whenViewController getQuestionLabel];
    
    whatViewController.questionLabel.textColor = [UIColor whiteColor];
    whatViewController.questionLabel.text = @"What did you eat?";
    
    whenViewController.questionLabel.textColor = [UIColor whiteColor];
    whenViewController.questionLabel.text = @"When did you eat?";
    
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"welcome"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"when"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"what"]];
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"whereViewController"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"how"]];
    [parentViewController.childViewControllers addObject:[history instantiateViewControllerWithIdentifier:@"historyTableVC"]];
    
    [parentViewController displayContentController:parentViewController.childViewControllers.firstObject];

}

@end
