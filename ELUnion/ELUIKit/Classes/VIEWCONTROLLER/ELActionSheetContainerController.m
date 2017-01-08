//
//  ELActionSheetContainerController.m
//  Pods
//
//  Created by 金秋成 on 2017/1/7.
//
//

#import "ELActionSheetContainerController.h"
#import "UIView+ELExtention.h"

#define TOPVIEW_HEIGHT    30
#define BOTTOMVIEW_HEIGHT 44


@interface ELActionSheetContainerController ()

@property (nonatomic,strong)NSAttributedString * title;
@property (nonatomic,strong)NSAttributedString * confirmTitle;
@property (nonatomic,strong)NSAttributedString * cancelTitle;


@property (nonatomic,strong)UIView * containerView;

@property (nonatomic,strong)UIView * subView;


@property (nonatomic,assign)CGFloat  subViewHeight;
@property (nonatomic,assign)CGFloat  containerViewHeight;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UIButton * confirmButton;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,assign)BOOL     isInShow;



@property (nonatomic,copy)ELActionSheetContainerControllerOPBlock confirmHandler;
@property (nonatomic,copy)ELActionSheetContainerControllerOPBlock cancelHandler;

@end

@implementation ELActionSheetContainerController


-(instancetype)initWithAttributedTitle:(NSAttributedString *)title
                            andSubView:(UIView *)subView
                      andSubViewHeight:(CGFloat)height
                confirmAttributedTitle:(NSAttributedString *)confirmTitle
                        confirmHandler:(ELActionSheetContainerControllerOPBlock)confirmHandler
                 cancelAttributedTitle:(NSAttributedString *)cancelTitle
                         cancelHandler:(ELActionSheetContainerControllerOPBlock)cancelHandler{
    self = [super init];
    if (self) {
        self.subViewHeight = height;
        self.title = title;
        self.confirmTitle = confirmTitle;
        self.cancelTitle  = cancelTitle;
        self.subView = subView;
        self.confirmHandler = confirmHandler;
        self.cancelHandler  = cancelHandler;
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title
                  andSubView:(UIView *)subView
            andSubViewHeight:(CGFloat)height
                confirmTitle:(NSString *)confirmTitle
              confirmHandler:(ELActionSheetContainerControllerOPBlock)confirmHandler
                 cancelTitle:(NSString *)cancelTitle
               cancelHandler:(ELActionSheetContainerControllerOPBlock)cancelHandler{
    
    self = [super init];
    if (self) {
        self.subViewHeight = height;
        if (title) {
            self.title =[[NSAttributedString alloc]initWithString:title
                                                       attributes:@{NSFontAttributeName:ELTextSize04,
                                                                    NSForegroundColorAttributeName:ELColor03}];
        }
        if (confirmTitle) {
            self.confirmTitle = [[NSAttributedString alloc]initWithString:confirmTitle
                                                               attributes:@{NSFontAttributeName:ELTextSize03,
                                                                            NSForegroundColorAttributeName:ELColor02}];
        }
        if (cancelTitle) {
            self.cancelTitle = [[NSAttributedString alloc]initWithString:cancelTitle
                                                              attributes:@{NSFontAttributeName:ELTextSize03,
                                                                           NSForegroundColorAttributeName:ELColor01}];
        }
        self.subView = subView;
        self.confirmHandler = confirmHandler;
        self.cancelHandler  = cancelHandler;
    }
    return self;
}



-(void)commonInit{
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
    self.containerView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    
    
    [UIView animateWithDuration:0.28
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.50];
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
    self.containerView.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1.00];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.containerView];
    
    if (self.title) {
        self.containerViewHeight = TOPVIEW_HEIGHT;
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.topView.viewExtension setTopLine:YES];
        [self.topView.viewExtension setBottomLine:YES];
        self.topView.backgroundColor = ELColor02;
        self.topView.translatesAutoresizingMaskIntoConstraints    = NO;
        [self.containerView addSubview:self.topView];
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TOPVIEW]-0-|" options:0 metrics:nil views:@{@"TOPVIEW":self.topView}]];
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TOPVIEW(top_height)]"
                                                                                   options:0
                                                                                   metrics:@{@"top_height":@(TOPVIEW_HEIGHT)}
                                                                                     views:@{@"TOPVIEW":self.topView}]];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:self.titleLabel];
        
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        self.titleLabel.attributedText = self.title;
        
        
        
    }
    
    
    self.containerViewHeight += BOTTOMVIEW_HEIGHT+10;
    self.bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.bottomView];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BOTTOMVIEW]-0-|" options:0 metrics:nil views:@{@"BOTTOMVIEW":self.bottomView}]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BOTTOMVIEW(bottom_height)]-0-|"
                                                                               options:0
                                                                               metrics:@{@"bottom_height":@(BOTTOMVIEW_HEIGHT)}
                                                                                 views:@{@"BOTTOMVIEW":self.bottomView}]];
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectZero];
    self.cancelButton.backgroundColor = ELColor02;
    self.cancelTitle = self.cancelTitle?:[[NSAttributedString alloc]initWithString:@"取消"
                                                                        attributes:@{NSFontAttributeName:ELTextSize03,
                                                                                     NSForegroundColorAttributeName:ELColor01}];
    
    
    
    [self.cancelButton setAttributedTitle:self.cancelTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
    
    
    
    if (self.confirmTitle) {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectZero];
        self.confirmButton.backgroundColor = ELColor01;
        [self.confirmButton setAttributedTitle:self.confirmTitle forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bottomView addSubview:self.confirmButton];
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[CONFIRM]-0-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"CONFIRM":self.confirmButton}]];
        
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CONFIRM]-0-[CANCEL(==CONFIRM)]-0-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"CANCEL":self.cancelButton,
                                                                                          @"CONFIRM":self.confirmButton}]];
    }
    else{
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if (self.subView) {
        self.containerViewHeight += self.subViewHeight;
        self.subView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:self.subView];
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[MIDDLEVIEW]-0-|" options:0 metrics:nil views:@{@"MIDDLEVIEW":self.subView}]];
        
        if (!self.title) {
            [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[MIDDLEVIEW]-10-[BOTTOMVIEW(bottom_height)]-0-|"
                                                                                       options:0
                                                                                       metrics:@{@"bottom_height":@(BOTTOMVIEW_HEIGHT)}
                                                                                         views:@{@"BOTTOMVIEW":self.bottomView,
                                                                                                 @"MIDDLEVIEW":self.subView}]];
        }
        else{
            [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TOPVIEW(top_height)]-0-[MIDDLEVIEW]-10-[BOTTOMVIEW(bottom_height)]-0-|"
                                                                                       options:0
                                                                                       metrics:@{@"top_height":@(TOPVIEW_HEIGHT),
                                                                                                 @"bottom_height":@(BOTTOMVIEW_HEIGHT)}
                                                                                         views:@{@"TOPVIEW":self.topView,
                                                                                                 @"BOTTOMVIEW":self.bottomView,
                                                                                                 @"MIDDLEVIEW":self.subView}]];
        }
    }
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CONTAINER]-0-|" options:0 metrics:nil views:@{@"CONTAINER":self.containerView}]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:self.containerViewHeight]];
    
    
    
}

-(void)confirmBtnClick:(UIButton *)btn{
    if (self.confirmHandler) {
        self.confirmHandler();
        [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
            
        }];
    }
}

-(void)cancelBtnClick:(UIButton *)btn{
    if (self.cancelHandler) {
        self.cancelHandler();
        
        [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
            
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
        
    }];
}



-(void)el_dismissViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type animationComplete:(ELTransitionCompeleteBlock)complete{
    [UIView animateWithDuration:0.28
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.containerView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
                     } completion:^(BOOL finished) {
                         [super el_dismissViewControllerWithAnimationType:type animationComplete:complete];
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
