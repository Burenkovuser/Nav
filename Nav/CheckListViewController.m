//
//  CheckListViewController.m
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "CheckListViewController.h"

@implementation CheckListViewController
@synthesize list;
@synthesize lastIndexPath;

- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"Who Hash", @"Bubba Gump Shrimp Etouffee", @"Who Pudding", @"Scooby Snacks", @"Everlasting Gobstopper", @"Green Eggs and Ham", @"Soylent Green", @"Hard Track", @"Lembas Bread", @"Roastt Beast", @"Blancmange", nil];
    self.list = array;
    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.list = nil;
    self.lastIndexPath = nil;
    [super viewDidUnload];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CheckMarkCellIdentifier = @"CheckMarkCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckMarkCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckMarkCellIdentifier];
    }
     //устанавливаем метод доступа для демонстрации галочки или не выводим никаких символов, в зависимости от того, совпадают ли текущая строка и строка lastIndexPath. Иначе говоря, если таблица требует ячейку для выделенной строки, то задаем пиктограмму доступа в виде галочки; в противном случае не делаем ничего.
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    cell.textLabel.text = [list objectAtIndex:row];
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;//Если новая и старая строки совпадают, то делать ничего не нужно.
    if (newRow != oldRow) {//Далее проверяем, существует ли ранее выделенная строка. Если она существует, извлекаем ее и делаем ее пиктограмму пустой.
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;//После этого мы сохраняем только выделенную строку в переменной selectedSnack, так что в следующий раз у нас будет выделена именно эта строка.
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//отменить выделение строки, которая была только что выбрана.

}

@end
