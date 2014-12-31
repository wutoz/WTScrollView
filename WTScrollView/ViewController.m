//
//  ViewController.m
//  WTScrollView
//
//  Created by Yorke on 14/12/28.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "ViewController.h"
#import "WTScrollView.h"

#define UIScreenWidth            [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight           [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>{
    NSInteger hisPage;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *storeImageViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initWTView];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)initWTView{
    WTScrollView *testView = [[WTScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) ImageName:@"pic1",@"pic2",@"pic3",@"pic4",@"pic5",@"pic6",@"pic7", nil];
//        testView.style = WTScrollViewStyleVertical;
    [self.view addSubview:testView];
}

-(void)initView{
    [self.view addSubview:self.scrollView];
    for(UIImageView *obj in self.storeImageViews){
        [self.scrollView addSubview:obj];
    }
    
    [self.scrollView setContentSize:CGSizeMake(UIScreenWidth * self.storeImageViews.count, UIScreenHeight)];
    
    [self.scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * 1, 0, UIScreenWidth, UIScreenHeight) animated:NO];
    
    hisPage = 1;
    
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        _scrollView.bounces = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}


-(NSArray *)storeImageViews{
    if(!_storeImageViews){
        NSMutableArray *tempArray = [NSMutableArray array];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        imageView.image = [UIImage imageNamed:@"pic7"];
        [tempArray addObject:imageView];
        
        for(int i = 0 ;i < 7;i ++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth * (i + 1), 0, UIScreenWidth, UIScreenHeight)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i + 1]];
            [tempArray addObject:imageView];
        }
        _storeImageViews = [NSArray arrayWithArray:tempArray];
    }
    return _storeImageViews;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int currentPage = floor(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if(hisPage == currentPage){
        return;
    }else{
        hisPage = currentPage;
        if(currentPage == 0){
            [self.scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * (self.storeImageViews.count - 1), 0, UIScreenWidth, UIScreenHeight) animated: NO];
        }
        else if(currentPage == self.storeImageViews.count - 1){
            [self.scrollView scrollRectToVisible:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) animated: NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
