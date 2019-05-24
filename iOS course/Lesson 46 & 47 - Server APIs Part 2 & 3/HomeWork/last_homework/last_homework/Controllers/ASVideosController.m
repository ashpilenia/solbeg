//
//  ASVideosController.m
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASVideosController.h"
#import "ASSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "ASImageCollectionCell.h"
#import "ASVideo.h"
#import "ASVIdeoPlayerController.h"

@interface ASVideosController ()

@property (nonatomic, strong) NSArray *videosArray;

@end

@implementation ASVideosController

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"VIDEOS";
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ASImageCollectionCell class]) bundle:nil]
          forCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier]];
    
   
    [self loadVideos];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videosArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ASImageCollectionCell reuseIdentifier] forIndexPath:indexPath];
    ASVideo *video = [self.videosArray objectAtIndex:indexPath.row];
    cell.photoNameLabel.text = video.videoTitle;
    
    __weak ASImageCollectionCell *weakCell = cell;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:video.photoURL];
    [cell.photoImageView setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                            
                                            weakCell.photoImageView.image = image;
                                            [weakCell layoutSubviews];
                                        }
                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                            
                                            NSLog(@"Shit happened with image loading: %@", video.photoURL.description);
                                        }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(200, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASVIdeoPlayerController *vc = [[ASVIdeoPlayerController alloc] initWithVideo:[self.videosArray objectAtIndex:indexPath.row]];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - API

- (void)loadVideos {
    
    NSString *iosGroupId = @"-58860049";
    
    [[ASSessionManager sharedManager] getVideosForId:iosGroupId
                                           onSuccess:^(NSArray *parsedObjects) {
                                               
                                               self.videosArray = parsedObjects;
                                               [self.collectionView reloadData];
                                           }
                                           onFailure:^(NSError *error) {}];
}





@end
