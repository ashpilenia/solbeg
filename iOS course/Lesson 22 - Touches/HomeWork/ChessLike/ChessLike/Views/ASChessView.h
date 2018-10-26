//
//  ASChessView.h
//  ChessLike
//
//  Created by Alex on 10/25/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ASChessView : UIView

@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) NSInteger column;
@property (assign, nonatomic) BOOL isBlack;
@property (assign, nonatomic) BOOL isOccupied;

@end


