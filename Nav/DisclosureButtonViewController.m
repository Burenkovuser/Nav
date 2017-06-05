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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Настройка инициализации
        self.title = @"Disclosure Buttons";
        self.rowImage = [UIImage imageNamed:@"disclosureButtonControllerIcon.png"];
        self.movies = @[@"Toy Story", @"A Bug's Life", @"Toy Story 2",
                        @"Monsters, Inc.", @"Finding Nemo", @"The Incredibles", @"Cars", @"Ratatouille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"Brave"];
        self.detailController = [[DisclosureDetailViewController alloc] init];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Дополнительная настройка после загрузки представления.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}
/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = self.movies[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Hey, do you see the disclosure button?" message:@"Touch that to drill down instead." delegate:nil
                          cancelButtonTitle:@"Won't happen again" otherButtonTitles:nil];
    [alert show];
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hey, do you see the disclosure button?"
                                                                   message:@"Touch that to drill down instead." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Won't happen again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel action selected");
    }];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion: nil];
    */
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    self.detailController.title = @"Disclosure Button Pressed";
    NSString *selectedMovie = self.movies[indexPath.row];
    NSString *detailMessage = [NSString stringWithFormat:@"This is details for %@", selectedMovie];
    
    self.detailController.message = detailMessage;
    self.detailController.title = selectedMovie;
    
    [self.navigationController pushViewController:self.detailController animated:YES];
    
    
}

@end
