//
//  FirstLevelViewController.m
//  Nav
//
//  Created by Vasilii on 03.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonViewController.h"
#import "CheckListViewController.h"
#import "RowControlsViewController.h"
#import "MoveMeViewController.h"
#import "DeleteMeViewController.h"
#import "PresidentsViewController.h"

//@interface FirstLevelViewController ()

//@end

static NSString *CellIdetifier = @"Cell";

@implementation FirstLevelViewController
@synthesize controllers;

- (void)viewDidLoad {
    
    self.title = @"First Level";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdetifier];
    
    // open button
    DisclosureButtonViewController *disclosureButtonController = [[DisclosureButtonViewController alloc] initWithStyle:UITableViewStylePlain];
    disclosureButtonController.title = @"Disclosure Buttons";
    disclosureButtonController.rowImage = [UIImage imageNamed:@"disclosureButtonControllerIcon.png"];
    [array addObject:disclosureButtonController];
    
    // Control list
    CheckListViewController *checkListController = [[CheckListViewController alloc] initWithStyle:UITableViewStylePlain];
    checkListController.title = @"Check One";
    checkListController.rowImage = [UIImage imageNamed:@"checkmarkControllerIcon"];
    [array addObject:checkListController];
    
    // Элементы управления в строках таблицы
    RowControlsViewController *rowControlsController = [[RowControlsViewController alloc] initWithStyle:UITableViewStylePlain];
    rowControlsController.title = @"Row Controls";
    rowControlsController.rowImage = [UIImage imageNamed:@"rowControlsIcon.png"];
    [array addObject:rowControlsController];
    
    // Move me
    MoveMeViewController *moveMeController = [[MoveMeViewController alloc] initWithStyle:UITableViewStylePlain];
    moveMeController.title = @"Move Me";
    moveMeController.rowImage = [UIImage imageNamed:@"moveMeIcon.png"];
    [array addObject:moveMeController];
    
    // Delete me
    DeleteMeViewController *deleteMeController = [[DeleteMeViewController alloc] initWithStyle:UITableViewStylePlain];
    deleteMeController.title = @"Delete Me";
    deleteMeController.rowImage = [UIImage imageNamed:@"deleteMeIcon.png"];
    [array addObject:deleteMeController];
    
    // Presidents of USA
    PresidentsViewController *presidentViewController = [[PresidentsViewController alloc] initWithStyle:UITableViewStylePlain];
    presidentViewController.title = @"Detail Edit";
    presidentViewController.rowImage = [UIImage imageNamed:@"detailEditIcon.png"];
    [array addObject:presidentViewController];
    
    self.controllers = array;
    [super viewDidLoad];

}

- (void)viewDidUnload {
    self.controllers = nil;
    [super viewDidUnload];
}


/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FirstLevelCell = @"FirstLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell];
    }
    // Cell configuration
    NSUInteger row = [indexPath row];
    SecondLevelViewController *controller = [controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
    [self.navigationController pushViewController:nextController animated:YES];
}


@end
