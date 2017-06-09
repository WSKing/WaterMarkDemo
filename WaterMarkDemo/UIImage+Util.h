//
//  UIImage+Util.h
//  AT
//
//  Created by xiao6 on 14-11-5.
//  Copyright (c) 2014年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

- (UIImage *)scaledToSize:(CGSize)newSize;
- (UIImage *)fixOrientation;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


- (UIImage*)blurredImage:(CGFloat)blurAmount;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)screenshot;

- (CGFloat)bestJPEGWithexpectSize:(long)expectSize;
- (CGFloat)bestJPEGCompressionQuality;
- (NSData *)bestJPEGRepresentation;

+ (UIImage *)combineWithImages:(NSArray<UIImage *> *)images;
+ (UIImage *)combine:(UIImage *)leftImage :(UIImage *)rightImage;
@end
