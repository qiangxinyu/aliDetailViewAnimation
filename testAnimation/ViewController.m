//
//  ViewController.m
//  testAnimation
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#define RADIUS 100.0
#define kNumber 5
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray * viewArray;
@property (nonatomic,strong)NSMutableArray * centerArray;
@property (nonatomic,assign)int  index;
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    
    for (int i = 0 ; i < kNumber; i ++) {
        CGFloat tmpy =  centery + RADIUS*cos(2.0*M_PI *i/kNumber);
        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/kNumber);
        
        UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.image = [UIImage imageNamed:@"orange_hexagon"];
        view.center = CGPointMake(kScreenWidth , kScreenHeight);
        [self.viewArray addObject:view];
        
        [self.centerArray addObject:[NSString stringWithFormat:@"%f,%f",tmpx,tmpy]];
        
        
        view.userInteractionEnabled = YES;
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aavv)];
        [view addGestureRecognizer:tap];
    }
    
    
    
    
    
}

- (void)aavv
{
    NSLog(@"111");
}
- (IBAction)clickooooo:(id)sender {
    [self clear:nil];
    
    for (UIView * view in self.viewArray) {
        [self.view addSubview:view];
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(addView1) userInfo:nil repeats:YES];
    [self addView1];
}

- (IBAction)aaaa:(id)sender {
    [self clear:nil];
    for (UIView * view in self.viewArray) {
        [self.view addSubview:view];
    }

    [self addView];
}

- (IBAction)bbbbb:(id)sender {
    [self clear:nil];
    for (UIView * view in self.viewArray) {
        [self.view addSubview:view];
    }

    [self addViewWithIndex:0];
}


- (void)addView1
{
    NSString * center = self.centerArray[self.index];
    CGFloat tmpy =  [[center componentsSeparatedByString:@","].lastObject floatValue];
    CGFloat tmpx =	[[center componentsSeparatedByString:@","].firstObject floatValue];
    
    UIView * view = self.viewArray[self.index];
    [UIView animateWithDuration:.3 animations:^{
        view.center = CGPointMake(tmpx, tmpy);
    }];
    
    self.index ++;
    if (self.index == self.centerArray.count) {
        [self.timer invalidate];
        self.index = 0;
    }
}

- (void)addView
{
    
    for (int i = 0 ; i < self.viewArray.count; i ++) {
        NSString * center = self.centerArray[i];
        CGFloat tmpy =  [[center componentsSeparatedByString:@","].lastObject floatValue];
        CGFloat tmpx =	[[center componentsSeparatedByString:@","].firstObject floatValue];
        
        UIView * view = self.viewArray[i];
        [UIView animateWithDuration:.8 animations:^{
            view.center = CGPointMake(tmpx, tmpy);
            
        }];
        
    }
}


- (void)addViewWithIndex:(int)index
{
    NSString * center = self.centerArray[index];
    CGFloat tmpy =  [[center componentsSeparatedByString:@","].lastObject floatValue];
    CGFloat tmpx =	[[center componentsSeparatedByString:@","].firstObject floatValue];
    
    UIView * view = self.viewArray[index];
    [UIView animateWithDuration:.15 animations:^{
        view.center = CGPointMake(tmpx, tmpy);
    } completion:^(BOOL finished) {
        if (index + 1 >= self.centerArray.count) {
            return ;
        }
        [self addViewWithIndex:index+1];
        
    }];
}

- (IBAction)clear:(id)sender {
    
    for (UIView * view in self.viewArray) {
        view.center = CGPointMake(kScreenWidth, kScreenHeight);
        [view removeFromSuperview];
    }
    
    
}

- (NSMutableArray *)viewArray
{
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (NSMutableArray *)centerArray
{
    if (!_centerArray) {
        _centerArray = [NSMutableArray array];
    }
    return _centerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
