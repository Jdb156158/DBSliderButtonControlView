//
//  ViewController.m
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(25, 5, self.view.frame.size.width-50, 15) Titles:[NSArray arrayWithObjects:@"人民轿车", @"高级轿车", @"豪华轿车", @"优步专车", nil]];
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor orangeColor]];//设置滑块上方字体颜色
    [_filter setSelectedIndex:0];//设置当前选中
    [_Button_UIView addSubview:_filter];
    
    _showLabel.text = @"当前选中：人民轿车";
}

#pragma mark -- 点击底部按钮响应事件
-(void)filterValueChanged:(SEFilterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            _showLabel.text = @"当前选中：人民轿车";
            break;
        case 1:
            _showLabel.text = @"当前选中：高级轿车";
            break;
        case 2:
            _showLabel.text = @"当前选中：豪华轿车";
            break;
        case 3:
            _showLabel.text = @"当前选中：优步专车";
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
