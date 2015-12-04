//
//  UIImage+PHA.m
//  FindSimilarImages
//
//  Created by 樊远东 on 12/4/15.
//  Copyright © 2015 樊远东. All rights reserved.
//

#import "UIImage+PHA.h"

@implementation UIImage (PHA)

- (UIImage *)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)grayImage {
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (!context) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

- (NSString *)pHashStringValue {
    NSMutableString * pHashString = [NSMutableString string];
    CGImageRef imageRef = [self CGImage];
    unsigned long width = CGImageGetWidth(imageRef);
    unsigned long height = CGImageGetHeight(imageRef);
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    const char * heightData = (char*)data.bytes;
    int sum = 0;
    for (int i = 0; i < width * height; i++) {
        printf("%d ",heightData[i]);
        if (heightData[i] != 0) {
            sum += heightData[i];
        }
    }
    int avr = sum / (width * height);
    NSLog(@"%d",avr);
    for (int i = 0; i < width * height; i++) {
        if (heightData[i] >= avr) {
            [pHashString appendString:@"1"];
        } else {
            [pHashString appendString:@"0"];
        }
    }
    NSLog(@"pHashString = %@,pHashStringLength = %lu",pHashString,(unsigned long)pHashString.length);
    return pHashString;
}

+ (NSInteger)differentValueCountWithString:(NSString *)str1 andString:(NSString *)str2 {
    NSInteger diff = 0;
    const char * s1 = [str1 UTF8String];
    const char * s2 = [str2 UTF8String];
    for (int i = 0 ; i < str1.length ;i++){
        if(s1[i] != s2[i]){
            diff++;
        }
    }
    return diff;
}

+ (NSInteger)differentValueCountWithImage:(UIImage *)image1 andAnotherImage:(UIImage *)image2 {
    NSString *pHashString1 = [[[image1 scaleToSize:CGSizeMake(8.0, 8.0)] grayImage] pHashStringValue];
    NSString *pHashString2 = [[[image2 scaleToSize:CGSizeMake(8.0, 8.0)] grayImage] pHashStringValue];
    return [UIImage differentValueCountWithString:pHashString1 andString:pHashString2];
}

@end
