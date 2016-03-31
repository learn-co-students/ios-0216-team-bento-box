//
//  BONHowQuestionViewController.m
//  TBA
//
//  Created by Daniel Adeyanju on 3/31/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHowQuestionViewController.h"

@interface BONHowQuestionViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *overallFeelingPicker;

@end

@implementation BONHowQuestionViewController

- (void)viewDidLoad {
    self.overallFeelingPicker.delegate = self;
    self.overallFeelingPicker.dataSource = self;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark DataSourcep rotocol
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 10;
}

#pragma mark Delegate protocol
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"Row %i was selected", row+1);
}



- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)componentD{
    
    return [NSString stringWithFormat:@"%i", row+1] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
