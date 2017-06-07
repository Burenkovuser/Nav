//
//  PresidentsViewController.m
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "PresidentsViewController.h"
#import "PresidentDetailViewController.h"
#import "President.h"



@implementation PresidentsViewController
@synthesize list;

- (void)viewDidLoad {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Presidents" ofType:@"plist"];
    
    NSData *data;
    NSKeyedUnarchiver *unarchiver;//метод NSKeyedUnarchiver, создающий массив, заполненный экземплярами класса BIDPresident из файла, содержащего список свойств.
    
    //Затем загружаем список свойств в переменную data и используем ее для инициализации переменной unarchiver.
    data = [[NSData alloc] initWithContentsOfFile:path];
    unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //Потом мы разархивируем и присваиваем этот массив свойству list и заканчиваем процесс декодирования.
    NSMutableArray *array = [unarchiver decodeObjectForKey:@"Presidents"];
    self.list = array;
    [unarchiver finishDecoding];
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PresidentListCellIdentifier = @"PresidentListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentListCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PresidentListCellIdentifier];
    }
    NSUInteger row = [indexPath row];
    President *thePres = [self.list objectAtIndex:row];
    cell.textLabel.text = thePres.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", thePres.fromYear, thePres.toYear];
    return cell;
}

#pragma mark UITableViewDelegate

//мы создаем новый экземпляр класса PresidentDetailViewController.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    President *prez = [self.list objectAtIndex:row];
    PresidentDetailViewController *childController = [[PresidentDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    childController.title = prez.name;
    childController.president = prez;
    
    [self.navigationController pushViewController:childController animated:YES];
}


@end
