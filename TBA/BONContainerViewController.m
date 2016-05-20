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
#import "BONNotificationsSettings.h"
#import "BONDataStore.h"
#import "BONGameViewController.h"
#import "BONWhereViewController.h"
#import "BONFirebaseViewController.h"
#import "BONFirebaseClient.h"
#import "BONWhenViewController.h"
#import "BONWhatViewController.h"
#import "BONWelcomeViewController.h"
#import "BONHowViewController.h"
#import "BONHistoryTableViewController.h"
#import "BONSummaryViewController.h"
#import <UIKit/UIKit.h>

#import "TBA-Swift.h"

@interface BONContainerViewController () <BONFirebaseViewControllerDelegate>

@property (nonatomic, strong)BONHamburgerViewController *hamburgerController;
@property (nonatomic, strong)BONFirebaseClient *sharedFirebaseClient;
@property (nonatomic, strong)UIVisualEffectView* effectView;
@property (nonatomic, strong)UIButton * hamburgerButton;
@property (nonatomic) NSInteger  hamburgerControllerWidth;

-(void)answerSubmittedToDataStore:(NSString *)isRightQuestion questionAndAnswer:(NSString *)userAnswer;
//-(void)formatDate;

@end

@implementation BONContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
    
    // Instantiating dataStore
    
    self.localDataStore = [BONDataStore sharedDataStore];
    [self.localDataStore fetchData];
    
//    self.view.backgroundColor = [UIColor blueColor];
    [self buildViewControllerArrayWithTotalOf:3];
    self.fromViewController = self.childViewControllers[0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitButtonHit:) name:@"submitButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backButtonHit:) name:@"backButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeRightOccurred:) name:@"swipeRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeLeftOccurred:) name:@"swipeLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hamburgerButtonHit:) name:@"hamburgerButtonHit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapOccurred:) name:@"tapTap" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginButtonHit:) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMenu:) name:@"closeMenu" object:nil];
    
    if ([BONFirebaseClient getToken]) {
        
        [self displayContentController:self.childViewControllers[0]];
        self.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                      inManagedObjectContext:self.localDataStore.managedObjectContext];
        self.userMeal.createdAt = [NSDate date];
        
    } else {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BONLogin" bundle:nil];
        BONFirebaseViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        loginViewController.delegate = self;
        [self displayContentController:loginViewController];
    }
    
    self.viewCounter = 0;
}

-(void)viewWillAppear:(BOOL)animated {
   
    self.hamburgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
    [self.hamburgerButton addTarget:self action:@selector(hamburgerButtonHit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hamburgerButton];
    
    //self.hamburgerButton.backgroundColor = [UIColor greenColor];
    [self.hamburgerButton setTitle:@"☰" forState:UIControlStateNormal] ;
    self.hamburgerButton.titleLabel.textColor = [UIColor whiteColor];
    //self.hamburgerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.hamburgerButton.titleLabel.font = [UIFont systemFontOfSize:30];
    
    if (![BONFirebaseClient getToken]) {
        
        self.hamburgerButton.alpha=0;
        
    }
}

#pragma mark - Container View Controller Handlers

-(void)buildViewControllerArrayWithTotalOf:(NSInteger)number{
    
    self.childViewControllers = [[NSMutableArray alloc] init];
    
    UIStoryboard *arielStoryboard = [UIStoryboard storyboardWithName:@"Ariel's Storyboard"
                                                              bundle:nil];
    BONWhereViewController *whereViewController = [arielStoryboard instantiateViewControllerWithIdentifier:@"whereViewController"];
    
    //when vc
    UIStoryboard *whenStoryboard = [UIStoryboard storyboardWithName:@"BONWhenView" bundle:nil];
    BONWhenViewController *whenVC= [whenStoryboard instantiateViewControllerWithIdentifier:@"when"];
    
    //what vc
    
    BONWhenViewController *whatVC= [whenStoryboard instantiateViewControllerWithIdentifier:@"what"];
    //how vc
    
    BONWhenViewController *howVC= [whenStoryboard instantiateViewControllerWithIdentifier:@"how"];
    
    //welcome vc
    BONWelcomeViewController * welcomeVC =[arielStoryboard instantiateViewControllerWithIdentifier:@"welcome"];
    [self addChildViewController:welcomeVC];
    
    //notifications vc
    UIStoryboard *notificationsStoryboard = [UIStoryboard storyboardWithName:@"BONNotificationsSettingsView" bundle:nil];
    BONNotificationsSettings *notificationsVC= [notificationsStoryboard instantiateViewControllerWithIdentifier:@"notifications"];
    //mealPicVC
    ViewController *mealPic = [whenStoryboard instantiateViewControllerWithIdentifier:@"mealPic"];
    
    //summaryVC
    BONSummaryViewController *summaryVC = [whenStoryboard instantiateViewControllerWithIdentifier:@"summaryVC"];
   
    
    BONChildViewController *whatViewController = [BONChildViewController new];
    BONChildViewController *whenViewController = [BONChildViewController new];
    
    BONResultsViewController *resultsVC = [BONResultsViewController new];
    
    [whatViewController getQuestionLabel];
    [whenViewController getQuestionLabel];
    
    whatViewController.questionLabel.textColor = [UIColor whiteColor];
    whatViewController.questionLabel.text = @"What did you eat?";
    
    whenViewController.questionLabel.textColor = [UIColor whiteColor];
    whenViewController.questionLabel.text = @"When did you eat?";
    

    [self.childViewControllers addObject:welcomeVC];
    [self.childViewControllers addObject:whenVC];
    [self.childViewControllers addObject:whatVC];
    [self.childViewControllers addObject:mealPic];
    [self.childViewControllers addObject:whereViewController];
    // [self.childViewControllers addObject:[BONHowQuestionViewController new]];
    [self.childViewControllers addObject:howVC];
    
    UIStoryboard *history= [UIStoryboard storyboardWithName:@"BONHistoryStoryboard" bundle:nil];
    BONHistoryTableViewController *historyVC = [history instantiateViewControllerWithIdentifier:@"historyTableVC"];
    [self addChildViewController:historyVC];
    [self.childViewControllers addObject:summaryVC];
    [self.childViewControllers addObject:historyVC];
    [self.childViewControllers addObject:notificationsVC];
    [self.childViewControllers addObject:resultsVC];
    
    resultsVC.resultMeal = self.userMeal;
}

-(void)displayContentController:(UIViewController *)contentController {
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
    //hamburgerController.view.frame = CGRectMake(0, 0, 0,0);
   // hamburgerController.view.frame = CGRectMake(0, 0, self.view.frame.size.width*0.60, self.view.frame.size.height);
    self.hamburgerControllerWidth = self.view.frame.size.width*0.60;
    hamburgerController.view.frame = CGRectMake(-self.hamburgerControllerWidth, 0, self.view.frame.size.width*0.60, self.view.frame.size.height);

    hamburgerController.view.backgroundColor = [UIColor darkGrayColor];
    hamburgerController.view.alpha = 1; //put back to 0 to renanimate

    

    [UIView animateWithDuration:0.25 animations:^{
    //hamburgerController.view.alpha = 1;
//        hamburgerController.view.frame = CGRectMake(self.view.frame.size.width*0.60, 0, 0, self.view.frame.size.height);
        


        hamburgerController.view.frame = CGRectMake(0, 0, self.view.frame.size.width*0.60, self.view.frame.size.height);
        
        //self.hamburgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
      //  self.hamburgerButton.frame = CGRectMake(100,0,60,60);
        [self.hamburgerButton addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside]; //set action to close
        self.effectView.alpha = 0.75;
        
        
        [self.effectView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeMenu:)]];
        
    
    }];
    
    [self addChildViewController:hamburgerController];
    [self.view addSubview:hamburgerController.view];
    [hamburgerController didMoveToParentViewController:self];
    self.hamburgerController = hamburgerController;
}

