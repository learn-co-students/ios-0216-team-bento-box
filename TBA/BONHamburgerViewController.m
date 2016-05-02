//
//  BONHamburgerViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHamburgerViewController.h"
#import "BONContainerViewController.h"

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


    UIButton * insightsButton = [[UIButton alloc]init];
    [self.view addSubview:insightsButton];
    insightsButton.translatesAutoresizingMaskIntoConstraints=NO;
    [insightsButton.topAnchor constraintEqualToAnchor:pastMealsButton.bottomAnchor].active=YES;
    [insightsButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [insightsButton setTitle:@"Insights" forState:UIControlStateNormal];
    
    UIButton * logoutButton = [[UIButton alloc]init];
    [self.view addSubview:logoutButton];
    logoutButton.translatesAutoresizingMaskIntoConstraints=NO;
    [logoutButton.topAnchor constraintEqualToAnchor:insightsButton.bottomAnchor].active=YES;
    [logoutButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];

 
}

-(void)goToVC: (UIButton *)button{
    BONContainerViewController * parent= [self parentViewController];
    UIViewController *newController;
    if ([button.titleLabel.text isEqual:@"Notifications"]) {
        newController = parent.childViewControllers[2];
    } if ([button.titleLabel.text isEqual:@"Past Meals"]) {
        newController = parent.childViewControllers[2];
    } if ([button.titleLabel.text isEqual:@"Insights"]) {
        newController = parent.childViewControllers[2];
    } 


    UIViewController *oldController = parent.fromViewController;
    [parent cycleFromViewController:oldController toViewController:newController];
    parent.fromViewController = newController;
    [self closeButtonTouched:nil];
    
}

@end
