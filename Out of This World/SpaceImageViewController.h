//
//  SpaceImageViewController.h
//  Out of This World
//
//  Created by Joe Lucero on 7/9/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceObject.h"

@interface SpaceImageViewController : UIViewController

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) SpaceObject *spaceObject;

@end
