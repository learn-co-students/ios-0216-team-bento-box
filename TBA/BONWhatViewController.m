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

@end

@implementation BONWhatViewController

- (void)viewDidLoad {
    
    self.sharedDataStore = [BONDataStore sharedDataStore];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
 
    UIImage *bg = [UIImage imageNamed:@"confettibg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self.view setOpaque:NO];
    [[self.view layer] setOpaque:NO];
    
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
    self.submitButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
}






@end
