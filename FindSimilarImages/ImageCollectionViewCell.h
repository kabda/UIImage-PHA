//
//  ImageCollectionViewCell.h
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kCellIdentifier = @"kCellIdentifier";

@interface ImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL marked;
@end
