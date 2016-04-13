//
//  BONContainerViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONContainerViewController.h"
#import "BONHamburgerViewController.h"
#import "BONChildViewController.h"
#import "BONLoginViewController.h"
#import "BONResultsViewController.h"
#import "BONHowQuestionViewController.h"
#import "BONDataStore.h"
#import "BONGameViewController.h"
#import "BONWhereViewController.h"
#import "BONFirebaseClient.h"

@interface BONContainerViewController ()
@property (nonatomic,strong) UIViewController *fromViewController;
@property (nonatomic,strong) NSMutableArray *childViewControllers;
@property (nonatomic,strong) BONHamburgerViewController *hamburgerController;

@property (nonatomic,strong) BONDataStore *localDataStore;
@property (nonatomic,strong) Meal *userMeal;

@property (strong, nonatomic) BONFirebaseClient *firebaseClient;

-(void)answerSubmittedToDataStore:(NSString *)isRightQuestion questionAndAnswer:(NSString *)userAnswer;

@property (nonatomic,assign)NSInteger viewCounter;

@end

@implementation BONContainerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.firebaseClient = [BONFirebaseClient sharedFirebaseClient];
    [self.firebaseClient configureFirebase];
    
    // Instantiating dataStore
    self.localDataStore = [BONDataStore sharedDataStore];
    [self.localDataStore fetchData];
    self.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                  inManagedObjectContext:self.localDataStore.managedObjectContext];
    self.userMeal.createdAt = [NSDate date];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self buildViewControllerArrayWithTotalOf:3];
    self.fromViewController = self.childViewControllers[0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitButtonHit:) name:@"submitButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backButtonHit:) name:@"backButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeRightOccurred:) name:@"swipeRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeLeftOccurred:) name:@"swipeLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hamburgerButtonHit:) name:@"hamburgerButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapOccurred:) name:@"tapTap" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginButtonHit:) name:@"login" object:nil];
    
    
    if ([BONFirebaseClient getUID]) {
        [self displayContentController:self.childViewControllers[0]];
        
    } else{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BONLogin" bundle:nil];
        UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self displayContentController:loginViewController];
    }
    
    self.viewCounter = 0;
}

#pragma mark - Container View Controller Handlers

-(void)buildViewControllerArrayWithTotalOf:(NSInteger)number{
    
    self.childViewControllers = [[NSMutableArray alloc] init];
    
    UIStoryboard *arielStoryboard = [UIStoryboard storyboardWithName:@"Ariel's Storyboard"
                                                              bundle:nil];
    BONWhereViewController *whereViewController = [arielStoryboard instantiateViewControllerWithIdentifier:@"whereViewController"];
    
    BONChildViewController *whatViewController = [BONChildViewController new];
    BONChildViewController *whenViewController = [BONChildViewController new];
    
    BONResultsViewController *resultsVC = [BONResultsViewController new];
    
    [whatViewController getQuestionLabel];
    [whenViewController getQuestionLabel];
    
    whatViewController.questionLabel.textColor = [UIColor whiteColor];
    whatViewController.questionLabel.text = @"What did you eat?";
    
    whenViewController.questionLabel.textColor = [UIColor whiteColor];
    whenViewController.questionLabel.text = @"When did you eat?";
    
    [self.childViewControllers addObject:whatViewController];
    [self.childViewControllers addObject:whenViewController];
    [self.childViewControllers addObject:whereViewController];
    [self.childViewControllers addObject:[BONGameViewController new]];
    [self.childViewControllers addObject:[BONHowQuestionViewController new]];
    [self.childViewControllers addObject:resultsVC];
    
    resultsVC.resultMeal = self.userMeal;
}

-(void)displayContentController:(UIViewController *)contentController{
    CGRect newFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    contentController.view.frame = newFrame;
    
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
    [contentController didMoveToParentViewController:self];
}

#pragma mark - Hamburger Popout

