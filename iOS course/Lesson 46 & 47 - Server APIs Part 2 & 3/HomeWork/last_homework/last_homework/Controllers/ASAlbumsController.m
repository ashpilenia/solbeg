//
//  ASAlbumsController.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASAlbumsController.h"
#import "ASSessionManager.h"
#import "ASAlbum.h"
#import "UIImageView+AFNetworking.h"
#import "ASImageCollectionCell.h"
#import "ASPhotosController.h"

@interface ASAlbumsController ()

@property (nonatomic, strong) NSArray<ASAlbum *> *almbumsArray;

@end

@implementation ASAlbumsController

- (instancetype)init {
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ALBUMS";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ASImageCollectionCell class]) bundle:nil]
          forCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier]];
    
    [self loadAlbums];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.almbumsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier] forIndexPath:indexPath];
    ASAlbum *album = [self.almbumsArray objectAtIndex:indexPath.row];
    cell.photoNameLabel.text = album.name;
    
    __weak ASImageCollectionCell *weakCell = cell;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:album.avatarURL];
    [cell.photoImageView setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                            
                                            weakCell.photoImageView.image = image;
                                            [weakCell layoutSubviews];
                                        }
                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                            
                                            NSLog(@"Shit happened with image loading: %@", album.avatarURL.description);
                                        }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(200, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASPhotosController *vc = [[ASPhotosController alloc] initWithAlbum:[self.almbumsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - API

- (void)loadAlbums {
    
    NSString *iosGroupId = @"-58860049";
    
    [[ASSessionManager sharedManager] getAlbumsForId:iosGroupId
                                           onSuccess:^(NSArray *parsedObjects) {
        
                                               self.almbumsArray = parsedObjects;
                                               [self.collectionView reloadData];
        
                                           }
                                           onFailure:^(NSError *error) {}];
}

@end
