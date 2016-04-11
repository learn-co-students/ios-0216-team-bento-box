//
//  coreDataTestViewController.h
//  TBA
//
//  Created by Bao Tran on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BONDataStore.h"

@interface coreDataTestViewController : UIViewController

@property (nonatomic, strong) BONDataStore *localDataStore;


@property (weak, nonatomic) IBOutlet UITextField *whatTextField;
@property (weak, nonatomic) IBOutlet UITextField *whereTextField;
@property (weak, nonatomic) IBOutlet UITextField *whenTextField;
@property (weak, nonatomic) IBOutlet UITextField *howTextField;

- (IBAction)saveButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *whatLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;

@end
