//
//  AddSpaceObjectViewController.h
//  Out of This World
//
//  Created by Joe Lucero on 7/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceObject.h"

@protocol AddSpaceObjectViewControllerDelegate <NSObject>

@required

- (void) addSpaceObject : (SpaceObject *) spaceObject;

@end

@interface AddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <AddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTF;
@property (strong, nonatomic) IBOutlet UITextField *diameterTF;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTF;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMooonsTF;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTF;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
