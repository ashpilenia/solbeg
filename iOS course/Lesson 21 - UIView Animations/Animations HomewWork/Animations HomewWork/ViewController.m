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
 
 Мастер.
 
 8. Нарисуйте несколько анимационных картинок человечка, который ходит.
 9. Добавьте несколько человечков на эту композицию и заставьте их ходить
 
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
    
    CGRect rectForImage = CGRectMake(200, 200, 400, 400);
    UIImageView *viewIM = [[UIImageView alloc] initWithFrame:rectForImage];
    viewIM.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewIM];
    
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    UIImage *image2 = [UIImage imageNamed:@"2.png"];
    UIImage *image3 = [UIImage imageNamed:@"3.png"];
    
    NSArray *imageArray = [NSArray arrayWithObjects:image1, image2, image3, nil];
    viewIM.animationImages = imageArray;
    viewIM.animationDuration = 0.3;
    
    CGRect rectForImage2 = CGRectMake(400, 200, 400, 400);
    UIImageView *viewIM2 = [[UIImageView alloc] initWithFrame:rectForImage2];
    viewIM.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewIM2];
    
    viewIM2.animationImages = imageArray;
    viewIM2.animationDuration = 0.2;
    
    CGRect rectForImage3 = CGRectMake(400, 600, 400, 400);
    UIImageView *viewIM3 = [[UIImageView alloc] initWithFrame:rectForImage3];
    viewIM.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewIM3];
    
    viewIM3.animationImages = imageArray;
    viewIM3.animationDuration = 0.5;
    
    CGRect rectForImage4 = CGRectMake(200, 600, 400, 400);
    UIImageView *viewIM4 = [[UIImageView alloc] initWithFrame:rectForImage4];
    viewIM.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewIM4];
    
    viewIM4.animationImages = imageArray;
    viewIM4.animationDuration = 0.165;
    
    

    [viewIM startAnimating];
    [viewIM2 startAnimating];
    [viewIM3 startAnimating];
    [viewIM4 startAnimating];
    
    
    
    

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
    topLeft.alpha = 0.66;
    
    CGRect rectTopRight =  CGRectMake(CGRectGetMaxX(self.view.bounds), 0, -100, 100);
    UIView *topRight = [[UIView alloc] initWithFrame:rectTopRight];
    topRight.backgroundColor = [UIColor yellowColor];
    [self.viewsFromStudent addObject:topRight];
    topRight.alpha = 0.66;
    
    CGRect rectBottomLeft = CGRectMake(0, CGRectGetMaxY(self.view.bounds), 100, -100);
    UIView *bottomLeft = [[UIView alloc] initWithFrame:rectBottomLeft];
    bottomLeft.backgroundColor = [UIColor blueColor];
    [self.viewsFromStudent addObject:bottomLeft];
    bottomLeft.alpha = 0.66;
    
    CGRect rectBottomRight = CGRectMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds), -100, -100);
    UIView *bottomRight = [[UIView alloc] initWithFrame:rectBottomRight];
    bottomRight.backgroundColor = [UIColor greenColor];
    [self.viewsFromStudent addObject:bottomRight];
    bottomRight.alpha = 0.66;
    
    [self.view addSubview:topLeft];
    [self.view addSubview:topRight];
    [self.view addSubview:bottomLeft];
    [self.view addSubview:bottomRight];
    
    [self move:topLeft];
    [self move:topRight];
    [self move:bottomRight];
    [self move:bottomLeft];
    

    
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
    UIColor *col;

    
    switch ([self cornerDetector:tView])
         {
        case 1:
                 if (arc4random()%2)
                 {
                     cent = topRight.center;
                     col = [UIColor yellowColor];
                 }
                 else
                 {
                     cent = bottomLeft.center;
                     col = [UIColor blueColor];
                 }
            
            break;
        case 2:
                 if (arc4random()%2)
                 {
                     cent = bottomRight.center;
                     col = [UIColor greenColor];
                 }
                 else
                 {
                     cent = topLeft.center;
                     col = [UIColor redColor];
                 }
           
            
            break;
        case 3:
                 if (arc4random()%2)
                 {
                     cent = topRight.center;
                     col = [UIColor yellowColor];
                 }
                 else
                 {
                     cent = bottomLeft.center;
                     col = [UIColor blueColor];
                 }
            
          
            
            break;
        case 4:
                 if (arc4random()%2)
                 {
                     cent = topLeft.center;
                     col = [UIColor redColor];
                 }
                 else
                 {
                     cent = bottomRight.center;
                     col = [UIColor greenColor];
                 }
            
      
            
            break;
    
     }
    
    
    [UIView animateKeyframesWithDuration:5
                                delay:1
                                options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    
                                    tView.center = cent;
                                    tView.backgroundColor = col;
                                    
                                }
                            
                              completion:^(BOOL finished) {
                                            __weak UIView *weakView = tView;
                                            [self move:weakView];
                              }];
    
}


- (NSInteger) cornerDetector:(UIView *) vieweD
{
    NSInteger index = 0;
   
    if (vieweD.frame.origin.x == 0 && vieweD.frame.origin.y == 0)
    {
        index = 1; //topLeft
    }
    
    if (vieweD.frame.origin.x == CGRectGetWidth(self.view.bounds) - CGRectGetWidth(vieweD.bounds) && vieweD.frame.origin.y == 0)
    {
        index = 2; //topRight
    }
    
    if (vieweD.frame.origin.x == CGRectGetWidth(self.view.bounds) - CGRectGetWidth(vieweD.bounds) && vieweD.frame.origin.y == CGRectGetHeight(self.view.bounds) - CGRectGetHeight(vieweD.bounds))
    {
        index = 3; //bottomRight
    }
    
    if (vieweD.frame.origin.x == 0 && vieweD.frame.origin.y == CGRectGetHeight(self.view.bounds) - CGRectGetHeight(vieweD.bounds))
    {
        index = 4; //bottomLeft
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
