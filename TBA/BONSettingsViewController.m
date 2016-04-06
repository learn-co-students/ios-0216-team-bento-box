//
//  BONSettingsViewController.m
//  TBA
//
//  Created by christopher fleisher on 3/30/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONSettingsViewController.h"
#import "BONSettingsConstants.h"

@interface BONSettingsViewController ()
@property (nonatomic,strong) UILabel *headingLabel;
@property (nonatomic, strong) UIView *settingsView;
@property (nonatomic,strong) NSArray *settingsNameArray;
@property (nonatomic,strong)NSMutableDictionary *settingsDictionary;

@end

@implementation BONSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Settings view controller loaded");
    [self buildTestData];
    [self createHeadingLabel];
    [self createSettingsView];
}

-(void)viewDidLayoutSubviews{
    [self createResultRows];
    
}

-(void)createHeadingLabel{
    self.headingLabel = [[UILabel alloc] init];
    NSString *headingMessage = @"Mind Your Own Mindfulness";
    self.headingLabel.text = headingMessage;
    [self.view addSubview:self.headingLabel];
    [self formatHeadingLabel];
}

-(void)formatHeadingLabel{
    self.headingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headingLabel.backgroundColor = [UIColor blueColor];
    self.headingLabel.textAlignment = NSTextAlignmentCenter;
    self.headingLabel.numberOfLines = 0;
    
    [self.headingLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:SETTINGS_LABEL_LEADING_CONSTANT].active = YES;
    [self.headingLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:SETTINGS_LABEL_TRAILING_CONSTANT].active = YES;
    [self.headingLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:SETTINGS_LABEL_TOP_CONSTANT].active = YES;
    [self.headingLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:SETTINGS_LABEL_HEIGHT_MULTIPLIER].active = YES;
}

-(void)createSettingsView{
    self.settingsView = [[UIView alloc] init];
    [self.view addSubview:self.settingsView];
    [self formatSettingsView];
}

-(void)formatSettingsView{
    self.settingsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.settingsView.backgroundColor = [UIColor greenColor];
    
    [self.settingsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:SETTINGS_VIEW_LEADING_CONSTANT].active = YES;
    [self.settingsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:SETTINGS_VIEW_TRAILING_CONSTANT].active = YES;
    [self.settingsView.topAnchor constraintEqualToAnchor:self.headingLabel.bottomAnchor constant:SETTINGS_VIEW_TOP_CONSTANT].active = YES;
    [self.settingsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:SETTINGS_VIEW_BOTTOM_CONSTANT].active = YES;
}

-(void)createResultRows{
    NSInteger numberOfRows = self.settingsNameArray.count;
    CGFloat settingsViewHeight = self.settingsView.bounds.size.height;
    CGFloat rowHeight = settingsViewHeight / numberOfRows;
    self.settingsDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSInteger currentRow = 0; currentRow < numberOfRows; currentRow++) {
        UILabel *newLabel = [[UILabel alloc] init];
        [self.settingsView addSubview:newLabel];
        
        newLabel.translatesAutoresizingMaskIntoConstraints = NO;
        newLabel.backgroundColor = [UIColor grayColor];
        [newLabel.leftAnchor constraintEqualToAnchor:self.settingsView.leftAnchor].active = YES;
        [newLabel.rightAnchor constraintEqualToAnchor:self.settingsView.rightAnchor].active = YES;
        [newLabel.heightAnchor constraintEqualToConstant:rowHeight].active = YES;
        [newLabel.topAnchor constraintEqualToAnchor:self.settingsView.topAnchor constant:rowHeight*currentRow].active = YES;

        [self createResultLabelsForRow:newLabel forIndex:currentRow];
    }
}

-(void)createResultLabelsForRow:(UILabel *)label forIndex:(NSInteger)rowCount{
    UILabel *leftLabel = [[UILabel alloc] init];
    UISwitch *rightSwitch = [[UISwitch alloc] init];
    
    [self.settingsView insertSubview:leftLabel aboveSubview:label];
    [self.settingsView insertSubview:rightSwitch aboveSubview:label];
    
    leftLabel.text = self.settingsNameArray[rowCount];
    
    self.settingsDictionary[leftLabel.text] = @{@"row" : @(rowCount),
                                                @"leftLabel" : leftLabel,
                                                @"switch" : rightSwitch
                                                };
    
    leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rightSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    
    [leftLabel.leftAnchor constraintEqualToAnchor:label.leftAnchor constant:SETTINGS_ROW_LABEL_LEFT].active = YES;
    [leftLabel.topAnchor constraintEqualToAnchor:label.topAnchor constant:SETTINGS_ROW_LABEL_TOP].active = YES;
    [leftLabel.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:SETTINGS_ROW_LABEL_BOTTOM].active = YES;
    
    [rightSwitch.rightAnchor constraintEqualToAnchor:label.rightAnchor constant:SETTINGS_ROW_LABEL_RIGHT].active = YES;
    [rightSwitch.centerYAnchor constraintEqualToAnchor:label.centerYAnchor].active = YES;
}


-(void)buildTestData{
    self.settingsNameArray = @[@"Setting 1", @"Setting 2", @"Setting 3", @"Setting 4", @"Setting 5"];
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
