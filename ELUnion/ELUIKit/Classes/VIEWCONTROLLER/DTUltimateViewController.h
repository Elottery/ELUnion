//
//  DTUltimateViewController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/9.
//
//

#import <UIKit/UIKit.h>


//controller类型
typedef NS_ENUM(NSUInteger, DTViewControllerType) {
    DTNormalViewController,//最普通的视图控制器
    DTNavigationController,//导航控制器
    DTTabbarController,    //tabbar控制器
    DTContainerController, //容器
};

@protocol DTNormalViewController <NSObject>

@end

@protocol DTNavigationControllerDelegate <NSObject>

@end

@protocol DTTabbarControllerDelegate <NSObject>

@end

@protocol DTContainerController <NSObject>

@end





@interface DTUltimateViewController : UIViewController

@property (nonatomic,assign,readonly)DTViewControllerType dt_viewControllerType;

@property (nonatomic,strong,readonly)NSArray * dt_childViewControllers;

@property (nonatomic,weak)id<DTNormalViewController> normalViewControllerDelegate;

@property (nonatomic,weak)id<DTNavigationControllerDelegate> navigationControllerDelegate;

@property (nonatomic,weak)id<DTTabbarControllerDelegate> tabbarControllerDelegate;

@property (nonatomic,weak)id<DTContainerController> containerControllerDelegate;

-(instancetype)initWithType:(DTViewControllerType)type;

@end
