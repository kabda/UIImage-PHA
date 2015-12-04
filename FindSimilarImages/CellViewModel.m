//
//  CellViewModel.m
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import "CellViewModel.h"

@interface CellViewModel ()
@property (nonatomic, strong) NSString *pHashString;
@end

@implementation CellViewModel

- (void)setImage:(UIImage *)image {
    _image = image;
    self.pHashString = [[[_image scaleToSize:CGSizeMake(8.0, 8.0)] grayImage] pHashStringValue];
}

@end
