//
//  SEFilterControl.m
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import "SEFilterControl.h"

#define LEFT_OFFSET 20
#define RIGHT_OFFSET 20
#define TITLE_SELECTED_DISTANCE 9
#define TITLE_FADE_ALPHA 0.5f
//#define TITLE_FONT [UIFont fontWithName:@"Optima" size:10]//源码
#define TITLE_FONT [UIFont systemFontOfSize:10]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor blackColor]

@interface SEFilterControl (){
    CGPoint diffPoint;
    NSArray *titlesArr;
    float oneSlotSize;
}

@end

@implementation SEFilterControl
@synthesize SelectedIndex, progressColor,TopTitlesColor;

-(CGPoint)getCenterPointForIndex:(int) i{
    return CGPointMake((i/(float)(titlesArr.count-1)) * (self.frame.size.width-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET, i==0?self.frame.size.height-55-TITLE_SELECTED_DISTANCE:self.frame.size.height-55);
}

-(CGPoint)fixFinalPoint:(CGPoint)pnt{
    if (pnt.x < LEFT_OFFSET-(_handler.frame.size.width/2.f)) {
        pnt.x = LEFT_OFFSET-(_handler.frame.size.width/2.f);
    }else if (pnt.x+(_handler.frame.size.width/2.f) > self.frame.size.width-RIGHT_OFFSET){
        pnt.x = self.frame.size.width-RIGHT_OFFSET- (_handler.frame.size.width/2.f);
        
    }
    return pnt;
}

-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        
        [self setProgressColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
        [self setTopTitlesColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        
        _handler = [UIButton buttonWithType:UIButtonTypeCustom];
        [_handler setFrame:CGRectMake(LEFT_OFFSET, 8, 45, 45)];
        [_handler setAdjustsImageWhenHighlighted:NO];
        [_handler setSelected:YES];
        [_handler setCenter:CGPointMake(_handler.center.x-(_handler.frame.size.width/2.f), self.frame.size.height-29.5f)];
        [_handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [_handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [_handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        
        UIImage *image1 = [UIImage imageNamed:@"sliderWifiOff.png"];
        UIImage *image2 = [UIImage imageNamed:@"sliderWifiOn.png"];
        
        CGFloat top = 0; // 顶端盖高度
        
        CGFloat bottom = 0 ; // 底端盖高度
        
        CGFloat left = 0; // 左端盖宽度
        
        CGFloat right = 0; // 右端盖宽度
        
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [_handler setBackgroundImage:image1 forState:UIControlStateNormal];
        [_handler setBackgroundImage:image2 forState:UIControlStateSelected];
        
        [self addSubview:_handler];
        
        int i;
        NSString *title;
        UILabel *lbl;
        
        oneSlotSize = 1.f*(self.frame.size.width-LEFT_OFFSET-RIGHT_OFFSET-1)/(titlesArr.count-1);
        for (i = 0; i < titlesArr.count; i++) {
            title = [titlesArr objectAtIndex:i];
            lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, oneSlotSize, 10)];
            [lbl setText:title];
            [lbl setFont:TITLE_FONT];
            [lbl setTextColor:TITLE_COLOR];
            [lbl setLineBreakMode:NSLineBreakByTruncatingMiddle];
            [lbl setAdjustsFontSizeToFitWidth:YES];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setShadowOffset:CGSizeMake(0, 1)];
            [lbl setTag:i+50];
            
            if (i) {
                [lbl setAlpha:TITLE_FADE_ALPHA];
            }
            
            [lbl setCenter:[self getCenterPointForIndex:i]];
            [self addSubview:lbl];
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0
                                              blue:0 alpha:.9f].CGColor;
    
    
    //Fill Main Path
    
    //原代码CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    
    //源码为(context, CGRectMake(LEFT_OFFSET, rect.size.height-35, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 10))
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height-32.5, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 5));
    
    CGContextSaveGState(context);
    
    //Draw Black Top Shadow
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1.f), 2.f, shadowColor);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                               blue:0 alpha:.2f].CGColor);
    CGContextSetLineWidth(context, .4f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height-32.5);
    CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height-32.5);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    
    //Draw White Bottom Shadow
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                               blue:0 alpha:.2f].CGColor);
    CGContextSetLineWidth(context, .4f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height-27.5);
    CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height-27.5);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    
    CGPoint centerPoint;
    int i;
    for (i = 0; i < titlesArr.count; i++) {
        centerPoint = [self getCenterPointForIndex:i];
        
        //Draw Selection Circles 小圆圈
        
        //源代码CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        //CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        
        CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x-10, rect.size.height-38.0f, 15, 15));
        
        //Draw top Gradient
        
        //        CGFloat colors[12] =   {0, 0, 0, 1,
        //                                0, 0, 0, 0,
        //                                0, 0, 0, 0};
        //        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        //        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 3);
        //
        //        CGContextSaveGState(context);
        //        CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
        //        CGContextClip(context);
        //        CGContextDrawLinearGradient (context, gradient, CGPointMake(0, 0), CGPointMake(0,rect.size.height), 0);
        //        CGContextRestoreGState(context);
        
        //Draw White Bottom Shadow 小圆圈的上半部分圆弧
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                                   blue:0 alpha:.2f].CGColor);
        CGContextSetLineWidth(context, .4f);
        CGContextAddArc(context,centerPoint.x-2.0,rect.size.height-30.5f,7.0f,18*M_PI/180,165*M_PI/180,0);
        CGContextDrawPath(context,kCGPathStroke);
        
        //Draw Black Top Shadow  小圆圈的下半部分圆弧
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                                   blue:0 alpha:.2f].CGColor);
        
        CGContextAddArc(context,centerPoint.x-2.0,rect.size.height-30.5f,7.0f,(i==titlesArr.count-1?18:-14)*M_PI/180,(i==0?-198:-170)*M_PI/180,1);
        CGContextSetLineWidth(context, .4f);
        CGContextDrawPath(context,kCGPathStroke);
        
    }
}


