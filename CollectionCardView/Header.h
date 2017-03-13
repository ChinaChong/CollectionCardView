//
//  Header.h
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define WindowZoomScale_6     (SCREENWIDTH/375.f)
#define WindowZoomScaleH_6    (SCREENHEIGHT/667.f)
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCALE 0.9
#define ITEM_WIDTH  320*WindowZoomScale_6
#define ITEM_HEIGHT (SCREENHEIGHT - 64 - 20 * 2)*WindowZoomScale_6

#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000

#endif /* Header_h */
