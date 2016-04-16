//
//  ViewController.m
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONHowViewController.h"

@interface BONHowViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *emo5;
@property (weak, nonatomic) IBOutlet UIImageView *emo4;
@property (weak, nonatomic) IBOutlet UIImageView *emo3;

@property (weak, nonatomic) IBOutlet UIImageView *emo2;
@property (weak, nonatomic) IBOutlet UIImageView *emo1;

@end

@implementation BONHowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bg = [UIImage imageNamed:@"confettibg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self.view setOpaque:NO];
    [[self.view layer] setOpaque:NO];
    
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
    NSLog(@"Select the meal type hit");
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
    
    
    
    NSLog(@"Current HH in military: %@. It's %@", currentHour, self.mealTypes[predictedMealIndexInArray]);
    
    [self.mealTypePicker selectRow:predictedMealIndexInArray inComponent:0 animated:YES];
    
    
    //[self class] date:now isBetweenDate:<#(NSDate *)#> andDate:<#(NSDate *)#>
    
    
}
- (IBAction)submitInfo:(id)sender {
    
    
    NSString *theTime = [NSDateFormatter localizedStringFromDate:self.timePicker.date
                                                       dateStyle:0
                                                       timeStyle:NSDateFormatterFullStyle];
    NSString *mealType = self.mealTypes[[self.mealTypePicker selectedRowInComponent:0]];
    
    NSLog(@"You ate %@ at %@", mealType, theTime);
    
    
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


@end