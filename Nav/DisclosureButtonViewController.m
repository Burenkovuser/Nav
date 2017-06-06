//
//  DisclosureButtonViewController.m
//  Nav
//
//  Created by Vasilii on 05.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "DisclosureButtonViewController.h"
#import "DisclosureDetailViewController.h"

//@interface DisclosureButtonViewController ()

//@end


static NSString *CellIdentifier = @"Cell";

@implementation DisclosureButtonViewController
@synthesize list;


- (void)viewDidLoad {
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Toy Story", @"A Bug`s Life", @"Toy Story 2", @"Monsters, inc.", @"Finding Nemo", @"The Incredibles" @"Cars", @"Ratatouille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"Brave", nil];
    self.list = array;
    [super viewDidLoad];

}

- (void) viewDidUnload {
    self.list = nil;
    [super viewDidUnload];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DisclosureButtonCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonCellIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSString *rowString = [list objectAtIndex:row];
    cell.textLabel.text = rowString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //старый метод сейчас не используется
    /*
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Hey, do you see the disclosure button?" message:@"Touch that to drill down instead." delegate:nil
                          cancelButtonTitle:@"Won't happen again" otherButtonTitles:nil];
    [alert show];
    */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hey, do you see the disclosure button?"
                                                                   message:@"Touch that to drill down instead." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Won't happen again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel action selected");
    }];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion: nil];
    
}

//метод вызывает сообщение при нажатии на кнопку
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    if (childController == nil) {
        childController = [[DisclosureDetailViewController alloc] initWithNibName:@"DisclosureDetail" bundle:nil];
    }
    childController.title = @"Disclosure Button Pressed";
    NSUInteger row = [indexPath row];
    NSString *selectedMovie = [list objectAtIndex:row];
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"You pressed the disclosure button for %@.", selectedMovie];
    childController.message = detailMessage;
    childController.title = selectedMovie;
    [self.navigationController pushViewController:childController animated:YES];
    
}

@end
