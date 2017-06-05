//
//  DisclosureDetailViewController.m
//  Nav
//
//  Created by Vasilii on 05.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "DisclosureDetailViewController.h"

@interface DisclosureDetailViewController ()

@end

@implementation DisclosureDetailViewController

//реализуем get-метод для свойства label, возвращающий представление контроллера представления; это позволяет ограничить приведение типов только одним методом
- (UILabel *)label {
    
    return (id)self.view;
}

- (void)loadView {
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;//задаем свойство numberOfLines равным нулю, поэтому он отображает произвольное количество строк
    label.textAlignment = NSTextAlignmentCenter;
    self.view = label;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];//задаем раодительскую реализацию
    self.label.text = self.message;//заголовок
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
