//
//  BONHistoryViewController.m
//  TBA
//
//  Created by Daniel Adeyanju on 4/18/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHistoryViewController.h"

@interface BONHistoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView * history;

@end

@implementation BONHistoryViewController 

-(void) createTableView {
//    CGFloat  width = self.view.frame.size.height;
//    CGFloat  height = self.view.frame.size.width;
//    CGRect tableFrame = CGRectMake(0, 0, width, height);
    self.history = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.history.delegate = self;
    self.history.dataSource = self;
    
    [self.view addSubview:self.history];
    
    self.history.translatesAutoresizingMaskIntoConstraints = NO;
    [self.history.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.history.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.history.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.history.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    

    
    
    
    NSLog(@"should have been shown");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *regularCell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    
    return regularCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    // Do any additional setup after loading the view.
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
