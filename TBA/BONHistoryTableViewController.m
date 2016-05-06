//
//  BONHistoryTableViewController.m
//  
//
//  Created by Daniel Adeyanju on 4/19/16.
//
//

#import "BONHistoryTableViewController.h"
#import "BONDataStore.h"
#import "Meal.h"
#import "BONContainerViewController.h"
#import "TBA-Swift.h"

@interface BONHistoryTableViewController ()
@property(nonatomic, strong) NSArray * pastMeals;
@property(nonatomic,strong) BONDataStore * allMeals;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

@end

@implementation BONHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allMeals = [BONDataStore sharedDataStore];
    [self.allMeals fetchData];
    
    self.sharedFirebaseClient = [BONFirebaseClient sharedFirebaseClient];
    [self.sharedFirebaseClient saveCurrentMealWithData];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.allMeals.userMeals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loggedMeal" forIndexPath:indexPath];
    Meal * currentMeal = [self.allMeals.userMeals objectAtIndex:[self.allMeals.userMeals count]-indexPath.row-1];
    
    UILabel * when = [cell.contentView.subviews objectAtIndex:0];
    when.text = currentMeal.whenWasItEaten;
  
    UIImageView * how = [cell.contentView.subviews objectAtIndex:1];
    how.image = [self getImageFromSentimentNumber:currentMeal.howUserFelt];
    
    UILabel * what = [cell.contentView.subviews objectAtIndex:2];
    what.text = currentMeal.whatWasEaten;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(UIImage *)getImageFromSentimentNumber: (NSString *) sentimentNumber {
    UIImage * img;
    NSInteger num = [sentimentNumber integerValue];
    NSString * imageName;
    switch (num) {
        case 1:
            imageName = @"how1";
            break;
        case 2:
            imageName = @"how2";
            break;
        case 3:
            imageName = @"how3";
            break;
        case 4:
            imageName = @"how4";
            break;
        case 5:
            imageName = @"how5";
            break;
            
        default:
            imageName = @"how5";
            
            break;
    }
    return img = [UIImage imageNamed:imageName];
}

- (IBAction)createNewMeal:(id)sender {
    
    BONContainerViewController *parentViewController = (BONContainerViewController *)self.parentViewController;
    
    parentViewController.userMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                  inManagedObjectContext:parentViewController.localDataStore.managedObjectContext];
    
    parentViewController.userMeal.createdAt = [NSDate date];
    
    parentViewController.viewCounter = 0;
    [parentViewController.childViewControllers removeAllObjects];
    
    UIStoryboard *arielStoryboard = [UIStoryboard storyboardWithName:@"Ariel's Storyboard"
                                                              bundle:nil];
    UIStoryboard *whenStoryboard = [UIStoryboard storyboardWithName:@"BONWhenView"
                                                             bundle:nil];
    UIStoryboard *history= [UIStoryboard storyboardWithName:@"BONHistoryStoryboard"
                                                     bundle:nil];
    ViewController *mealPic = [whenStoryboard instantiateViewControllerWithIdentifier:@"mealPic"];
    
    BONChildViewController *whatViewController = [BONChildViewController new];
    BONChildViewController *whenViewController = [BONChildViewController new];
    
    [whatViewController getQuestionLabel];
    [whenViewController getQuestionLabel];
    
    whatViewController.questionLabel.textColor = [UIColor whiteColor];
    whatViewController.questionLabel.text = @"What did you eat?";
    
    whenViewController.questionLabel.textColor = [UIColor whiteColor];
    whenViewController.questionLabel.text = @"When did you eat?";
    
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"welcome"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"when"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"what"]];
    [parentViewController.childViewControllers addObject:mealPic];
    [parentViewController.childViewControllers addObject:[arielStoryboard instantiateViewControllerWithIdentifier:@"whereViewController"]];
    [parentViewController.childViewControllers addObject:[whenStoryboard instantiateViewControllerWithIdentifier:@"how"]];
    [parentViewController.childViewControllers addObject:[history instantiateViewControllerWithIdentifier:@"historyTableVC"]];
    
    [parentViewController displayContentController:parentViewController.childViewControllers.firstObject];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
