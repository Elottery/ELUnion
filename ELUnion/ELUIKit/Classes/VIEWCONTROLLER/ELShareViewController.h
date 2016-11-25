//
//  ELShareViewController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/11.
//
//

#import "ELBaseViewController.h"
#import "ELShareService.h"

@interface ELShareViewController : ELBaseViewController
@property (nonatomic,strong)NSString * shareTitle;
@property (nonatomic,strong)NSString * shareURL;
@property (nonatomic,strong)UIImage  * titleImage;
@property (nonatomic,strong)UIImage  * contentImage;
@property (nonatomic,strong)NSString * titleImageURL;

@property (nonatomic,copy)ELShareServiceComplete  complete;

@end
