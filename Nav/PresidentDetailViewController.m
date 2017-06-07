//
//  PresidentDetailViewController.m
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "PresidentDetailViewController.h"
#import "President.h"

//@interface PresidentDetailViewController ()

//@end

@implementation PresidentDetailViewController
@synthesize president;
@synthesize fieldLabels;
@synthesize tempValues;
@synthesize textFieldBeingEdited;


//В этом случае текущее представление выталкивается из стека, а предыдущее появляется на вершине стека.
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//сохранение
- (IBAction)save:(id)sender {
    if (textFieldBeingEdited != nil) {
        NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textFieldBeingEdited.tag];
        [tempValues setObject:textFieldBeingEdited.text forKey:tagAsNum];
    }
    for (NSNumber *key in [tempValues allKeys]) {
        switch ([key intValue]) {
            case kNameRowIndex:
                president.name = [tempValues objectForKey:key];
                break;
            case kFromyearRowIndex:
                president.fromYear = [tempValues objectForKey:key];
                break;
            case kToYearFromIndex:
                president.toYear = [tempValues objectForKey:key];
                break;
            case kPartyIndex:
                president.party = [tempValues objectForKey:key];
                break;
            default:
                break;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    NSArray *allControllers = self.navigationController.viewControllers;
    UITableViewController *parent = [allControllers lastObject];
    [parent.tableView reloadData];
}
//убираем клавиатуру
- (IBAction)textFieldDone:(id)sender {
    
    UITextField *senderField = sender;
    NSInteger nextRow = (senderField.superview.tag + 1) % kNumberOfEditableRows;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextRow
                                                                                                                             inSection:0];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:indexPath];
    UITextField *nextField = (id)[nextCell viewWithTag:kTextFieldTag];
    [nextField becomeFirstResponder];
    
    
    /*
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
    NSUInteger row = [textFieldIndexPath row];
    row++;
    if (row >= kNumberOfEditableRows) {
        row = 0;
    }
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:newPath];
    UITextField *nextField = nil;
    for (UIView *oneView in nextCell.contentView.subviews) {
        if ([oneView isMemberOfClass:[UITextField class]]) {
            nextField = (UITextField *)oneView;
        }
    }
    [nextField becomeFirstResponder];
     */
}

#pragma mark -
- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"Name:", @"From:", @"To:", @"Party:", nil];
    self.fieldLabels = array;
    
    //создаем кнопки навигации
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    self.tempValues = dict;
    
    [super viewDidLoad];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfEditableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PresidentCellIdentifier = @"PresidentCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PresidentCellIdentifier];
        
        //Создавая новую ячейку, мы создаем метку, применяем к ней выравнивание по правому краю и полужирное написание, а также присваиваем ее тегу, чтобы впоследствии мы могли ее считать снова. Затем добавляем ее в содержимое ячейки contentView и освобождаем занимаемую ею память.
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
        label.tag = kLabelTag;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        
        //создаем новое текстовое поле, в которое пользователь будет вводить текст. Мы устанавливаем его так, чтобы при редактировании не стиралось текущее значение, и поэтому не теряем существующие данные. Установив делегат этого текстового поля равным self, мы можем получать уведомления от текстового поля при возникновении определенных событий за счет реализации соответствующих методов из протокола UITextFieldDelegate. Как будет показано ниже, мы реализовали два метода делегатов текстовых полей в этом классе. Эти методы будут вызываться текстовыми полями во всех строках, когда пользователь начинает и заканчивает редактирование текста, который в них содержится. Мы также устанавливаем для клавиатуры тип клавиши возврата (return key type), который означает текст, задаваемый для клавиши, расположенной в нижнем правом углу клавиатуры. По умол- чанию используется значение Return, но поскольку здесь у нас применяются только одно- строчные поля, мы хотим, чтобы на этой клавише было написано “Done”, поэтому передаем свойству returnKeyType значение UIReturnKeyDone.
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25)];
        textField.clearsOnBeginEditing = NO;
        [textField setDelegate:self];
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
    }
    NSUInteger row = [indexPath row];
    
    //На этом этапе нам известно, что у нас совершенно новая или повторно используемая ячейка, но мы не знаем, какая именно. К счастью, это не важно; обе ситуации можно обраба- тывать одинаково. Нужно лишь иметь ссылку на метку и текстовое поле в этой ячейке. Мы задаем заголовок метки с ассоциированным значением и массива свойств fieldLabels.
    UILabel *label = (UILabel *)[cell viewWithTag:kLabelTag];
    UITextField *textField = nil;
    for (UIView *oneView in cell.contentView.subviews) {
        if ([oneView isMemberOfClass:[UITextField class]]) {
            textField = (UITextField *)oneView;
        }
    }
    
    //Для текстового поля дело обстоит несколько сложнее, поскольку нам нужен дескриптор, чтобы сообщить делегатам текстового поля, какое именно текстовое поле их вызывает. Мы задаем дескриптор родительского представления, а не дескриптор текстового поля, потому что он использовался ранее для поиска текстового поля точно так же, как и метка.
    label.text = [fieldLabels objectAtIndex:row];
    NSNumber *rowAsNum = [[NSNumber alloc] initWithInt:row];
    //В заключение присваиваем этому полю соответствующее значение свойства president.
    switch (row) {
        case kNameRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.name;
            break;
        case kFromyearRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.fromYear;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case kToYearFromIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.toYear;
            break;
        case kPartyIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.party;
            break;
        default:
            break;
    }
    if (textFieldBeingEdited == textField) {
        textFieldBeingEdited = nil;
    }
    textField.tag = row;
    return cell;
}

#pragma mark UITableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark UITextFieldDelegate


//метод вызывается всякий раз, когда текстовое поле, для которого мы являемся делегатом, становится первым ответчиком. Поэтому, если пользователь коснется поля и появится клавиатура, мы получим уведомление. В этом методе мы сохраняем текущий текст в переменной экземпляра initialTex, чтобы проверить, действительно ли пользователь внес изменения, завершив редактирование.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldBeingEdited = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textField.tag];
    [tempValues setObject:textField.text forKey:tagAsNum];
}


@end
