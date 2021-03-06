//
//  ViewController.m
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONHowViewController.h"

@interface BONHowViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *howQuestionTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *emo5;
@property (weak, nonatomic) IBOutlet UIImageView *emo4;
@property (weak, nonatomic) IBOutlet UIImageView *emo3;
@property (weak, nonatomic) IBOutlet UIImageView *emo2;
@property (weak, nonatomic) IBOutlet UIImageView *emo1;
@property (weak, nonatomic) IBOutlet UITextView *howUserFeltTextLabel;

@end

@implementation BONHowViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setBackgroundAndEdits];
    [self setFontsStyle];
    
    NSDate* currentDate = [NSDate date];
    NSTimeZone* currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    NSTimeZone* nowTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:currentDate];
    NSInteger nowGMTOffset = [nowTimeZone secondsFromGMTForDate:currentDate];
    
    NSTimeInterval interval = nowGMTOffset - currentGMTOffset;
    NSDate* nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:currentDate];
    
    [self.timePicker setDate:nowDate animated:YES];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mealTypes = @[@"Breakfast",@"Lunch", @"Dinner", @"Snack"];
    self.mealTypePicker.dataSource = self;
    self.mealTypePicker.delegate = self;
    
    [self selectTheMealType];
    
    [self setupAllTheGestureRecognizers];
    
    //Change va
    [self.timePicker addTarget:self action:@selector(selectTheMealType) forControlEvents:UIControlEventValueChanged];
    
    [self.submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupAllTheGestureRecognizers {
    NSArray *imageViews = @[ self.emo1, self.emo2, self.emo3, self.emo4, self.emo5];
    
    for (UIImageView *view in imageViews) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(saveNumber:)];
        
        [view addGestureRecognizer:tapGesture];
        view.userInteractionEnabled = YES;
    }
    
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pickTheTime:(id)sender {
    
}


-(void)selectTheMealType{
    
    //using the selected time determine what type of meal it is
    //6-12 - breakfast; 12-4 - lunch; 1-12 dinner
    NSDate *now = self.timePicker.date;
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH"];
    
    NSString * currentHour= [df stringFromDate:now];
    
    
    NSInteger hourInt = [currentHour integerValue];
    
    NSInteger predictedMealIndexInArray=0;
    
    if(hourInt>=5 && hourInt <12){
        predictedMealIndexInArray =0;
        
    } else  if(hourInt>=12 && hourInt <16) {
        predictedMealIndexInArray =1;
        
    } else if(hourInt>=16 && hourInt <=24){
        predictedMealIndexInArray =2;
        
    }
    
    [self.mealTypePicker selectRow:predictedMealIndexInArray inComponent:0 animated:YES];
    
    
    //[self class] date:now isBetweenDate:<#(NSDate *)#> andDate:<#(NSDate *)#>
    
}
- (IBAction)submitInfo:(id)sender {
    
    
    NSString *theTime = [NSDateFormatter localizedStringFromDate:self.timePicker.date
                                                       dateStyle:0
                                                       timeStyle:NSDateFormatterFullStyle];
    NSString *mealType = self.mealTypes[[self.mealTypePicker selectedRowInComponent:0]];
}

-(void)submitButtonTouched:(UIButton *)submitButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}



-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.mealTypes count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.mealTypes[row];
}

-(void)addGestureRecognizers {
    //    UIGestureRecognizer * clicked = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(saveNumber)];
    //    [self.emo1 addGestureRecognizer:clicked];
}

-(void)saveNumber:(UITapGestureRecognizer *)sender {
    
    NSArray *imageViews = @[ self.emo1, self.emo2, self.emo3, self.emo4, self.emo5];
    
    UIImageView *tappedView = (UIImageView *)sender.view;
    NSInteger indexOfTappedView = [imageViews indexOfObject:tappedView]+1;
    
    self.howNumber = indexOfTappedView;
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
    
    self.howQuestionTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];

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
    
    self.howQuestionTextLabel.textColor = [UIColor colorWithRed:255.0f/255.0f
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


@end
