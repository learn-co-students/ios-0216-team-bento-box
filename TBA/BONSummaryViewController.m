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





@end
