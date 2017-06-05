//
//  DisclosureDetailViewController.h
//  Nav
//
//  Created by Vasilii on 05.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclosureDetailViewController : UIViewController

@property(weak, readonly, nonatomic) UILabel *label;
@property(copy, nonatomic) NSString *message;

@end
