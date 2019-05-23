//
//  ASPhotosController.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASAlbum.h"

@interface ASPhotosController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;

@property (nonatomic, strong) ASAlbum *parentAlbum;

- (IBAction)addPhotoAction:(UIButton *)sender;

- (instancetype)initWithAlbum:(ASAlbum *)album;

@end