-(void)closeMenu:(id)sender{
    //self.hamburgerController.view.frame=CGRectMake(0,0,0,0);
    NSLog(@"closing menu");
    [UIView animateWithDuration:0.25 animations:^{
        //self.hamburgerController.view.alpha = 0.0; put bak to fadeout
        self.hamburgerController.view.frame=CGRectMake(-(self.view.frame.size.width*0.60),0,self.view.frame.size.width*0.60,self.view.frame.size.height);
         self.effectView.alpha = 0;
        //self.hamburgerButton.frame = CGRectMake(0, 0, 60, 60);
    }];
    
    [self.hamburgerButton addTarget:self action:@selector(hamburgerButtonHit:) forControlEvents:UIControlEventTouchUpInside]; //set action back to pen
}

#pragma mark - Buttons

- (void)submitButtonHit:(id)sender {
    
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
    else if([oldController isKindOfClass:[BONHowViewController class]]) {
        BONHowViewController *howVC = (BONHowViewController *)oldController;
        question = @"How do you feel?";
        answer = [NSString stringWithFormat:@"%li",howVC.howNumber];
    }
    
    //new logic for when and what vc
    else if([oldController isKindOfClass:[BONWhenViewController class]]) {
        BONWhenViewController *whenVC = (BONWhenViewController *)oldController;
        NSString * chosenDate = [NSDateFormatter localizedStringFromDate:whenVC.timePicker.date
                                                               dateStyle:0
                                                               timeStyle:NSDateFormatterFullStyle];
        
        question = @"When did you eat";
        answer = chosenDate;
    }
    
    else if([oldController isKindOfClass:[BONWhatViewController class]]) {
        BONWhatViewController *whatVC = (BONWhatViewController *)oldController;
        question = @"What did you eat?";
        answer = whatVC.answerText.text;
    }
    
    [self answerSubmittedToDataStore:question questionAndAnswer:answer];
    [self.localDataStore saveContext];
    [self.localDataStore fetchData];
    
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
        
        NSLog(@"Increasing the view counter in 'swipeLeftOccurred");
        
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
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    [self.view addSubview:self.effectView];
    self.effectView.frame = self.view.frame;
    self.effectView.alpha =0;
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self.view bringSubviewToFront:view];
        }
    }

}

# pragma mark - Helper Methods

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

- (void)didLoginUserWithFirebaseViewController:(BONFirebaseViewController *)firebaseViewController {
    
    NSLog(@"We just logged a user in in the Firbase View Controller");
    [self displayContentController:self.childViewControllers[0]];
    self.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                  inManagedObjectContext:self.localDataStore.managedObjectContext];
    self.userMeal.createdAt = [NSDate date];
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
