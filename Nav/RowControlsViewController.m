//
//  RowControlsViewController.m
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "RowControlsViewController.h"

//@interface RowControlsViewController ()

//@end

@implementation RowControlsViewController
@synthesize list;

- (IBAction)buttonTapped:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
    UITableViewCell *buttonCell = (UITableViewCell *)[senderButton superview];
    NSUInteger buttonRow = [[self.tableView indexPathForCell:buttonCell] row];
    NSString *buttonTitle = [list objectAtIndex:buttonRow];
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the button" message:[NSString stringWithFormat:@"You tapped the button for %@", buttonTitle] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You tapped the button"                                                                   message:[NSString stringWithFormat:@"You tapped the button for %@", buttonTitle] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion: nil];
}


- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"R2-D2", @"C3PO", @"Tik-Tok", @"Robby", @"Roise", @"Uniblab", @"Bender", @"Marvin", @"Lt. Commender Data", @"Evil Brother Lore", @"Optimus Prime", @"Tobor", @"HAL", @"Orgasmatron", nil];
    self.list = array;
}

- (void)viewDidUnload {
    self.list = nil;
    [super viewDidUnload];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ControlRowIdentifier = @"ControlRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ControlRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ControlRowIdentifier];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0.0, 0.0, 75, 30);
        [button setTitle:@"Tap" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    NSInteger row = [indexPath row];
    NSString *rowTitle = [list objectAtIndex:row];
    cell.textLabel.text = rowTitle;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSString *rowTitle = [list objectAtIndex:row];
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the row" message:[NSString stringWithFormat:@"You tapped %@.", rowTitle] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     */
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You tapped the row"                                                                  message:[NSString stringWithFormat:@"You tapped %@.", rowTitle] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion: nil];
}

@end
