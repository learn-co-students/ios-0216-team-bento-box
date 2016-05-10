//
//  ViewController.m
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONSummaryViewController.h"
#import "Meal.h"
#import "BONDataStore.h"
@interface BONSummaryViewController()
@property (weak, nonatomic) IBOutlet UILabel *whatText;
@property (weak, nonatomic) IBOutlet UILabel *whereText;
@property (weak, nonatomic) IBOutlet UIImageView *howImage;
@property (weak, nonatomic) BONDataStore * resultDataStore;
@property (nonatomic) NSUInteger  mealIndex;
@end

@implementation BONSummaryViewController

-(instancetype)initWithMealIndex: (NSUInteger) index{
    self = [super init];
    if(self){
        _mealIndex = index;
    }
    return self;
}


- (void)viewDidLoad {

    NSUInteger  size = [self.resultDataStore.userMeals count];
    [self setResultsFieldsWithLastObject];
    [self setBackgroundAndEdits];
 

    
//    [self.submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)submitButtonTouched:(UIButton *)submitButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}

-(void)setResultsFields: (NSUInteger) mealIndex {
    
    self.resultDataStore = [BONDataStore sharedDataStore];
    [self.resultDataStore fetchData];
    Meal *currentMeal = self.resultDataStore.userMeals[mealIndex];
    
    self.whereText.text =currentMeal.whereWasItEaten;
    self.whatText.text = currentMeal.whatWasEaten;
}

-(void)setResultsFieldsWithLastObject {
    
    self.resultDataStore = [BONDataStore sharedDataStore];
    [self.resultDataStore fetchData];
    Meal *currentMeal = self.resultDataStore.userMeals.lastObject;
    
    self.whereText.text =currentMeal.whereWasItEaten;
    self.whatText.text = currentMeal.whatWasEaten;
    NSLog(@"%@", currentMeal.howUserFelt);
    NSString * imageName = [NSString stringWithFormat:@"how%@", currentMeal.howUserFelt];
    self.howImage.image= [UIImage imageNamed:imageName];
    [self.howImage setContentMode:UIViewContentModeScaleAspectFit];
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




@end
