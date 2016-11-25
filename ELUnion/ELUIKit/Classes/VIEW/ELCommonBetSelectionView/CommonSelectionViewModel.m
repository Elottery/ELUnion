//
//  CommonSelectionViewModel.m
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "CommonSelectionViewModel.h"

@implementation CommonSelectionViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attributedTitle    = [[NSAttributedString alloc]initWithString:@"title"];
        self.attributedSubTitle = [[NSAttributedString alloc] initWithString:@"subtitle"];
        self.attributedSelectedTitle    = [[NSAttributedString alloc]initWithString:@"title"];
        self.attributedSelectedSubTitle = [[NSAttributedString alloc] initWithString:@"subtitle"];
        self.cellSpan = 1;
        self.backgroundColor         = [UIColor whiteColor];
        self.selectedBackgroundColor = [UIColor lightGrayColor];
        self.enable = YES;
    }
    return self;
}
@end
