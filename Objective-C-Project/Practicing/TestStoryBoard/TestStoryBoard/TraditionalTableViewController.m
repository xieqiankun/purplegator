//
//  TriditionalTableViewController.m
//  TestStoryBoard
//
//  Created by 谢乾坤 on 2/18/16.
//  Copyright © 2016 QiankunXie. All rights reserved.
//

#import "TraditionalTableViewController.h"
#import "PlayTraditionalViewController.h"
#import "TraditionalTableCellViewTableViewCell.h"
#import "QStack.h"

@interface TraditionalTableViewController ()

@property (strong, nonatomic) NSString *selectedUuid;

@end

@implementation TraditionalTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    QStack *qstack = [QStack sharedQStack];
    
    [qstack getTournaments:^(NSError *error, NSData *data) {
        if(!error){
            
            NSArray *temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Got tournaments");
            qstack.myTournaments = temp;
            
            NSLog(@"%@",temp);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tableView registerClass:[UITableViewCell class]
     //      forCellReuseIdentifier:@"TableCell"];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[QStack sharedQStack] myTraditionalT] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get a new or recycled cell
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"TraditionalTableCell";
    TraditionalTableCellViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tournamet = [[QStack sharedQStack] myTraditionalT][indexPath.row];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.tournamentName.text = tournamet[@"name"];
    cell.tournamentStyle.text = tournamet[@"style"];
    cell.tournamentCategory.text = tournamet[@"questions"][@"category"];
    
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"uuid ");
    
    self.selectedUuid = [[QStack sharedQStack] myTraditionalT][indexPath.row][@"uuid"];
    
    // Push it onto the top of the navigation controller's stack
    [self performSegueWithIdentifier:@"playTraditional" sender:self];
    
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"playTraditional"])
    {
        //if you need to pass data to the next controller do it here
        
        PlayTraditionalViewController *ptc = (PlayTraditionalViewController *)[segue destinationViewController];
        
        ptc.uuid = self.selectedUuid;
        
        NSLog(@"here %@", ptc.uuid);
    }
    
    
    
}


@end