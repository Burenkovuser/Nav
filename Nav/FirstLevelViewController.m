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

#pragma mark - Table view data source

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
