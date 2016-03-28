//
//  ViewController.h
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEFilterControl.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (weak, nonatomic) IBOutlet UIView *Button_UIView;
@property(nonatomic,strong) SEFilterControl *filter;
@end

