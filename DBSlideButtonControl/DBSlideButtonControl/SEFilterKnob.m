//
//  SEFilterKnob.m
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import "SEFilterKnob.h"

@implementation SEFilterKnob

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize handlerColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setHandlerColor:[UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:0]];
    }
    return self;
}

-(void) setHandlerColor:(UIColor *)hc{
    handlerColor = nil;
    
    [self setNeedsDisplay];
    
    UIImage *image1 = [UIImage imageNamed:@"sliderWifiOff.png"];
    UIImage *image2 = [UIImage imageNamed:@"sliderWifiOn.png"];
    
    CGFloat top = 0; // 顶端盖高度
    
    CGFloat bottom = 0 ; // 底端盖高度
    
    CGFloat left = 0; // 左端盖宽度
    
    CGFloat right = 0; // 右端盖宽度
    
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:image1 forState:UIControlStateNormal];
    [self setBackgroundImage:image2 forState:UIControlStateSelected];
}
@end
