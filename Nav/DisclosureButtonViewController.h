//
//  DisclosureButtonViewController.h
//  Nav
//
//  Created by Vasilii on 05.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "SecondLevelViewController.h"

@class DisclosureDetailViewController;


@interface DisclosureButtonViewController : SecondLevelViewController

@property(copy, nonatomic) NSArray *movies;
@property(strong, nonatomic) DisclosureDetailViewController *detailController;

@end
