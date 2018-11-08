//
//  ViewController.m
//  Gestures Home Work
//
//  Created by Alex on 11/6/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *workImageView;
@property (nonatomic, assign) CGFloat workViewScale;
@property (nonatomic, assign) CGFloat workViewRotation;

@end

@implementation ViewController

/*
 Ученик
 
 1. Добавьте квадратную картинку на вьюху вашего контроллера
 2. Если хотите, можете сделать ее анимированной
 
 Студент
 
 3. По тачу анимационно передвигайте картинку со ее позиции в позицию тача
 4. Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)
 
 Мастер
 
 5. Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
 6. То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
 7. По двойному тапу двух пальцев останавливайте анимацию
 
 Супермен
 
 8. Добавьте возможность зумить и отдалять картинку используя пинч
 9. Добавьте возможность поворачивать картинку используя ротейшн
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *workView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crashTest.png"]];
    
    workView.frame = CGRectMake(0, 0, workView.image.size.width, workView.image.size.height);
    
    self.workImageView = workView;
    
    self.workImageView.center = self.view.center;
    
    [self.view addSubview:self.workImageView];

    self.view.backgroundColor = [UIColor magentaColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    
    
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleRightSwipe:)];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleLeftSwipe:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 2;
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handelRotation:)];
    rotationGesture.delegate = self;
    
    
    [self.view addGestureRecognizer:tapGesture];
    [self.view addGestureRecognizer:rightSwipeGesture];
    [self.view addGestureRecognizer:leftSwipeGesture];
    [self.view addGestureRecognizer:doubleTapGesture];
    [self.view addGestureRecognizer:pinchGesture];
    [self.view addGestureRecognizer:rotationGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

#pragma mark - Private Methods

- (void)rotateImageWithAnimation:(CGFloat)angle repeats:(NSInteger)times
{
    __block NSInteger index = times;
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:1.5f delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.workImageView.transform = CGAffineTransformRotate(self.workImageView.transform, angle);
    } completion:^(BOOL finished) {
        
        index -= 1;
        if (index && finished)
        {
            [weakSelf rotateImageWithAnimation:angle repeats:index];
        }
    }];
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    [UIView animateWithDuration:2 animations:^{
        
        self.workImageView.center = [tapGesture locationInView:self.view];
    }];
    
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)rightSwipeGesture
{
    [self.workImageView.layer removeAllAnimations];
    [self rotateImageWithAnimation:3.14f repeats:2];
}



- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)leftSwipeGesture
{
    [self.workImageView.layer removeAllAnimations];
    [self rotateImageWithAnimation:-3.14f repeats:2];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTapGesture
{
    [self.workImageView.layer removeAllAnimations];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGesture
{
    if (pinchGesture.state == UIGestureRecognizerStateBegan)
    {
        self.workViewScale = 1.f;
    }
    CGFloat newScale =  1.f + pinchGesture.scale - self.workViewScale;
    CGAffineTransform currentTransform = self.workImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.workImageView.transform = newTransform;
    
    self.workViewScale = pinchGesture.scale;
}

- (void)handelRotation:(UIRotationGestureRecognizer *)rotationGesture
{
    if (rotationGesture.state == UIGestureRecognizerStateBegan)
    {
        self.workViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.workViewRotation;
    
    CGAffineTransform currentTransform = self.workImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.workImageView.transform = newTransform;
    
    self.workViewRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
