//
//  BONHowQuestionViewController.m
//  TBA
//
//  Created by Daniel Adeyanju on 3/31/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHowQuestionViewController.h"
#import "BONDataStore.h"

@interface BONHowQuestionViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic) Meal *thisMeal;

@end

@implementation BONHowQuestionViewController

- (void)viewDidLoad {
    

    self.thisMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:[BONDataStore sharedDataStore].managedObjectContext];
    [super viewDidLoad];
    
    self.enterButton.enabled = NO;
    
    self.overallFeelingPicker.delegate = self;
    self.overallFeelingPicker.dataSource = self;
    
    self.sentimentScale = @[@"1",
                            @"2",
                            @"3",
                            @"4",
                            @"5",
                            @"6",
                            @"7",
                            @"8",
                            @"9",
                            @"10"];
}


#pragma mark DataSource protocol

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.sentimentScale.count;
}

#pragma mark Delegate protocol

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return self.sentimentScale[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
}

- (IBAction)editingChanged:(id)sender {
    
    if (![self.answerTextField.text isEqualToString:@""]) {
        self.enterButton.enabled = YES;
    }
    else {
        self.enterButton.enabled = NO;
    }
    
    

}

- (IBAction)resultsButtonIsTapped:(id)sender {
    BONResultsViewController *resultsViewController = [BONResultsViewController new];
    
    [self presentViewController:resultsViewController
                       animated:YES
                     completion:nil];
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
