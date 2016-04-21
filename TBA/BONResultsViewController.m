//
//  BONResultsViewController.m
//  TBA
//
//  Created by christopher fleisher on 3/30/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONResultsViewController.h"
#import "BONResultsConstants.h"
#import "BONDataStore.h"

@interface BONResultsViewController ()
@property (nonatomic,strong) UILabel *thanksLabel;
@property (nonatomic, strong) UIView *resultsView;
@property (nonatomic,strong) NSArray *resultsArray;
@property (nonatomic,strong)UIButton *hamburgerButton;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeRight;
@property (nonatomic,strong) BONDataStore *resultDataStore;

@end

@implementation BONResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
    
    [self.sharedFirebaseClient saveCurrentMealWithData];
    
    // Do any additional setup after loading the view.
    [self buildTestData];
    [self createThanksLabel];
    [self createResultsView];
    [self addSwipeRightGesture];
    [self addTapGesture];
    [self buildHamburgerButton];
    
    [self showResultsOfLastMealLogged:nil];

}

-(void)viewDidLayoutSubviews{
    [self createResultRows];
}

-(void)createThanksLabel{
    self.thanksLabel = [[UILabel alloc] init];
    NSString *thanksMessage = @"Thanks, bruh. You are what you eat. You are therefore a cannibal.";
    self.thanksLabel.text = thanksMessage;
    [self.view addSubview:self.thanksLabel];
    [self formatThanksLabel];
}

-(void)formatThanksLabel{
    self.thanksLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.thanksLabel.backgroundColor = [UIColor blueColor];
    self.thanksLabel.textAlignment = NSTextAlignmentCenter;
    self.thanksLabel.numberOfLines = 0;
    
    [self.thanksLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:LABEL_LEADING_CONSTANT].active = YES;
    [self.thanksLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:LABEL_TRAILING_CONSTANT].active = YES;
    [self.thanksLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:LABEL_TOP_CONSTANT].active = YES;
    [self.thanksLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:LABEL_HEIGHT_MULTIPLIER].active = YES;
}

-(void)createResultsView{
    self.resultsView = [[UIView alloc] init];
    [self.view addSubview:self.resultsView];
    [self formatResultsView];
}

-(void)formatResultsView{
    self.resultsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.resultsView.backgroundColor = [UIColor greenColor];
    
    [self.resultsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:RESULTS_VIEW_LEADING_CONSTANT].active = YES;
    [self.resultsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:RESULTS_VIEW_TRAILING_CONSTANT].active = YES;
    [self.resultsView.topAnchor constraintEqualToAnchor:self.thanksLabel.bottomAnchor constant:RESULTS_VIEW_TOP_CONSTANT].active = YES;
    [self.resultsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:RESULTS_VIEW_BOTTOM_CONSTANT].active = YES;
}

-(void)createResultRows{
    NSInteger numberOfRows = self.resultsArray.count;
    CGFloat resultViewHeight = self.resultsView.bounds.size.height;
    CGFloat rowHeight = resultViewHeight / numberOfRows;
    
    for (NSInteger currentRow = 0; currentRow < numberOfRows; currentRow++) {
        UILabel *newLabel = [[UILabel alloc] init];
        [self.resultsView addSubview:newLabel];
        
        newLabel.translatesAutoresizingMaskIntoConstraints = NO;
        newLabel.backgroundColor = [UIColor grayColor];
        [newLabel.leftAnchor constraintEqualToAnchor:self.resultsView.leftAnchor].active = YES;
        [newLabel.rightAnchor constraintEqualToAnchor:self.resultsView.rightAnchor].active = YES;
        [newLabel.heightAnchor constraintEqualToConstant:rowHeight].active = YES;
        [newLabel.topAnchor constraintEqualToAnchor:self.resultsView.topAnchor constant:rowHeight*currentRow].active = YES;
        
        [self createResultLabelsForRow:newLabel forIndex:currentRow];
    }
}

