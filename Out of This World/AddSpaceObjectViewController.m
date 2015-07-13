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
    UIImage *orionImage = [UIImage imageNamed:@"Orion"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate addSpaceObject:[self returnNewSpaceObject]];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (SpaceObject *) returnNewSpaceObject {
    SpaceObject *newSpaceObject = [[SpaceObject alloc] init];
    newSpaceObject.name = self.nameTF.text;
    newSpaceObject.nickname = self.nicknameTF.text;
    newSpaceObject.diameter = [self.diameterTF.text floatValue];
    newSpaceObject.temperature = [self.temperatureTF.text floatValue];
    newSpaceObject.numberOfMoons = [self.numberOfMooonsTF.text intValue];
    newSpaceObject.interestingFact = self.interestingFactTF.text;
    newSpaceObject.spaceImage = [UIImage imageNamed:@"EinsteinRing"];
    
    return newSpaceObject;
}



@end
