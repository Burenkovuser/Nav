//
//  MoveMeViewController.h
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface MoveMeViewController : SecondLevelViewController


@property(nonatomic, strong) NSMutableArray *list;
- (IBAction)toggleMove;

@end
