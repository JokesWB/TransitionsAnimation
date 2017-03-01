//
//  ViewController.m
//  aksjhlg
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 LaiCunBa. All rights reserved.
//

#import "ViewController.h"

#define IMAGE_COUNT 2

@interface ViewController ()<UIScrollViewDelegate>
{
    UIImageView *myImageVeiw1;
    UIImageView *myImageVeiw2;
    UIScrollView *myscrollView;
    int _currentIndex;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    myscrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    myscrollView.minimumZoomScale = 1;
    myscrollView.maximumZoomScale = 3;
    myscrollView.delegate = self;
    [self.view addSubview:myscrollView];
    
    myImageVeiw1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    myImageVeiw1.image = [UIImage imageNamed:@"0"];
    myImageVeiw1.userInteractionEnabled = YES;
    [myscrollView addSubview:myImageVeiw1];
    
    UISwipeGestureRecognizer *swipeGestureleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureLeftAction:)];
    swipeGestureleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [myImageVeiw1 addGestureRecognizer:swipeGestureleft];
    
    UISwipeGestureRecognizer *swipeGestureright = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRightAction:)];
    swipeGestureright.direction = UISwipeGestureRecognizerDirectionRight;
    [myImageVeiw1 addGestureRecognizer:swipeGestureright];
    
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return myImageVeiw1;
}


- (void)swipeGestureLeftAction:(UISwipeGestureRecognizer *)swipe
{
    [self transitionAnimation:YES];
}

- (void)swipeGestureRightAction:(UISwipeGestureRecognizer *)swipe
{
    [self transitionAnimation:NO];
}



#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push', 'cube' and `reveal'. Defaults to `fade'. */
    transition.type=@"cube";
    
    //设置子类型
    if (isNext) {
        transition.subtype=kCATransitionFromRight;
    }else{
        transition.subtype=kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration=1.0f;
    
    //3.设置转场后的新视图添加转场动画
    myImageVeiw1.image=[self getImage:isNext];
    [myImageVeiw1.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%i.png",_currentIndex];
    return [UIImage imageNamed:imageName];
}



@end
