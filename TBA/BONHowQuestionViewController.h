//
//  BONHowQuestionViewController.h
//  TBA
//
//  Created by Daniel Adeyanju on 3/31/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BONHowQuestionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, readonly) NSString *answer;
@property (nonatomic,strong)UILabel *questionLabel;

@end