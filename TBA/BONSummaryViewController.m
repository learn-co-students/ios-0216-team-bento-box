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
#import "BONContainerViewController.h"
#import "TBA-Swift.h"
#import "BONFirebaseClient.h"

@interface BONSummaryViewController()

@property (weak, nonatomic) IBOutlet UILabel *whatText;
@property (weak, nonatomic) IBOutlet UILabel *whereText;
@property (weak, nonatomic) IBOutlet UIImageView *howImage;
@property (weak, nonatomic) IBOutlet UIImageView *mealPic;
@property (weak, nonatomic) BONDataStore * resultDataStore;
@property (nonatomic) NSUInteger  mealIndex;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

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
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
    [self.sharedFirebaseClient saveCurrentMealWithData];

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
    
    NSDate * date = currentMeal.createdAt;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy:MM:dd:hh:mm"];
    NSString * dateStringForFilePath = [formatter stringFromDate:date];
    NSString * imagePath = [self fileInDocumentsDirectory:dateStringForFilePath];
    
    
    if([UIImage imageWithContentsOfFile:imagePath]){
        self.mealPic.image = [UIImage imageWithContentsOfFile:imagePath];

    } else{
        NSLog(@"no image found");
    }
    
    NSLog(@"path string: %@",imagePath);
    
//
}

-(NSString *) fileInDocumentsDirectory: (NSString *) directory {
    
    NSURL * fileURL= [[self getDocumentsURL] URLByAppendingPathComponent: directory];
    return fileURL.path;
    
}

-(NSURL *) getDocumentsURL {
    NSURL *documentsURL = [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    
    return documentsURL;
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
- (IBAction)historyTapped:(id)sender {
    BONContainerViewController * parent= [self parentViewController];
    UIViewController *oldController = parent.fromViewController;
    UIViewController * newController = parent.childViewControllers[7];
     [parent cycleFromViewController:oldController toViewController:newController];
}
- (IBAction)newMealButton:(id)sender {
    BONContainerViewController *parentViewController = (BONContainerViewController *)self.parentViewController;
    
    parentViewController.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                                  inManagedObjectContext:parentViewController.localDataStore.managedObjectContext];
    
    parentViewController.userMeal.createdAt = [NSDate date];
    
    parentViewController.viewCounter = 0;
    [parentViewController.childViewControllers removeAllObjects];
    
    UIStoryboard *arielStoryboard = [UIStoryboard storyboardWithName:@"Ariel's Storyboard"
                                                              bundle:nil];
    UIStoryboard *whenStoryboard = [UIStoryboard storyboardWithName:@"BONWhenView"
                                                             bundle:nil];
    UIStoryboard *history= [UIStoryboard storyboardWithName:@"BONHistoryStoryboard"
                                                     bundle:nil];
    ViewController * mealPic = [whenStoryboard instantiateViewControllerWithIdentifier:@"mealPic"];
    


    
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"welcome"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"when"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"what"]];
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"whereViewController"]];
    [parentViewController.childViewControllers addObject:mealPic];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"how"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"summaryVC"]];
    [parentViewController.childViewControllers addObject:[history instantiateViewControllerWithIdentifier:@"historyTableVC"]];
    
    [parentViewController displayContentController:parentViewController.childViewControllers.firstObject];
    

}




@end
