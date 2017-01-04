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
#define ELColor09 UIColorFromRGB(0x333333) //灰



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




//移植的部分

#define COLOR_152a3d UIColorFromRGB(0X152a3d)
#define COLOR_fdb50c UIColorFromRGB(0Xfdb50c)
#define COLOR_ee5354 UIColorFromRGB(0Xee5354)
#define COLOR_f0f0f0 UIColorFromRGB(0Xf0f0f0)
#define COLOR_333333 UIColorFromRGB(0X333333)
#define COLOR_fc9541 UIColorFromRGB(0Xfc9541)
#define COLOR_bfbfbf UIColorFromRGB(0Xbfbfbf)
#define COLOR_8dda4c UIColorFromRGB(0X8dda4c)
#define COLOR_797979 UIColorFromRGB(0X797979)
#define COLOR_666666 UIColorFromRGB(0X666666)
#define COLOR_e9eaea UIColorFromRGB(0Xe9eaea)
#define COLOR_f83232 UIColorFromRGB(0Xf83232)
#define COLOR_f7f7f7 UIColorFromRGB(0Xf7f7f7)
#define COLOR_cacaca UIColorFromRGB(0xcacaca)
#define COLOR_686868 UIColorFromRGB(0x686868)
#define COLOR_cccccc UIColorFromRGB(0xcccccc)
#define COLOR_4a90e2 UIColorFromRGB(0x4a90e2)
#define COLOR_60ab2d UIColorFromRGB(0x60ab2d)
#define COLOR_999999 UIColorFromRGB(0x999999)
#define COLOR_ff0000 UIColorFromRGB(0xff0000)
#define COLOR_fff1d2 UIColorFromRGB(0xfff1d2)
#define COLOR_48449b UIColorFromRGB(0x48449b)
#define COLOR_78a85d UIColorFromRGB(0x78a85d)
#define COLOR_c98061 UIColorFromRGB(0xc98061)
#define COLOR_5e9bc1 UIColorFromRGB(0x5e9bc1)
#define COLOR_e4e4e4 UIColorFromRGB(0xe4e4e4)
#define COLOR_ffb73c UIColorFromRGB(0xffb73c)
#define COLOR_a4da85 UIColorFromRGB(0xa4da85)
#define COLOR_2775d9 UIColorFromRGB(0X2775d9)
#define COLOR_2875d9 UIColorFromRGB(0X2875d9)
#define COLOR_e6e6e6 UIColorFromRGB(0Xe6e6e6)
#define COLOR_eeeeee UIColorFromRGB(0Xeeeeee)
#define COLOR_ca2d2d UIColorFromRGB(0Xca2d2d)
#define COLOR_7bbfff UIColorFromRGB(0X7bbfff)
#define COLOR_fedfdd UIColorFromRGB(0Xfedfdd)
#define COLOR_f84646 UIColorFromRGB(0Xf84646)
#define COLOR_d6d6d6 UIColorFromRGB(0Xd6d6d6)
#define COLOR_83cc63 UIColorFromRGB(0X83cc63)
