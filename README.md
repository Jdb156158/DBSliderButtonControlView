# DBSliderButtonControlView

优步下边进行滑动或点击选择车型，感觉挺爽的。
代码参照了http://code.cocoachina.com/view/124056这位兄弟的，在他上边改动了部分实现了优步下滑菜单的效果。 当前工程为arc版本，后边会在出一个mrc的。


用法： _filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(25, 5, self.view.frame.size.width-50, 15) Titles:[NSArray arrayWithObjects:@"人民轿车", @"高级轿车", @"豪华轿车", @"优步专车", nil]];

[_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];

[_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色

[_filter setTopTitlesColor:[UIColor orangeColor]];//设置滑块上方字体颜色 

[_filter setSelectedIndex:0];//初始设置当前选中
