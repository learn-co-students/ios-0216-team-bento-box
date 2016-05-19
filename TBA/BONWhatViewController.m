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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitButtonBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backButtonBottomConstraint;

@property (assign, nonatomic) CGFloat initialSubmitButtonBottomConstraintConstant;
@property (assign, nonatomic) CGFloat initialBackButtonBottomConstraintConstant;

@property (nonatomic, strong)UIButton *closeButton;

@end

@implementation BONWhatViewController

- (void)viewDidLoad {
    
    self.sharedDataStore = [BONDataStore sharedDataStore];
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
    
    [self setButtonAndTextViewConstraintConstants];
    [self setFontsStyle];
    [self setBackgroundAndEdits];
 
    [self.submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
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
   
    self.backButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                         green:254.0f/255.0f
                                                          blue:245.0f/255.0f
                                                         alpha:0.25f];

    self.submitButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                         green:254.0f/255.0f
                                                          blue:245.0f/255.0f
                                                         alpha:0.25f];

}

- (IBAction)submitInfo:(id)sender {
}


- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInformation = notification.userInfo;
    NSValue *keyboardFrameValue = userInformation[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.submitButtonBottomConstraint.constant = self.initialSubmitButtonBottomConstraintConstant + keyboardHeight;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)setButtonAndTextViewConstraintConstants {
    self.initialSubmitButtonBottomConstraintConstant = self.submitButtonBottomConstraint.constant;
    self.initialBackButtonBottomConstraintConstant = self.backButtonBottomConstraint.constant;
}

@end
