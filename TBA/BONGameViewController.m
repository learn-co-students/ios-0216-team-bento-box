//
//  BONGameViewController.m
//  BONCustomButton
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 Outlaw Capital. All rights reserved.
//

#import "BONGameViewController.h"
#import "BONButton.h"
#import "BONStatusIndicatorLabel.h"

#define TAP_INCREMENT 0.05f

@interface BONGameViewController ()
@property(nonatomic,strong)BONButton *button;
@property(nonatomic,strong)BONStatusIndicatorLabel *statusLabel;
@property(nonatomic,strong)UILabel *timerLabel;
@property(nonatomic,strong)UIImageView *winnerImage;
@property(nonatomic,strong)UILabel *successLabel1;
@property(nonatomic,strong)UILabel *successLabel2;
@property(nonatomic,weak)NSTimer *hundrethSecondsTimer;
@property(nonatomic,weak)NSTimer *tenthSecondsTimer;
@property(nonatomic,weak)NSTimer *secondsTimer;
@property(nonatomic,assign)NSInteger currentHundrethSeconds;
@property(nonatomic,assign)NSInteger currentTenthSeconds;
@property(nonatomic,assign)NSInteger currentSeconds;
@property(nonatomic,assign)NSInteger tapCount;
@property (nonatomic,strong)UIButton *hamburgerButton;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeRight;
@property (nonatomic,strong)UIButton *submitButton;
@property (nonatomic,strong)UIButton *backButton;

@end

@implementation BONGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildSubmitButton];
    [self buildBackButton];
    [self addSwipeRightGesture];
    [self addSwipeLeftGesture];
    [self addTapGesture];
    [self buildHamburgerButton];
    [self setBackgroundAndEdits];
    [self setFontsStyle];
    
    self.button = [[BONButton alloc] init];
    [self.view addSubview:self.button];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-100].active = YES;
    [self.button.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.15].active = YES;
    [self.button.widthAnchor constraintEqualToAnchor:self.button.heightAnchor].active = YES;

    [self.button setTitle:@"BEAST" forState:UIControlStateNormal];
    [self.button setTitle:@"MODE" forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.statusLabel = [[BONStatusIndicatorLabel alloc] init];
    [self.view addSubview:self.statusLabel];
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.statusLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.statusLabel.bottomAnchor constraintEqualToAnchor:self.button.topAnchor constant:-50].active = YES;
    [self.statusLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.5].active = YES;
    [self.statusLabel.widthAnchor constraintEqualToAnchor:self.button.widthAnchor multiplier:1.1].active = YES;
    
    self.tapCount = 0;
    self.statusLabel.tapLevel = 0;
    
    self.timerLabel = [[UILabel alloc] init];
    [self.view addSubview:self.timerLabel];
    self.timerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.timerLabel.topAnchor constraintEqualToAnchor:self.statusLabel.topAnchor].active = YES;
    [self.timerLabel.leadingAnchor constraintEqualToAnchor:self.statusLabel.trailingAnchor constant:30.0].active = YES;
    self.timerLabel.numberOfLines = 1;
    self.timerLabel.textAlignment = NSTextAlignmentLeft;
    self.timerLabel.text = @"Time: 0.00";
    self.currentHundrethSeconds = 0;
    self.currentTenthSeconds = 0;
    self.currentSeconds = 0;
    
    self.winnerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"broccoliMan"]];
    [self.view addSubview:self.winnerImage];
    self.winnerImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.winnerImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.winnerImage.bottomAnchor constraintEqualToAnchor:self.statusLabel.topAnchor].active = YES;
    [self.winnerImage.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [self.winnerImage.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    self.successLabel1 = [[UILabel alloc] init];
    self.successLabel1.text = @"VEGGIE";
    self.successLabel1.textColor = [UIColor purpleColor];
    self.successLabel1.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:self.successLabel1];
    self.successLabel1.hidden = YES;
    self.successLabel1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.successLabel1.bottomAnchor constraintEqualToAnchor:self.winnerImage.bottomAnchor].active = YES;
    [self.successLabel1.centerXAnchor constraintEqualToAnchor:self.winnerImage.centerXAnchor constant:-70].active = YES;
    [self.successLabel1.heightAnchor constraintEqualToAnchor:self.winnerImage.heightAnchor multiplier:0.6].active = YES;
    
    self.successLabel2 = [[UILabel alloc] init];
    self.successLabel2.text = @"POWER";
    self.successLabel2.textColor = [UIColor purpleColor];
    self.successLabel2.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:self.successLabel2];
    self.successLabel2.hidden = YES;
    self.successLabel2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.successLabel2.bottomAnchor constraintEqualToAnchor:self.winnerImage.bottomAnchor].active = YES;
    [self.successLabel2.centerXAnchor constraintEqualToAnchor:self.winnerImage.centerXAnchor constant:70].active = YES;
    [self.successLabel2.heightAnchor constraintEqualToAnchor:self.winnerImage.heightAnchor multiplier:0.6].active = YES;
}

#pragma mark - Submit and Back Buttons

-(void)buildSubmitButton{
    UIButton *submitButton = [[UIButton alloc] init];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [submitButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    [submitButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:50].active = YES;
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
    [backButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    [backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-50].active = YES;
    [backButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
    self.backButton = backButton;
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}

# pragma mark - Game Button

-(void)buttonTouched:(BONButton *)button{
    if (self.statusLabel.tapLevel + TAP_INCREMENT >= 1.0){
        [self.hundrethSecondsTimer invalidate];
        [self.tenthSecondsTimer invalidate];
        [self.secondsTimer invalidate];
        self.statusLabel.tapLevel = 1.0;
        [self.statusLabel setNeedsDisplay];
        self.successLabel1.hidden = NO;
        self.successLabel2.hidden = NO;
        NSLog(@"TAP LEVEL: %f",self.statusLabel.tapLevel);
    } else{
        self.statusLabel.tapLevel += TAP_INCREMENT;
        [self.statusLabel setNeedsDisplay];
        self.tapCount++;
        NSLog(@"TAP LEVEL: %f",self.statusLabel.tapLevel);
    }
    
    if (self.tapCount == 1) {
        self.hundrethSecondsTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(hundrethSecondsTimerTicked:) userInfo:nil repeats:YES];
        self.tenthSecondsTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tenthSecondsTimerTicked:) userInfo:nil repeats:YES];
        self.secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secondsTimerTicked:) userInfo:nil repeats:YES];
    }
}

#pragma mark - Timers

-(void)hundrethSecondsTimerTicked:(NSTimer *)timer{
    self.currentHundrethSeconds = (self.currentHundrethSeconds +1) % 10;
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %li.%li%li",self.currentSeconds,self.currentTenthSeconds,self.currentHundrethSeconds];
}

-(void)tenthSecondsTimerTicked:(NSTimer *)timer{
    self.currentTenthSeconds = (self.currentTenthSeconds + 1) % 10;
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %li.%li",self.currentSeconds,self.currentTenthSeconds];
}

-(void)secondsTimerTicked:(NSTimer *)timer{
    self.currentSeconds++;
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %li.%li",self.currentSeconds,self.currentTenthSeconds];
}

#pragma mark - Hamburger Time

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
    self.swipeLeft.enabled = YES;
    self.swipeRight.enabled = YES;
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
    
    self.successLabel1.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.successLabel2.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.timerLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.button.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.statusLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
    self.submitButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
    
}



@end
