//
//  BONHowQuestionViewController.h
//  TBA
//
//  Created by Daniel Adeyanju on 3/31/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONResultsViewController.h"

@interface BONHowQuestionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (strong, nonatomic) NSArray *sentimentScale;

@end
