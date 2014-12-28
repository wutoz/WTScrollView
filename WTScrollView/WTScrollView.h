//
//  WTScrollView.h
//  testscrollview
//
//  Created by Yorke on 14/12/28.
//  Copyright (c) 2014 Yorke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WTScrollViewLocation) {
    WTScrollViewLocationLeft = 1,
    WTScrollViewLocationMiddle,
    WTScrollViewLocationRight
};

typedef NS_ENUM(NSInteger, WTScrollViewStyle) {
    WTScrollViewStyleHorizontal = 1,
    WTScrollViewStyleVertical
};

@interface UIView (WTAddtion)

- (CGFloat)X;

- (CGFloat)Y;

- (CGFloat)width;

- (CGFloat)height;

@end

@interface WTScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, assign) WTScrollViewStyle style;

@end


