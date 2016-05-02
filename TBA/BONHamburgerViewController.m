//
//  BONHamburgerViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONHamburgerViewController.h"

@interface BONHamburgerViewController ()
@property (nonatomic, strong)NSArray * arr;
@property (nonatomic, strong)UIButton * closeButton;
@end

@implementation BONHamburgerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"1",@"2"];
   //  Do any additional setup after loading the view.
//    UITableView *tableView = [[UITableView alloc] init];
//    tableView.translatesAutoresizingMaskIntoConstraints=NO;
//    [self.view addSubview: tableView];
//    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active=YES;
//    [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
//    [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
//    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active=YES;
//  
//
//    
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [tableView reloadData];
    

    [self buildCloseButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arr count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }

    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

-(void)buildCloseButton{
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor greenColor]];
    [closeButton addTarget:self action:@selector(closeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [closeButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [closeButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [closeButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.30].active = YES;
    self.closeButton = closeButton;
}

-(void)closeButtonTouched:(UIButton *)closeButton{

    NSLog(@"close");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMenu" object:self];
    //self.swipeRight.enabled = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)buildNavbar {
    UIButton * notificationsButton = [[UIButton alloc]init];
    [self.view addSubview:notificationsButton];
    notificationsButton.translatesAutoresizingMaskIntoConstraints=false;
    [notificationsButton.topAnchor constraintEqualToAnchor:self.closeButton.bottomAnchor].active=true;
    [notificationsButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=true;
    [notificationsButton setTitle:@"Notifications" forState:UIControlStateNormal];
    [notificationsButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.3].active=true;
}

@end
