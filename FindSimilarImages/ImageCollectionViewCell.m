//
//  ImageCollectionViewCell.m
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell ()
@property (nonatomic, strong) UIView *markView;
@end

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGRect contentFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        _imageView = [[UIImageView alloc] initWithFrame:contentFrame];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _markView = [[UIView alloc] initWithFrame:contentFrame];
        _markView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_markView];
    }
    return self;
}

- (void)setMarked:(BOOL)marked {
    _marked = marked;
    self.markView.alpha = _marked ? 0.8 : 0.0;
}

@end
