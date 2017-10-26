//
//  ViewController.m
//  TableViewDynamicCells_HomeWork
//
//  Created by Alex on 10/25/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/*
 Ученик.
 
 1. Создайте таблицу которая содержит 1000 разных ячеек.
 2. для каждой ячейки генирируйте радномный цвет.
 3. RGB данные пишите в тексте ячейки, например: RGB(10,20,255)
 4. Также раскрашивайте текст ячейки этим цветом.
 

 
 */

@property (nonatomic, strong) NSString *colorD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorD = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIColor *color = [self randColor];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.colorD];
    cell.backgroundColor = color;
    
    return cell;
}

- (UIColor *) randColor
{
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;

    UIColor *color = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
    
    NSString *tempStr = [self getColorDetails:r green:g blue:b];
    self.colorD = tempStr;
    
    return color;
}

- (NSString *) getColorDetails:(CGFloat) r green:(CGFloat) g blue:(CGFloat) b
{
    NSString *str = [NSString stringWithFormat:@"RGB(%f, %f, %f)", r, g, b];
    return str;
}


@end
