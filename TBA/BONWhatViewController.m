//
//  ViewController.m
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONWhatViewController.h"

@interface BONWhatViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;



@end

@implementation BONWhatViewController

- (void)viewDidLoad {
 
    UIImage *bg = [UIImage imageNamed:@"confettibg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self.view setOpaque:NO];
    [[self.view layer] setOpaque:NO];
    
   
 

    
    [self.submitButton addTarget:self action:@selector(submitButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

    [self.backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pickTheTime:(id)sender {

}


- (IBAction)submitInfo:(id)sender {
    //nothing here right now
    
    
}

-(void)submitButtonTouched:(UIButton *)submitButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];
}

-(void)backButtonTouched:(UIButton *)backButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}





@end
