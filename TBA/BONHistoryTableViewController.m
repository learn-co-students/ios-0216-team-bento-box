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

@interface BONHistoryTableViewController ()
@property(nonatomic, strong) NSArray * pastMeals;
@property(nonatomic,strong) BONDataStore * allMeals;

@end

@implementation BONHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allMeals = [BONDataStore sharedDataStore];
    [self.allMeals fetchData];
    
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
    Meal * currentMeal = [self.allMeals.userMeals objectAtIndex:indexPath.row];
    
    UILabel * when = [cell.contentView.subviews objectAtIndex:0];
    when.text = currentMeal.whenWasItEaten;
  
    UIImageView * how = [cell.contentView.subviews objectAtIndex:1];
    how.image = [self getImageFromSentimentNumber:currentMeal.howUserFelt];
    
    UILabel * what = [cell.contentView.subviews objectAtIndex:2];
    what.text = currentMeal.whatWasEaten;
    NSLog(@"current index path: %li", indexPath.row);


    
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
- (IBAction)addMeal:(id)sender {
    
    
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
