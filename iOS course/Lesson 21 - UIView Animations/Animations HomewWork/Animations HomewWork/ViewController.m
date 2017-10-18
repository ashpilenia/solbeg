//
//  ViewController.m
//  Animations HomewWork
//
//  Created by Alex on 10/16/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/*
 
 Ученик.
 
 1. Создайте 4 вьюхи у левого края ипада.
 2. Ваша задача всех передвинуть горизонтально по прямой за одно и тоже время
 3. Для каждой вьюхи используйте свою интерполяцию (EasyInOut, EasyIn и т.д.). Это для того, чтобы вы увидели разницу своими собственными глазами :)
 4. Добавте реверсивную анимацию и бесконечные повторения
 5. добавьте смену цвета на рандомный
 
 Студент.
 
 5. Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
 6. За одинаковое время и при одинаковой интерполяции двигайте их всех случайно, либо по, либо против часовой стрелки в другой угол.
 7. Когда анимация закончиться повторите все опять: выберите направление и передвиньте всех :)
 8. Вьюха должна принимать в новом углу цвет той вьюхи, что была здесь до него ;)
 
 */

@property (nonatomic, strong) NSMutableArray *viewHolder;
@property (nonatomic, strong) NSMutableArray *viewsFromStudent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.viewHolder = [[NSMutableArray alloc] init];
    self.viewsFromStudent = [[NSMutableArray alloc] init];

}

- (void) viewDidAppear:(BOOL)animated
{
    
    
    for (int i = 0; i < 4; i++) // создаем вьюхи из Ученика
    {
        CGRect rect = CGRectMake(0, 250 + ((i+1) * 150), 100, 100);
        UIView *view = [[UIView alloc] initWithFrame:rect];
        
        view.backgroundColor = [UIColor purpleColor];
        
        [self.view addSubview:view];
        
        [self.viewHolder addObject:view];
    }
 
    UIViewAnimationOptions (^curveBlock)(NSInteger) = ^(NSInteger index){
        
        UIViewAnimationOptions option;
        switch (index) {
            case 0:
                option = UIViewAnimationOptionCurveEaseInOut;
                break;
            case 1:
                option = UIViewAnimationOptionCurveEaseIn;
                break;
            case 2:
                option = UIViewAnimationOptionCurveEaseOut;
                break;
            case 3:
                option = UIViewAnimationOptionCurveLinear;
                break;
                
            default:
                NSLog(@"Invalid index was entered.");
                option = UIViewAnimationOptionCurveEaseInOut;
                break;
        }
        return option;

    };
    

    //анимируем вьюхи из Ученка
    for (UIView *obj in self.viewHolder)
    {
        
        [UIView animateWithDuration:5
                              delay:1
                            options:curveBlock([self.viewHolder indexOfObject:obj]) | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                         animations:^{
                             
                             obj.center = CGPointMake((CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(obj.bounds) / 2)), 250 + (([self.viewHolder indexOfObject:obj]+1) * 150 + (CGRectGetHeight(obj.bounds)/2)));
                             
                             obj.backgroundColor = [self randomColor];
                         }
                         completion:^(BOOL finished) {
                            
                         }];
    }

    
    
    //создаем вьюхи из Студента
    CGRect rectTopLeft = CGRectMake(0, 0, 100, 100);
    UIView *topLeft = [[UIView alloc] initWithFrame:rectTopLeft];
    topLeft.backgroundColor = [UIColor redColor];
    [self.viewsFromStudent addObject:topLeft];
    
    CGRect rectTopRight =  CGRectMake(CGRectGetMaxX(self.view.bounds), 0, -100, 100);
    UIView *topRight = [[UIView alloc] initWithFrame:rectTopRight];
    topRight.backgroundColor = [UIColor yellowColor];
    [self.viewsFromStudent addObject:topRight];
    
    CGRect rectBottomLeft = CGRectMake(0, CGRectGetMaxY(self.view.bounds), 100, -100);
    UIView *bottomLeft = [[UIView alloc] initWithFrame:rectBottomLeft];
    bottomLeft.backgroundColor = [UIColor blueColor];
    [self.viewsFromStudent addObject:bottomLeft];
    
    CGRect rectBottomRight = CGRectMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds), -100, -100);
    UIView *bottomRight = [[UIView alloc] initWithFrame:rectBottomRight];
    bottomRight.backgroundColor = [UIColor greenColor];
    [self.viewsFromStudent addObject:bottomRight];
    
    [self.view addSubview:topLeft];
    [self.view addSubview:topRight];
    [self.view addSubview:bottomLeft];
    [self.view addSubview:bottomRight];
    
    [self move:topLeft];
    [self move:topRight];
    [self move:bottomLeft];
    [self move:bottomRight];
    

    
   
    
//    typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
//        UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
//        UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
//        UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
//        UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
//        UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
//        UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
//        UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
//        UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
//        UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
//        UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
//
//        UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
//        UIViewAnimationOptionCurveEaseIn               = 1 << 16,
//        UIViewAnimationOptionCurveEaseOut              = 2 << 16,
//        UIViewAnimationOptionCurveLinear
    
    
    

    
}


- (void) move:(UIView *) tView
{
    CGRect rectTopLeft = CGRectMake(0, 0, 100, 100);
    UIView *topLeft = [[UIView alloc] initWithFrame:rectTopLeft];
    
    CGRect rectTopRight =  CGRectMake(CGRectGetMaxX(self.view.bounds), 0, -100, 100);
    UIView *topRight = [[UIView alloc] initWithFrame:rectTopRight];
    
    CGRect rectBottomLeft = CGRectMake(0, CGRectGetMaxY(self.view.bounds), 100, -100);
    UIView *bottomLeft = [[UIView alloc] initWithFrame:rectBottomLeft];
    
    CGRect rectBottomRight = CGRectMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds), -100, -100);
    UIView *bottomRight = [[UIView alloc] initWithFrame:rectBottomRight];
    

    CGPoint cent;
    
    switch ([self cornerDetector:tView]) {
        case 1:
            cent = topRight.center;
            
            break;
        case 2:
            
            cent = bottomRight.center;
            
            break;
        case 3:
            
            cent = bottomLeft.center;
            
            break;
        case 4:
            
            cent = topLeft.center;
            
            break;
    }
    
//    CGFloat x = arc4random_uniform(1000);
//    CGFloat y = arc4random_uniform(1000);
    
    [UIView animateKeyframesWithDuration:5
                                delay:1
                                options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    
                                    tView.center = cent;
                                    
                                }
                            
                              completion:^(BOOL finished) {
                                            __weak UIView *weakView = tView;
                                            [self move:weakView];
                              }];
    
}


- (NSInteger) cornerDetector:(UIView *) vieweD
{
    NSInteger index = 0;
    if (vieweD.frame.origin.x == 0 & vieweD.frame.origin.y == 0)
    {
        index = 1; //topLeft
    }
    if (vieweD.frame.origin.x == 0 & vieweD.frame.origin.y == CGRectGetHeight(self.view.bounds))
    {
        index = 3; //bottomLeft
    }
    if (vieweD.frame.origin.x == CGRectGetMaxX(self.view.bounds) & vieweD.frame.origin.y == 0)
    {
        index = 2; //topRight
    }
    if (vieweD.frame.origin.x == CGRectGetMaxX(self.view.bounds) & vieweD.frame.origin.y == CGRectGetMaxY(self.view.bounds))
    {
        index = 4; //bottomRight
    }
    
    return index;
}

- (UIColor *) randomColor
{
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
