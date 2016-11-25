//
//  ConstantsColors.h
//  
//
//  Created by wangjie.zhao on 13-7-24.
//  Copyright (c) 2013年 yizhe.peng. All rights reserved.
//


// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ELColor01 UIColorFromRGB(0xe52524) //主红
#define ELColor02 UIColorFromRGB(0xffffff) //白
#define ELColor03 UIColorFromRGB(0x656565) //灰
#define ELColor04 UIColorFromRGB(0xfee5e6) //红
#define ELColor05 UIColorFromRGB(0xc8c7cc) //分割线
#define ELColor06 UIColorFromRGB(0xfee158) //黄
#define ELColor07 UIColorFromRGB(0x1fca26) //绿
#define ELColor08 UIColorFromRGB(0xfd8961) //橙



#define ELTextSize01 [UIFont systemFontOfSize:20]
#define ELTextSize02 [UIFont systemFontOfSize:18]
#define ELTextSize03 [UIFont systemFontOfSize:16]
#define ELTextSize04 [UIFont systemFontOfSize:14]
#define ELTextSize05 [UIFont systemFontOfSize:12]
#define ELTextSize06 [UIFont systemFontOfSize:10]



#define ELTextSize36pt [UIFont systemFontOfSize:26]
#define ELTextSize34pt [UIFont systemFontOfSize:24]
#define ELTextSize32pt [UIFont systemFontOfSize:22]
#define ELTextSize30pt [UIFont systemFontOfSize:20]
#define ELTextSize28pt [UIFont systemFontOfSize:18]
#define ELTextSize26pt [UIFont systemFontOfSize:16]
#define ELTextSize24pt [UIFont systemFontOfSize:14]
#define ELTextSize22pt [UIFont systemFontOfSize:12]
#define ELTextSize20pt [UIFont systemFontOfSize:10]
