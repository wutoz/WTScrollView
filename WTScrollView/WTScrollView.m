//
//  WTScrollView.m
//  testscrollview
//
//  Created by Yorke on 14/12/28.
//  Copyright (c) 2014 Yorke. All rights reserved.
//

#import "WTScrollView.h"

#define CHECK_IS_ZERO( x, max ) (x) == 0 ? (max) : (x)

@implementation UIView (WTAddtion)

- (CGFloat)X{
    return self.frame.origin.x;
}

- (CGFloat)Y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

@end

@interface WTScrollView ()<UIScrollViewDelegate>{
    UIImageView *_leftImageView;
    UIImageView *_middleImageView;
    UIImageView *_rightImageView;
    NSInteger indexRight;
    NSInteger maxCount;
}

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation WTScrollView

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName, ...{
    if(self = [super initWithFrame:frame]){
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:_scrollView];
        
        _scrollView.bounces = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
      
        _imageArray = [NSMutableArray array];
        NSMutableArray *imageNameArray = [NSMutableArray array];
        indexRight = 0;
        
        va_list arguments;
        
        id eachObject;
        if(imageName){
            [imageNameArray addObject:imageName];
            va_start(arguments, imageName);
            while ((eachObject = va_arg(arguments, id))) {
                [imageNameArray addObject:eachObject];
            }
            va_end(arguments);
        }
        
        for(NSString *obj in imageNameArray){
//            NSString *path = [[NSBundle mainBundle]pathForResource:obj ofType:@"png"];
//            UIImage *image = [UIImage imageWithContentsOfFile:path];
            UIImage *image = [UIImage imageNamed:obj];
            [_imageArray addObject:image];
        }
        
        maxCount = _imageArray.count;
        
        NSAssert(maxCount > 1, @"Two or more image elements wo needed!");
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [_imageArray lastObject];
        
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.image = _imageArray[0];
        
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = _imageArray[1];
        
        [_scrollView addSubview:_leftImageView];[_scrollView addSubview:_middleImageView];[_scrollView addSubview:_rightImageView];
        
        _style = WTScrollViewStyleHorizontal;
        
        [self layImageViewInScrollView:_scrollView Style:_style];
    }
    
    return self;
}

-(void)setStyle:(WTScrollViewStyle)style{
    _style = style;
    [self layImageViewInScrollView:_scrollView Style:_style];
}

-(void)layImageViewInScrollView:(UIScrollView *)scrollView Style:(WTScrollViewStyle)style{
    _leftImageView.frame = [self scrollViewCurrentRect:scrollView Location: WTScrollViewLocationLeft Style:style];
    
    _middleImageView.frame = [self scrollViewCurrentRect:scrollView Location: WTScrollViewLocationMiddle Style:style];
    
    _rightImageView.frame = [self scrollViewCurrentRect:scrollView Location: WTScrollViewLocationRight Style:style];
    
    if(style == WTScrollViewStyleHorizontal)
        [scrollView setContentSize:CGSizeMake(scrollView.width * maxCount, scrollView.height)];
    else
        [scrollView setContentSize:CGSizeMake(scrollView.width, scrollView.height * maxCount)];
    
    [scrollView scrollRectToVisible:[self scrollViewCurrentRect:scrollView Location: WTScrollViewLocationMiddle Style:style] animated: NO];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = 0;
    if(self.style == WTScrollViewStyleHorizontal)
        currentPage = floor(scrollView.contentOffset.x / scrollView.width);
    else
        currentPage = floor(scrollView.contentOffset.y / scrollView.height);
    
    if(currentPage == 1)//no move
        return;
    
    NSInteger index = 0;
    
    if(currentPage == 0)
        indexRight --;
    else
        indexRight ++;
    
    index = CHECK_IS_ZERO((maxCount + indexRight % maxCount) % maxCount, maxCount);
    _leftImageView.image = self.imageArray[(index - 1)];
    
    index = CHECK_IS_ZERO((maxCount + indexRight % maxCount + 1) % maxCount, maxCount);
    _middleImageView.image = self.imageArray[(index - 1)];
    
    index = CHECK_IS_ZERO((maxCount + indexRight % maxCount + 2) % maxCount, maxCount);
    _rightImageView.image = self.imageArray[(index - 1)];
    
    [scrollView scrollRectToVisible:[self scrollViewCurrentRect:scrollView Location: WTScrollViewLocationMiddle Style:self.style] animated:NO];
}

-(CGRect)scrollViewCurrentRect:(UIScrollView *)scrollView Location:(WTScrollViewLocation)location Style:(WTScrollViewStyle)style{
    if(style == WTScrollViewStyleHorizontal)
    {
        if(location == WTScrollViewLocationLeft)
        {
            return CGRectMake(scrollView.X + scrollView.width * 0, scrollView.Y, scrollView.width, scrollView.height);
        }
        else if (location == WTScrollViewLocationMiddle)
        {
            return CGRectMake(scrollView.X + scrollView.width * 1, scrollView.Y, scrollView.width, scrollView.height);
        }
        else if (location == WTScrollViewLocationRight)
        {
            return CGRectMake(scrollView.X + scrollView.width * 2, scrollView.Y, scrollView.width, scrollView.height);
        }
    }
    else if(style == WTScrollViewStyleVertical)
    {
        if(location == WTScrollViewLocationLeft)
        {
            return CGRectMake(scrollView.X, scrollView.Y + scrollView.height * 0, scrollView.width, scrollView.height);
        }
        else if (location == WTScrollViewLocationMiddle)
        {
            return CGRectMake(scrollView.X, scrollView.Y + scrollView.height * 1, scrollView.width, scrollView.height);
        }
        else if (location == WTScrollViewLocationRight)
        {
            return CGRectMake(scrollView.X, scrollView.Y + scrollView.height * 2, scrollView.width, scrollView.height);
        }
    }
    
    return CGRectZero;
}

@end


