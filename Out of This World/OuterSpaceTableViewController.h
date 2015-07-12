//
//  OuterSpaceTableViewController.h
//  Out of This World
//
//  Created by Joe Lucero on 7/8/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSpaceObjectViewController.h"

@interface OuterSpaceTableViewController : UITableViewController <AddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
