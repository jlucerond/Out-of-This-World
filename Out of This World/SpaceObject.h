//
//  SpaceObject.h
//  Out of This World
//
//  Created by Joe Lucero on 7/8/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpaceObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gravitationalForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *interestingFact;
@property (strong, nonatomic) UIImage *spaceImage;

- (instancetype) initWithData: (NSDictionary *) data andImage: (UIImage *) image;

@end