-(void)createResultLabelsForRow:(UILabel *)label forIndex:(NSInteger)rowCount{
    UILabel *leftLabel = [[UILabel alloc] init];
    UILabel *rightLabel = [[UILabel alloc] init];
    
    [self.resultsView insertSubview:leftLabel aboveSubview:label];
    [self.resultsView insertSubview:rightLabel aboveSubview:label];
    
    NSDictionary *resultDictionary = self.resultsArray[rowCount];
    leftLabel.text = resultDictionary[QUESTION_KEY];
    rightLabel.text = resultDictionary[ANSWER_KEY];
    
    leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [leftLabel.leftAnchor constraintEqualToAnchor:label.leftAnchor constant:RESULTS_ROW_LABEL_LEFT].active = YES;
    [leftLabel.topAnchor constraintEqualToAnchor:label.topAnchor constant:RESULTS_ROW_LABEL_TOP].active = YES;
    [leftLabel.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:RESULTS_ROW_LABEL_BOTTOM].active = YES;
    
    [rightLabel.rightAnchor constraintEqualToAnchor:label.rightAnchor constant:RESULTS_ROW_LABEL_RIGHT].active = YES;
    [rightLabel.topAnchor constraintEqualToAnchor:label.topAnchor constant:RESULTS_ROW_LABEL_TOP].active = YES;
    [rightLabel.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:RESULTS_ROW_LABEL_BOTTOM].active = YES;
}

#pragma mark - Hamburgler
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
}

#pragma mark - Swipe Gestures
-(void)addSwipeRightGesture{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightOccurred:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    self.swipeRight = swipeRight;
}

-(void)swipeRightOccurred:(UISwipeGestureRecognizer *)swipeRight{
    NSLog(@"Swipe right occurred");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"swipeRight" object:self];
}

-(void)addTapGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOccurred:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapOccurred:(UITapGestureRecognizer *)tapTap{
    NSLog(@"Tap occurred");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapTap" object:self];
    self.swipeRight.enabled = YES;
}

#pragma mark - Test Data

-(void)buildTestData{
    
    self.resultsArray = @[
                          [@{QUESTION_KEY : @"How",
                            ANSWER_KEY : @"Like a boss"} mutableCopy],
                          
                          [@{QUESTION_KEY : @"Where",
                            ANSWER_KEY : @"At your mom's house"} mutableCopy],
                          
                          [@{QUESTION_KEY : @"When",
                            ANSWER_KEY : @"Earlier I think"} mutableCopy],
                          
                          [@{QUESTION_KEY : @"What",
                            ANSWER_KEY : @"Giraffe Soup"} mutableCopy],
                          ];
}

#pragma mark - Helper Method

-(void)showResultsOfLastMealLogged:(Meal *)meal{
    
    self.resultDataStore = [BONDataStore sharedDataStore];
    [self.resultDataStore fetchData];
    Meal *mostRecentMeal = self.resultDataStore.userMeals.lastObject;

    
    for (NSMutableDictionary *dictionary in self.resultsArray) {
        if ([[dictionary objectForKey:QUESTION_KEY] isEqualToString:@"How"]) {
            dictionary[ANSWER_KEY] = mostRecentMeal.howUserFelt;
        }
        if ([[dictionary objectForKey:QUESTION_KEY] isEqualToString:@"Where"]) {
            dictionary[ANSWER_KEY] = mostRecentMeal.whereWasItEaten;
        }
        if ([[dictionary objectForKey:QUESTION_KEY] isEqualToString:@"When"]) {
            dictionary[ANSWER_KEY] = mostRecentMeal.whenWasItEaten;
        }
        if ([[dictionary objectForKey:QUESTION_KEY] isEqualToString:@"What"]) {
            dictionary[ANSWER_KEY] = mostRecentMeal.whatWasEaten;
        }
    }
    
    
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
