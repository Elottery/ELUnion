//
//  ELSuccessView.h
//  Pods
//
//  Created by 金秋成 on 2017/1/12.
//
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ELSuccessViewType) {
    ELSuccessViewType_Success,
    ELSuccessViewType_Warning,
    ELSuccessViewType_Error,
};

@interface ELSuccessView : UIView
@property (nonatomic,assign)ELSuccessViewType viewType;
@property (nonatomic,strong)UIColor * strokeColor;

@end
