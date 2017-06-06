//
//  MoveMeViewController.m
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "MoveMeViewController.h"


@implementation MoveMeViewController
@synthesize list;

- (IBAction)toggleMove {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Move"];
}

- (void)viewDidLoad {
    if (list == nil) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"знать", @"сидит", @"Каждый", @"фазан", @"где", @"охотник", @"желает", nil];
        self.list = array;
    }
    
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMove)];
    self.navigationItem.rightBarButtonItem = moveButton;
    [super viewDidLoad];
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MoveMeCellIdentifier = @"MoveMeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoveMeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoveMeCellIdentifier];
        cell.showsReorderControl = YES;
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [list objectAtIndex:row];
    return cell;
}

//метод позволяет табличному представлению выяснить, можно ли удалить заданную строку или вставить но- вую строку в заданную позицию. Возвращая для каждой строки значение UITableViewCell EditingStyleNone, мы выражаем отсутствие поддержки операций вставки и удаления.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [list objectAtIndex:fromRow];
    [list removeObjectAtIndex:fromRow];
    [list insertObject:object atIndex:toRow];
}

@end