- (void) TouchDown: (UIButton *) btn withEvent: (UIEvent *) ev{
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    diffPoint = CGPointMake(currPoint.x - btn.frame.origin.x, currPoint.y - btn.frame.origin.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}


-(void) setTitlesFont:(UIFont *)font{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [lbl setFont:font];
    }
}

-(void) animateTitlesToIndex:(int) index{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (i == index) {
            //选中时label颜色
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height-55-TITLE_SELECTED_DISTANCE)];
            [lbl setTextColor: self.TopTitlesColor];
            [lbl setAlpha:1];
        }else{
            //未选中时label颜色
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height-55)];
            [lbl setTextColor:TITLE_COLOR];
            [lbl setAlpha:1];
        }
        [UIView commitAnimations];
    }
}

-(void) animateHandlerToIndex:(int) index{
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x-(_handler.frame.size.width/2.f), _handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    
    [UIView beginAnimations:nil context:nil];
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    [UIView commitAnimations];
}

-(void) setSelectedIndex:(int)index{
    SelectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(int)getSelectedTitleInPoint:(CGPoint)pnt{
    return round((pnt.x-LEFT_OFFSET)/oneSlotSize);
}

-(void) ItemSelected: (UITapGestureRecognizer *) tap {
    SelectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:SelectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) TouchUp: (UIButton*) btn{
    btn.selected = YES;
    SelectedIndex = [self getSelectedTitleInPoint:btn.center];
    [self animateHandlerToIndex:SelectedIndex];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) TouchMove: (UIButton *) btn withEvent: (UIEvent *) ev {
    btn.selected = NO;
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    
    CGPoint toPoint = CGPointMake(currPoint.x-diffPoint.x, _handler.frame.origin.y);
    
    toPoint = [self fixFinalPoint:toPoint];
    
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    
    int selected = [self getSelectedTitleInPoint:btn.center];
    
    [self animateTitlesToIndex:selected];
    
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}
@end
