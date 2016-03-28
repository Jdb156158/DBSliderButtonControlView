//
//  SEFilterControl.h
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SEFilterKnob.h"
@interface SEFilterControl : UIControl
-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
-(void) setSelectedIndex:(int)index;
-(void) setTitlesFont:(UIFont *)font;

@property(nonatomic, strong) UIButton *handler;
@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic, strong) UIColor *TopTitlesColor;
@property(nonatomic, readonly) int SelectedIndex;
@end
