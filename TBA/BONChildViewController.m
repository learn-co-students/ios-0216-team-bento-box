//
//  BONChildViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONChildViewController.h"
#import "BONHamburgerViewController.h"

@interface BONChildViewController ()
@property (nonatomic,strong)NSArray *questionArray;
@property (nonatomic,strong)NSArray *answerArray;
@property (nonatomic,strong)NSArray *colorArray;
@property (nonatomic,strong)UIButton *submitButton;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,strong)UIButton *hamburgerButton;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeRight;

@property (nonatomic, weak)NSLayoutConstraint *backButtonConstraint;


@end

@implementation BONChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getQuestionLabel];
    [self buildBackButton];
    [self buildSubmitButton];
    [self buildAnswerTextField];
    [self addSwipeRightGesture];
    [self addSwipeLeftGesture];
    [self addTapGesture];

    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.answerTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}

#pragma mark - Question and Answer
-(void)getQuestionLabel{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.questionLabel = [[UILabel alloc] init];
    [self.view addSubview:self.questionLabel];
    self.questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.questionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [self.questionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.questionLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.25].active = YES;
    
}

-(void)buildAnswerTextField{
    UITextField *answerTextField = [[UITextField alloc] init];
    answerTextField.placeholder = [self randomAnswerPlaceHolder];
    answerTextField.backgroundColor = [UIColor whiteColor];
    [answerTextField.layer setBorderWidth:2.0];
    [answerTextField.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.view addSubview:answerTextField];
    answerTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [answerTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [answerTextField.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.10].active = YES;
    [answerTextField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [answerTextField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [answerTextField.bottomAnchor constraintEqualToAnchor:self.submitButton.topAnchor constant:-10].active = YES;
    self.answerTextField = answerTextField;
    
}

#pragma mark - Submit and Back Buttons

-(void)buildSubmitButton{
    UIButton *submitButton = [[UIButton alloc] init];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [submitButton.layer setBorderWidth:2.0];
    [submitButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [submitButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [submitButton.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.10].active = YES;
    [submitButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.20].active = YES;
    [submitButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    
    self.submitButton = submitButton;
}

-(void)submitButtonTouched:(UIButton *)submitButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

-(void)buildBackButton{
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton.layer setBorderWidth:2.0];
    [backButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [backButton.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.10].active = YES;
    [backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [backButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.20].active = YES;
    self.backButtonConstraint = [backButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10];
    self.backButtonConstraint.active = YES;
    
    self.backButton = backButton;
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}

#pragma mark - Hamburger Button

//-(void)buildHamburgerButton{
//    UIButton *hamburgerButton = [[UIButton alloc] init];
//    [hamburgerButton setTitle:@"Burg" forState:UIControlStateNormal];
//    [hamburgerButton addTarget:self action:@selector(hamburgerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:hamburgerButton];
//    hamburgerButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [hamburgerButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
//    [hamburgerButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
//    [hamburgerButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.10].active = YES;
//    self.hamburgerButton = hamburgerButton;
//}

-(void)hamburgerButtonTouched:(UIButton *)hamburgerButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hamburgerButtonHit" object:self];
    self.submitButton.userInteractionEnabled = NO;
    self.backButton.userInteractionEnabled = NO;
    self.swipeRight.enabled = NO;
    self.swipeLeft.enabled = NO;
}

#pragma mark - Swipe Gestures
-(void)addSwipeRightGesture{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightOccurred:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    self.swipeRight = swipeRight;
}

-(void)addSwipeLeftGesture{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftOccurred:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    self.swipeLeft = swipeLeft;
}

-(void)swipeRightOccurred:(UISwipeGestureRecognizer *)swipeRight{
    NSLog(@"Swipe right occurred");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"swipeRight" object:self];
}

-(void)swipeLeftOccurred:(UISwipeGestureRecognizer *)swipeLeft{
    NSLog(@"Swipe left occurred");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"swipeLeft" object:self];
}

-(void)addTapGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOccurred:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapOccurred:(UITapGestureRecognizer *)tapTap{
    NSLog(@"Tap occurred");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapTap" object:self];
    self.submitButton.userInteractionEnabled = YES;
    self.backButton.userInteractionEnabled = YES;
    self.swipeLeft.enabled = YES;
    self.swipeRight.enabled = YES;
}

#pragma mark - Test Data Builder

-(NSString *)randomAnswerPlaceHolder{
    self.answerArray = @[@"AnSwEr Me",
                         @"Please Answer",
                         @"ANSWER HERE",
                         @"YOU CRAY CRAY"
                         ];
    
    return self.answerArray[arc4random_uniform(4)];
}

-(UIColor *)randomColor{
    self.colorArray = @[[UIColor blueColor],
                        [UIColor grayColor],
                        [UIColor greenColor],
                        [UIColor purpleColor]
                        ];
    
    return self.colorArray[arc4random_uniform(4)];
}

#pragma mark - Gesture Tap Recognizer

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    [self.view endEditing:YES];
}

#pragma mark - Keyboard Show/Hide Methods

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userinfo = notification.userInfo;
    NSValue *keyboardFrameValue = userinfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSNumber *duration = userinfo[UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.backButtonConstraint.constant = -keyboardHeight - 10;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userinfo = notification.userInfo;
    NSNumber *duration = userinfo[UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.backButtonConstraint.constant = -10;
        [self.view layoutIfNeeded];
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
