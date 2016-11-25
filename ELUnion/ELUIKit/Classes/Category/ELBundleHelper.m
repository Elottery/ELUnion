//
//  ELBundleHelper.m
//  Pods
//
//  Created by Nicolas on 2016/11/6.
//
//

#import "ELBundleHelper.h"

@implementation ELBundleHelper
+(UIImage *)el_imageNamed:(NSString *)name{
    NSString * path = [[NSBundle bundleForClass:self] pathForResource:@"Imgs" ofType:@"bundle"];
    NSBundle * imageBundle = [NSBundle bundleWithPath:path];
    NSString *bundlePath = [imageBundle pathForResource:name ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:bundlePath];
    return image;
}
+(UINib *)el_nibNamed:(NSString *)name{
    NSString * path = [[NSBundle bundleForClass:self] pathForResource:@"Others" ofType:@"bundle"];
    NSBundle * nibBundle = [NSBundle bundleWithPath:path];
    UINib * n = [UINib nibWithNibName:name bundle:nibBundle];
    return n;
}
@end
