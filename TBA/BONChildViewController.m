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
@property (nonatomic,strong)UILabel *questionLabel;
@property (nonatomic,strong)UITextField *answerTextField;
@property (nonatomic,strong)UIButton *submitButton;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,strong)UIButton *hamburgerButton;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeRight;

@end

@implementation BONChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getQuestionLabel];
    [self buildAnswerTextField];
    [self buildSubmitButton];
    [self buildBackButton];
    [self addSwipeRightGesture];
    [self addSwipeLeftGesture];
    [self addTapGesture];
    [self buildHamburgerButton];
}

#pragma mark - Question and Answer
-(void)getQuestionLabel{
    self.view.backgroundColor = [self randomColor];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.text = [self randomQuestion];
    [self.view addSubview:questionLabel];
    UIColor *backgroundColor = [self randomColor];
    self.view.backgroundColor = backgroundColor;
    questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [questionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [questionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [questionLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.25].active = YES;
    self.questionLabel = questionLabel;
    
}

-(void)buildAnswerTextField{
    UITextField *answerTextField = [[UITextField alloc] init];
    answerTextField.placeholder = [self randomAnswerPlaceHolder];
    answerTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:answerTextField];
    answerTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [answerTextField.topAnchor constraintEqualToAnchor:self.questionLabel.bottomAnchor constant:200].active = YES;
    [answerTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [answerTextField.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.10].active = YES;
    self.answerTextField = answerTextField;
}

#pragma mark - Submit and Back Buttons

-(void)buildSubmitButton{
    UIButton *submitButton = [[UIButton alloc] init];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [submitButton.topAnchor constraintEqualToAnchor:self.answerTextField.bottomAnchor constant:20].active = YES;
    [submitButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [submitButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
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
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [backButton.topAnchor constraintEqualToAnchor:self.submitButton.bottomAnchor constant:20].active = YES;
    [backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [backButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
    self.backButton = backButton;
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}

#pragma mark - Hamburger Button

-(void)buildHamburgerButton{
    UIButton *hamburgerButton = [[UIButton alloc] init];
    [hamburgerButton setTitle:@"Burg" forState:UIControlStateNormal];
    [hamburgerButton addTarget:self action:@selector(hamburgerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hamburgerButton];
    hamburgerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [hamburgerButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [hamburgerButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [hamburgerButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.10].active = YES;
    self.hamburgerButton = hamburgerButton;
}

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
-(NSString *)randomQuestion{
    self.questionArray = @[@"YOU TALKIN' TO ME?",
                           @"ARE YOU ASKING ME?",
                           @"HMMMM, TRY AGAIN?"];
    
    return self.questionArray[arc4random_uniform(3)];
}

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