-(void)hamburgerButtonHit:(id)sender{
    NSLog(@"Hamburger hit");
    BONHamburgerViewController *hamburgerController = [[BONHamburgerViewController alloc] init];
    hamburgerController.view.frame = CGRectMake(0, 0, self.view.frame.size.width*0.25, self.view.frame.size.height);
    hamburgerController.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:hamburgerController];
    [self.view addSubview:hamburgerController.view];
    [hamburgerController didMoveToParentViewController:self];
    self.hamburgerController = hamburgerController;
}

#pragma mark - Buttons

- (void)submitButtonHit:(id)sender {
    NSLog(@"Enter Button Hit");
    UIViewController *oldController = self.fromViewController;
    
    if (self.fromViewController == self.childViewControllers[0]) {
        BONChildViewController *newController = self.childViewControllers[1];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[1]){
        BONChildViewController *newController = self.childViewControllers[2];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[2]){
        BONChildViewController *newController = self.childViewControllers[3];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    }
    
    NSString *question;
    NSString *answer;
    
    if([oldController isKindOfClass:[BONChildViewController class]]) {
        BONChildViewController *childVC = (BONChildViewController *)oldController;
        question = childVC.questionLabel.text;
        answer = childVC.answerTextField.text;
    }
    else if([oldController isKindOfClass:[BONHowQuestionViewController class]]) {
        BONHowQuestionViewController *howVC = (BONHowQuestionViewController *)oldController;
        question = howVC.questionLabel.text;
        answer = howVC.answer;
    }
    
    // Saving To CoreData
    [self answerSubmittedToDataStore:question questionAndAnswer:answer];
    [self.localDataStore saveContext];
    [self.localDataStore fetchData];
    
    // Saving To Firebase
    
    
    self.viewCounter++;
    BONChildViewController *newController = self.childViewControllers[self.viewCounter];
    [self cycleFromViewController:oldController toViewController:newController];
    self.fromViewController = newController;
    
}

-(void)backButtonHit:(id)sender{
    NSLog(@"Back Button Hit");
    UIViewController *oldController = self.fromViewController;
    
    if (self.viewCounter) {
        self.viewCounter--;
        BONChildViewController *newController = self.childViewControllers[self.viewCounter];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    }
    
}

-(void)loginButtonHit:(id)sender{
    NSLog(@"Login Button Hit");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
    
}
#pragma mark - Gestures

-(void)swipeRightOccurred:(id)sender{
    UIViewController *oldController = self.fromViewController;
    
    if (self.viewCounter) {
        self.viewCounter--;
        BONChildViewController *newController = self.childViewControllers[self.viewCounter];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    }
    
}

-(void)swipeLeftOccurred:(id)sender{
    UIViewController *oldController = self.fromViewController;
    
    if (self.viewCounter != [self.childViewControllers count]-1) {
        self.viewCounter++;
        BONChildViewController *newController = self.childViewControllers[self.viewCounter];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    }
}

-(void)tapOccurred:(id)sender{
    [self.hamburgerController willMoveToParentViewController:nil];
    [self.hamburgerController.view removeFromSuperview];
    [self.hamburgerController removeFromParentViewController];
}

#pragma mark - Transition Animation

-(void)cycleFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC{

    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    CGRect endFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.25 options:0 animations:^{
        oldVC.view.frame = endFrame;
    } completion:^(BOOL finished) {
        [oldVC removeFromParentViewController];
        [newVC didMoveToParentViewController:self];
    }];
}

# pragma mark - Helper Methods
//
//-(void)formatDate {
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
//    dateFormatter.dateStyle = NSDateFormatterShortStyle;
//    dateFormatter.timeStyle = NSDateFormatterShortStyle;
//}

-(void)answerSubmittedToDataStore:(NSString *)isRightQuestion questionAndAnswer:(NSString *)userAnswer {
    
    if ([isRightQuestion containsString:@"When"]) {
        self.userMeal.whenWasItEaten = userAnswer;
    }
    if ([isRightQuestion containsString:@"What"]) {
        self.userMeal.whatWasEaten = userAnswer;
    }
    if ([isRightQuestion containsString:@"How"]) {
        self.userMeal.howUserFelt = userAnswer;
    }
    else {
    self.userMeal.whereWasItEaten = self.localDataStore.whereWasEatenString;
    }
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
