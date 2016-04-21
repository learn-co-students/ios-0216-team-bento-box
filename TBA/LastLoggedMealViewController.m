//
//  LastLoggedMealViewController.m
//  TBA
//
//  Created by Bao Tran on 4/16/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "LastLoggedMealViewController.h"
#import "BONDataStore.h"

@interface LastLoggedMealViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastAteTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatWhereHowTextLabel;
@property (strong, nonatomic) BONDataStore *localDataStore;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

-(UIStatusBarStyle)preferredStatusBarStyle;

@end

@implementation LastLoggedMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self editTextField];
    [self populateTextField];
    [self createNextbutton];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.localDataStore = [BONDataStore sharedDataStore];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Text Label Constraints

-(void)editTextField {
    self.nameTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastAteTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.whatWhereHowTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nameTextLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.lastAteTextLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.whatWhereHowTextLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.nameTextLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:200].active = YES;
    [self.lastAteTextLabel.topAnchor constraintEqualToAnchor:self.nameTextLabel.bottomAnchor constant:0].active = YES;
    [self.whatWhereHowTextLabel.topAnchor constraintEqualToAnchor:self.lastAteTextLabel.bottomAnchor constant:0].active = YES;
    
//    self.view.backgroundColor = [UIColor colorWithRed:127.0f/255.0f
//                                                green:235.0f/255.0f
//                                                 blue:197.0f/255.0f
//                                                alpha:1.0f];
//
//    UIColor *gradientMaskLayer = [UIColor colorWithRed:41.0f/255.0f
//                                                 green:166.0f/255.0f
//                                                  blue:122.0f/255.0f
//                                                 alpha:1.0f];
//    
//    CAGradientLayer *gradientMask = [CAGradientLayer layer];
//    gradientMask.frame = self.view.bounds;
//    gradientMask.colors = @[(id)gradientMaskLayer.CGColor,
//                            (id)[UIColor clearColor].CGColor];
//    
//    [self.view.layer insertSublayer:gradientMask atIndex:0];
    
    [self animateTextField:self.nameTextLabel duration:2];
    [self animateTextField:self.lastAteTextLabel duration:3.5];
    [self animateTextField:self.whatWhereHowTextLabel duration:4];
    
}

-(void)populateTextField {
    Meal *userMeal = self.localDataStore.userMeals.lastObject;
    
    NSString *yourLastMeal = [NSString stringWithFormat:@"Your last meal was at %@.", userMeal.createdAt];
    self.lastAteTextLabel.text = yourLastMeal;
    
    NSString *whenHowWhereMeal = [NSString stringWithFormat:@"You ate %@ at %@ and you said you felt %@ afterwards.", userMeal.whatWasEaten, userMeal.whereWasItEaten, userMeal.howUserFelt];    
    self.whatWhereHowTextLabel.numberOfLines = 0;
    self.whatWhereHowTextLabel.text = whenHowWhereMeal;
    [self.whatWhereHowTextLabel sizeToFit];
    
    self.nameTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.whatWhereHowTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.lastAteTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];

    [self textcolor:self.nameTextLabel];
    [self textcolor:self.whatWhereHowTextLabel];
    [self textcolor:self.lastAteTextLabel];
    
}

-(void)textcolor:(UILabel *)text {
    text.textColor = [UIColor colorWithRed:255.0f/255.0f
                                     green:254.0f/255.0f
                                      blue:245.0f/255.0f
                                     alpha:1.0f];
}

-(void)createNextbutton {
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextButton.topAnchor constraintEqualToAnchor:self.whatWhereHowTextLabel.bottomAnchor constant:50].active = YES;
    [self.nextButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.nextButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
    [self.nextButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.30].active = YES;
    self.nextButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                      green:254.0f/255.0f
                                                       blue:245.0f/255.0f
                                                      alpha:0.55f];
    
    self.nextButton.layer.cornerRadius = 12;
    self.nextButton.clipsToBounds = YES;
    
    [self.nextButton addTarget:self action:@selector(changeButtonBackGroundColor:) forControlEvents:UIControlEventTouchDown];
    [self.nextButton addTarget:self action:@selector(resetButtonBackGroundColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton addTarget:self action:@selector(resetButtonBackGroundColor:) forControlEvents:UIControlEventTouchUpOutside];
    [self.nextButton addTarget:self action:@selector(resetButtonBackGroundColor:) forControlEvents:UIControlEventTouchCancel];
    
    [self.nextButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f
                                                   green:254.0f/255.0f
                                                    blue:245.0f/255.0f
                                                   alpha:1.0f] forState:UIControlStateNormal];
    
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
}

-(void)resetButtonBackGroundColor:(UIButton *)nextButton {
    self.nextButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                      green:254.0f/255.0f
                                                       blue:245.0f/255.0f
                                                      alpha:0.55f];
}

-(void)changeButtonBackGroundColor:(UIButton *)nextButton {
    self.nextButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                      green:254.0f/255.0f
                                                       blue:245.0f/255.0f
                                                      alpha:.65f];
    
}

-(void)animateTextField:(UILabel *)textField duration:(CGFloat)duration {
    
    textField.alpha = 0;
    textField.hidden = NO;
    [UIView animateWithDuration:duration animations:^{
        textField.alpha = 1;
    }];
    
}

- (IBAction)nextPageButton:(id)sender {
    // Go To Next Page
}
@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
