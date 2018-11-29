//
//  ViewController.m
//  HomeWork - Superman
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.red = 0.0/255.0;
    self.green = 0.0/255.0;
    self.blue = 0.0/255.0;
    self.brush = 10.0;
    self.opacity = 1.0;
}

#pragma mark - Private Methods

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        UIAlertController *failController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Image could not be saved.Please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:failController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *successController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Image was successfully saved in photoalbum" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:successController animated:YES completion:nil];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SettingsViewController *settingsController = (SettingsViewController *)segue.destinationViewController;
    
    settingsController.delegate = self;
    settingsController.brush = self.brush;
    settingsController.opacity = self.opacity;
    settingsController.red = self.red;
    settingsController.green = self.green;
    settingsController.blue = self.blue;
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.f);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);

    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:self.opacity];
    UIGraphicsEndImageContext();

    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.f);

        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());

        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    UIGraphicsBeginImageContext(self.tempDrawImage.frame.size);

    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                               blendMode:kCGBlendModeNormal
                                   alpha:self.opacity];
    
    UIGraphicsEndImageContext();
}

#pragma mark - Actions

- (IBAction)pencilPressed:(UIButton *)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            self.red = 0.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 1:
            self.red = 105.0/255.0;
            self.green = 105.0/255.0;
            self.blue = 105.0/255.0;
            break;
        case 2:
            self.red = 255.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 3:
            self.red = 0.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 255.0/255.0;
            break;
        case 4:
            self.red = 102.0/255.0;
            self.green = 204.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 5:
            self.red = 102.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 6:
            self.red = 51.0/255.0;
            self.green = 204.0/255.0;
            self.blue = 255.0/255.0;
            break;
        case 7:
            self.red = 160.0/255.0;
            self.green = 82.0/255.0;
            self.blue = 45.0/255.0;
            break;
        case 8:
            self.red = 255.0/255.0;
            self.green = 102.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 9:
            self.red = 255.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            break;
    }
}

- (IBAction)eraserPressed:(UIButton *)sender {
    
    self.red = 255.0/255.0;
    self.green = 255.0/255.0;
    self.blue = 255.0/255.0;
    self.opacity = 1.0;
}

- (IBAction)reset:(UIButton *)sender {
    
    self.tempDrawImage.image = nil;
}

- (IBAction)settings:(UIButton *)sender {
}

- (IBAction)save:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *saveToCameraRollAction = [UIAlertAction actionWithTitle:@"Save to Camera Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIGraphicsBeginImageContextWithOptions(self.tempDrawImage.bounds.size, NO, 0);
        [self.tempDrawImage.image drawInRect:CGRectMake(0,
                                                        0,
                                                        self.tempDrawImage.frame.size.width,
                                                        self.tempDrawImage.frame.size.height)];
        UIImage *saveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alertController addAction:saveToCameraRollAction];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Settings Delegate

- (void)closeSettings:(id)sender
{
    SettingsViewController *controller = (SettingsViewController *)sender;
    self.brush = controller.brush;
    self.opacity = controller.opacity;
    self.red = controller.red;
    self.green = controller.green;
    self.blue = controller.blue;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
