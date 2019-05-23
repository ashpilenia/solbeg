//
//  ASPhotosController.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASPhotosController.h"
#import "ASSessionManager.h"
#import "ASPhoto.h"
#import "ASImageCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@interface ASPhotosController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray <ASPhoto *> *photosArray;

@end

@implementation ASPhotosController

- (instancetype)initWithAlbum:(ASAlbum *)album {
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    if (self) {
        self.parentAlbum = album;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.parentAlbum.canUpload) {
        self.addPhotoButton.hidden = YES;
    }
    
    self.navigationItem.title = @"PHOTOS";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ASImageCollectionCell class]) bundle:nil]
          forCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier]];
    
    
    [self loadPhotos];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier] forIndexPath:indexPath];
    ASPhoto *photo = [self.photosArray objectAtIndex:indexPath.row];
    cell.photoNameLabel.hidden = YES;
    
    __weak ASImageCollectionCell *weakCell = cell;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photo.photoURL];
    [cell.photoImageView setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                            
                                            weakCell.photoImageView.image = image;
                                            [weakCell layoutSubviews];
                                        }
                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                            
                                            NSLog(@"Shit happened with image loading: %@", photo.photoURL.description);
                                        }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(130, 130);
}

#pragma mark - API

- (void)loadPhotos {
    
    [[ASSessionManager sharedManager] getPhotosForAlbum:self.parentAlbum
                                              onSuccess:^(NSArray *parsedObjects) {
                                                  
                                                  self.photosArray = parsedObjects;
                                                  [self.collectionView reloadData];
                                              }
                                              onFailure:^(NSError *error) {}];
}


#pragma mark - Actions

- (IBAction)addPhotoAction:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)uploadPhoto:(UIImage *)image {
    
    [[ASSessionManager sharedManager] getUploadServerForAlbumId:self.parentAlbum.identifier
                                                      onSuccess:^(NSArray *parsedObjects) {
        
                                                          [self loadPhotosOnServer:[parsedObjects firstObject] andImage:image];
    }
                                                      onFailure:^(NSError *error) {}];
}

- (void)loadPhotosOnServer:(NSString *)serverUrl andImage:(UIImage *)image {
    
    [[ASSessionManager sharedManager] uploadImageForURL:serverUrl
                                              withImage:image
                                              onSuccess:^(NSArray *parsedObjects) {
        
    }
                                              onFailure:^(NSError *error) {
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self uploadPhoto:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
