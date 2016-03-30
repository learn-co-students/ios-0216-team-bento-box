//
//  BONResultsViewController.m
//  TBA
//
//  Created by christopher fleisher on 3/30/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONResultsViewController.h"
#import "BONResultsConstants.h"

@interface BONResultsViewController ()
@property (nonatomic,strong)UILabel *thanksLabel;

@end

@implementation BONResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createThanksLabel];
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
    
    [self.thanksLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:LEADING_CONSTANT].active = YES;
    [self.thanksLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-TRAILING_CONSTANT].active = YES;
    [self.thanksLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:TOP_CONSTANT].active = YES;
    [self.thanksLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:HEIGHT_MULTIPLIER].active = YES;
    
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
