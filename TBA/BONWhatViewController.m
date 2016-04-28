//
//  ViewController.m
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONWhatViewController.h"

@interface BONWhatViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextView *whatDidYouEatTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionTextBox;
@property (nonatomic,strong)UIButton *closeButton;

@end

@implementation BONWhatViewController

- (void)viewDidLoad {
    self.sharedDataStore = [BONDataStore sharedDataStore];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
 
    [self setFontsStyle];
    [self setBackgroundAndEdits];
 
    [self.submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)pickTheTime:(id)sender {

}

- (IBAction)submitInfo:(id)sender {
    //nothing here right now
}

-(void)submitButtonTouched:(UIButton *)submitButton{
    
    self.sharedDataStore.whatWasEaten = self.answerText.text;
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"hamburgerButtonHit" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}

- (void)setBackgroundAndEdits {
    self.view.backgroundColor = [UIColor colorWithRed:127.0f/255.0f
                                                green:235.0f/255.0f
                                                 blue:197.0f/255.0f
                                                alpha:1.0f];
    
    UIColor *gradientMaskLayer = [UIColor colorWithRed:41.0f/255.0f
                                                 green:166.0f/255.0f
                                                  blue:122.0f/255.0f
                                                 alpha:1.0f];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.view.bounds;
    gradientMask.colors = @[(id)gradientMaskLayer.CGColor,
                            (id)[UIColor clearColor].CGColor];
    
    [self.view.layer insertSublayer:gradientMask atIndex:0];
}

- (void)setFontsStyle {
    
    self.whatDidYouEatTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.DescriptionTextBox.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.submitButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    
    [self.backButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f
                                                            green:254.0f/255.0f
                                                             blue:245.0f/255.0f
                                                            alpha:1.0] forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f
                                                            green:254.0f/255.0f
                                                             blue:245.0f/255.0f
                                                            alpha:1.0] forState:UIControlStateNormal];
    
    self.whatDidYouEatTextLabel.textColor = [UIColor colorWithRed:255.0f/255.0f
                                                            green:254.0f/255.0f
                                                             blue:245.0f/255.0f
                                                            alpha:1.0];
    self.DescriptionTextBox.textColor = [UIColor colorWithRed:255.0f/255.0f
                                                            green:254.0f/255.0f
                                                             blue:245.0f/255.0f
                                                            alpha:1.0];
    
    self.backButton.layer.cornerRadius = 12;
    self.backButton.clipsToBounds = YES;
    
    self.submitButton.layer.cornerRadius = 12;
    self.submitButton.clipsToBounds = YES;
    
    [self.backButton.layer setBorderWidth:1];
    self.backButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.submitButton.layer setBorderWidth:1];
    self.submitButton.layer.borderColor = [[UIColor whiteColor] CGColor];
   
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backButton.bottomAnchor constraintEqualToAnchor:self.submitButton.topAnchor constant:-20].active = YES;
    [self.backButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.25].active = YES;
    [self.backButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
    [self.backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.submitButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40].active = YES;
    [self.submitButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.25].active = YES;
    [self.submitButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
    [self.submitButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;

    self.backButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                         green:254.0f/255.0f
                                                          blue:245.0f/255.0f
                                                         alpha:0.25f];

    self.submitButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                         green:254.0f/255.0f
                                                          blue:245.0f/255.0f
                                                         alpha:0.25f];

}

-(void)buildCloseButton{
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor blackColor]];
    [closeButton addTarget:self action:@selector(closeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [closeButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [closeButton.rightAnchor constraintEqualToAnchor:self.view.leftAnchor constant:100].active = YES;
    [closeButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.05].active = YES;
    self.closeButton = closeButton;
}

-(void)closeButtonTouched:(UIButton *)closeButton{
    
    NSLog(@"close");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMenu" object:self];
    //self.swipeRight.enabled = NO;
}





@end
