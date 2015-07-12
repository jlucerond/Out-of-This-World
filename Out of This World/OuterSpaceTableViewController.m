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

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation

- (NSMutableArray *)planets {
    if (!_planets){
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

- (NSMutableArray *) addedSpaceObjects {
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]){
        NSString *planetName = [planetData objectForKey:PLANET_NAME];
        SpaceObject *newSpaceObject = [[SpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", planetName]]];
        [self.planets addObject:newSpaceObject];
    }
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
        SpaceObject *spaceObject = self.addedSpaceObjects[indexPath.row];
        cell.textLabel.text = [spaceObject.name capitalizedString];
        cell.detailTextLabel.text = [spaceObject.nickname capitalizedString];
        if (!spaceObject.spaceImage){
            cell.imageView.image = [UIImage imageNamed:@"EinsteinRing"];
        }
        else {
            cell.imageView.image = spaceObject.spaceImage;
        }
    }
    
    else {
        SpaceObject *planet = self.planets[indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    
    return cell;
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    //for looking at space pictures
    if ([sender isKindOfClass:[UITableViewCell class]] && [segue.destinationViewController isKindOfClass:[SpaceImageViewController class]]){
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        SpaceObject *spaceObjectForNextVC;
        
        if (path.section == 0){
            spaceObjectForNextVC = self.planets[path.row];
        }
        else if (path.section == 1){
            spaceObjectForNextVC = self.addedSpaceObjects[path.row];
        }
        
        SpaceImageViewController *nextVC = segue.destinationViewController;
        nextVC.spaceObject = spaceObjectForNextVC;
    }
    
    //for learning about space data
    else if ([segue.identifier isEqualToString:@"push to space data"]){
        NSIndexPath *path = sender;
        SpaceObject *spaceObjectForNextVC;
        
        if (path.section == 0){
            spaceObjectForNextVC = self.planets[path.row];
        }
        else if (path.section == 1){
            spaceObjectForNextVC = self.addedSpaceObjects[path.row];
        }
        
        SpaceDataViewController *nextVC = segue.destinationViewController;
        nextVC.spaceObject = spaceObjectForNextVC;
    }
    
    //for adding new space objects
    else if ([segue.destinationViewController isKindOfClass:[AddSpaceObjectViewController class]]){
        AddSpaceObjectViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

#pragma mark - AddSpaceObjectViewControllerDelegate

- (void)addSpaceObject:(SpaceObject *)spaceObject {

    [self.addedSpaceObjects addObject:spaceObject];
    
    // will save to NSUSerDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if (!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // call this helper method to change space object to a property list
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Helper Methods

- (NSDictionary *) spaceObjectAsAPropertyList: (SpaceObject *) spaceObject {
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name,
                                 PLANET_NICKNAME : spaceObject.nickname,
                                 PLANET_DAY_LENGTH : @(spaceObject.dayLength),
                                 PLANET_DIAMETER : @(spaceObject.diameter),
                                 PLANET_GRAVITY : @(spaceObject.gravitationalForce),
                                 PLANET_IMAGE : imageData,
                                 PLANET_INTERESTING_FACT : spaceObject.interestingFact,
                                 PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons),
                                 PLANET_YEAR_LENGTH : @(spaceObject.yearLength)};
    
    return dictionary;
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
