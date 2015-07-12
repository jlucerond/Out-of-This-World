//
//  AddSpaceObjectViewController.m
//  Out of This World
//
//  Created by Joe Lucero on 7/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "AddSpaceObjectViewController.h"

@interface AddSpaceObjectViewController ()

@end

@implementation AddSpaceObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *orionImage = [UIImage imageNamed:@"orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
}
@end
