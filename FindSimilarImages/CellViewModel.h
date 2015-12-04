//
//  CellViewModel.h
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+PHA.h"

@interface CellViewModel : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong, readonly) NSString *pHashString;
@property (nonatomic, assign) BOOL marked;
@end
