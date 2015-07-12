//
//  OuterSpaceTableViewController.m
//  Out of This World
//
//  Created by Joe Lucero on 7/8/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "OuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "SpaceObject.h"
#import "SpaceImageViewController.h"
#import "SpaceDataViewController.h"

@interface OuterSpaceTableViewController ()

@end

@implementation OuterSpaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.planets = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]){
        NSString *planetName = [planetData objectForKey:PLANET_NAME];
        SpaceObject *newSpaceObject = [[SpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", planetName]]];
        [self.planets addObject:newSpaceObject];
    }
    
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [myDictionary setObject:firstColor forKey:@"firetruck color"];
//    [myDictionary setObject:@"blue" forKey:@"ocean color"];
//    [myDictionary setObject:@"yellow" forKey:@"star color"];
//    NSLog(@"%@", myDictionary);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    if (self.addedSpaceObjects.count){
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 1) {
        return self.addedSpaceObjects.count;
    }
    return self.planets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"joesCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    if (indexPath.section == 1) {
        //use new space object to customize our cell
    }

    SpaceObject *planet = self.planets[indexPath.row];
    cell.textLabel.text = planet.name;
    cell.detailTextLabel.text = planet.nickname;
    cell.imageView.image = planet.spaceImage;
    
    return cell;
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([sender isKindOfClass:[UITableViewCell class]] && [segue.destinationViewController isKindOfClass:[SpaceImageViewController class]]){
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        SpaceObject *spaceObjectForNextVC = self.planets[path.row];
        SpaceImageViewController *nextVC = segue.destinationViewController;
        nextVC.spaceObject = spaceObjectForNextVC;
    }
    
    else if ([segue.identifier isEqualToString:@"push to space data"]){
        NSIndexPath *path = sender;
        SpaceObject *spaceObjectForNextVC = self.planets[path.row];
        SpaceDataViewController *nextVC = segue.destinationViewController;
        nextVC.spaceObject = spaceObjectForNextVC;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
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



@end
