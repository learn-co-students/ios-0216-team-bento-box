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

@interface BONContainerViewController ()
@property (nonatomic,strong)UIViewController *fromViewController;
@property (nonatomic,strong)NSMutableArray *childViewControllers;
@property (nonatomic,strong)BONHamburgerViewController *hamburgerController;

@end

@implementation BONContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    // login logic
    BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"];
    
    if (isLoggedIn) {
        [self displayContentController:self.childViewControllers[0]];
    } else{
        BONLoginViewController *loginViewController = [[BONLoginViewController alloc] init];
        [self displayContentController:loginViewController];
    }
}

#pragma mark - Container View Controller Handlers

-(void)buildViewControllerArrayWithTotalOf:(NSInteger)number{
    self.childViewControllers = [[NSMutableArray alloc] init];
    for (NSInteger counter = 0; counter < number; counter++) {
        if (counter == number - 1) {
            [self.childViewControllers addObject:[[BONHowQuestionViewController alloc] init]];
            [self.childViewControllers addObject:[[BONResultsViewController alloc] init]];
        } else{
            [self.childViewControllers addObject:[[BONChildViewController alloc] init]];
        }
    }
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
}

-(void)backButtonHit:(id)sender{
    NSLog(@"Back Button Hit");
    UIViewController *oldController = self.fromViewController;
    
    if(self.fromViewController == self.childViewControllers[3]){
        BONChildViewController *newController = self.childViewControllers[2];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[2]) {
        BONChildViewController *newController = self.childViewControllers[1];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[1]){
        BONChildViewController *newController = self.childViewControllers[0];
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
    
    if (self.fromViewController == self.childViewControllers[3]) {
        BONChildViewController *newController = self.childViewControllers[2];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[2]){
        BONChildViewController *newController = self.childViewControllers[1];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    } else if (self.fromViewController == self.childViewControllers[1]){
        BONChildViewController *newController = self.childViewControllers[0];
        [self cycleFromViewController:oldController toViewController:newController];
        self.fromViewController = newController;
    }
}

-(void)swipeLeftOccurred:(id)sender{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
