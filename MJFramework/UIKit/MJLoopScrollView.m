//
//  MJLoopScrollView.m
//  ZXToolProjects
//
//  Created by 郭明健 on 2018/6/25.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import "MJLoopScrollView.h"

#define CLASSNAME @"MJLoopScrollView_V1.0"

#define PAGECONTROL_HEIGHT 15       // pageControl默认高度
#define PAGECONTROL_LEADING 15      // pageControl左侧距离
#define PAGECONTROL_BOTTOM 0        // pageControl底部距离
#define TIMEINTERVAL 3.0            // 每张图片默认展示时间

@interface MJLoopScrollView ()<UIScrollViewDelegate> {
    NSTimer *_myTimer;
    UIImageView *_preImageView;
    UIImageView *_lastImageView;
    NSMutableArray *_imageViewArray;
    //
    void(^_action)(UIImageView *imageView, int index);
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *myPageControl;

// 保持图片数组
@property (strong, nonatomic) NSArray *saveImagesArray;

@end

@implementation MJLoopScrollView {
    /**
     *  pageControl 位置,下左,下中,下右; 默认是下中
     */
    MJPageControlAlignment currentPageControlAlignment;
}

#pragma mark - system Funtions

- (void)layoutSubviews {
    [self updatePageControlImage:_myPageControl.currentPage];
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _timeInterval = TIMEINTERVAL;
        _autoScroll = YES;
        _showPageControl = YES;
        _myPageControl.hidden = !_showPageControl;
        currentPageControlAlignment = MJPageControlBottomCenter;
        _pageControlSpacBottom = PAGECONTROL_BOTTOM;
        _defaultColor = [UIColor whiteColor];
        _selectedColor = [UIColor blackColor];
        //
        _defaultImageSize = CGSizeMake(7, 7);
        _defaultImage = nil;
        _selectedImageSize = CGSizeMake(7, 7);
        _selectedImage = nil;
    }
    return self;
}

#pragma mark - set Funtions

/**
 *  需要显示的页数
 */
- (void)setPageCount:(int)pageCount {
    _pageCount = pageCount;
}

/**
 *  每张图片展示停留的时间
 */
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval < 1.0f) {
        timeInterval = TIMEINTERVAL;
    }
    _timeInterval = timeInterval;
    
    [self invalidateTimer];
    [self beginTimer];
}

/**
 *  是否自动滚动
 */
- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (autoScroll == NO) {
        [self pauseTimer];
    } else {
        [self startTimer];
    }
}

/**
 *  pageControl 默认颜色
 */
- (void)setDefaultColor:(UIColor *)defaultColor {
    _defaultColor = defaultColor;
}

/**
 *  pageControl 选中颜色
 */
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
}

/**
 pageControl 是否显示
 */
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    _myPageControl.hidden = !showPageControl;
}

/**
 pageControl 距离底部的距离，默认5px
 */
- (void)setPageControlSpacBottom:(CGFloat)pageControlSpacBottom {
    _pageControlSpacBottom = pageControlSpacBottom;
    //
    CGRect rect = [self getPageControlFrame:currentPageControlAlignment];
    _myPageControl.frame = rect;
}

#pragma mark - 自定义点图片

- (void)updatePageControlImage:(NSInteger)currentPage {
    if (_defaultImage == nil && _selectedImage == nil) {
        return;
    }
    for (int i = 0; i < [_myPageControl.subviews count]; i ++) {
        UIView *dot = [_myPageControl.subviews objectAtIndex:i];
        CGSize newDotSize = _defaultImageSize;
        if (i == currentPage) {
            newDotSize = _selectedImageSize;
        }
        for (UIView *subView in dot.subviews) {
            [subView removeFromSuperview];
        }
        UIImageView * imageView = [[UIImageView alloc] init];
        if (i == currentPage) {
            if (_selectedImage) {
                imageView.image = _selectedImage;
                dot.backgroundColor = [UIColor clearColor];
            } else {
                imageView.image = nil;
                dot.backgroundColor = _selectedColor;
            }
        } else {
            if (_defaultImage) {
                imageView.image = _defaultImage;
                dot.backgroundColor = [UIColor clearColor];
                // 圆角
                imageView.layer.cornerRadius = _defaultImageSize.width / 2;
                imageView.layer.masksToBounds = YES;
                imageView.clipsToBounds = YES;
            } else {
                imageView.image = nil;
                dot.backgroundColor = _defaultColor;
            }
        }
        //
        CGSize oldDotSize = dot.frame.size;
        CGPoint center = CGPointMake(oldDotSize.width / 2.0, oldDotSize.height / 2.0);
        CGFloat x = center.x - newDotSize.width / 2;
        CGFloat y = center.y - newDotSize.height / 2;
        CGRect rect = CGRectMake(x, y, newDotSize.width, newDotSize.height);
        imageView.frame = rect;
        [dot addSubview:imageView];
    }
    
}

#pragma mark -

// 初始化UI
- (void)refreshUI {
    if(_pageCount == 0) {
        return;
    }
    
    // 先移除以前的视图
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    // 创建滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    // 添加最后一张图片放到首部
    _preImageView = [[UIImageView alloc] initWithImage:nil];
    _preImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _preImageView.contentMode = UIViewContentModeScaleAspectFill;
    _preImageView.clipsToBounds = YES;
    _preImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *preTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    _preImageView.tag = -1;
    [_preImageView addGestureRecognizer:preTap];
    [_scrollView addSubview:_preImageView];
    
    // 图片数组
    _imageViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _pageCount; i ++) {
        // loop this bit
        UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];
        imageView.frame = CGRectMake((self.frame.size.width * i) + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [_scrollView addSubview:imageView];
        [_imageViewArray addObject:imageView];
        
        // 添加手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        imageView.tag = i;
        [imageView addGestureRecognizer:tap];
    }
    
    // 添加第一张图片放到末尾
    _lastImageView = [[UIImageView alloc] initWithImage:nil];
    _lastImageView.frame = CGRectMake(self.frame.size.width * (_pageCount + 1), 0, self.frame.size.width, self.frame.size.height);
    _lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    _lastImageView.clipsToBounds = YES;
    _lastImageView.tag = _pageCount;
    _lastImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *lastTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    [_preImageView addGestureRecognizer:lastTap];
    [_scrollView addSubview:_lastImageView];
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * (_pageCount + 2), self.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    // 创建pageControl
    if (_showPageControl) {
        CGRect rect = [self getPageControlFrame:currentPageControlAlignment];
        _myPageControl = [[UIPageControl alloc] initWithFrame:rect];
        _myPageControl.pageIndicatorTintColor = _defaultColor;
        _myPageControl.currentPageIndicatorTintColor = _selectedColor;
        _myPageControl.numberOfPages = _pageCount;
        _myPageControl.userInteractionEnabled = NO;
        if (_autoScroll == NO) {
            // 不自动滑动时可以点击pageControl
            _myPageControl.userInteractionEnabled = YES;
            [_myPageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
        }
        [self addSubview:_myPageControl];
    }
    
    // 添加自动滚动
    if (_autoScroll == YES) {
        [self beginTimer];
    }
}

// 点击图片
- (void)dealTap:(UITapGestureRecognizer *)tap{
    if (_action) {
        NSInteger Tag = tap.view.tag;
        if (Tag == -1) {
            Tag = 0;
        }
        _action((UIImageView *)tap.view,(int)Tag);
    }
}

#pragma mark - ===private Funtions===

/**
 销毁定时器
 */
- (void)invalidateTimer {
    [_myTimer invalidate];
    _myTimer = nil;
}

/**
 暂停定时器
 */
- (void)pauseTimer {
    [_myTimer setFireDate:[NSDate distantFuture]];
}

/**
 开启定时器
 */
- (void)startTimer {
    [_myTimer setFireDate:[NSDate distantPast]];
}

/**
 *  pageControl 位置,位置有:居左,居中,居右; 默认是居中.
 */
- (void)setPageControlAlignment:(MJPageControlAlignment)alignment {
    currentPageControlAlignment = alignment;//保存
    CGRect rect = [self getPageControlFrame:alignment];
    _myPageControl.frame = rect;
}

/**
 图片开始轮播，图片点击事件
 */
- (void)startAutoRunningImages:(NSArray *)images
                   clickAction:(void(^)(UIImageView *imageView, int index))action {
    self.saveImagesArray = images;
    NSMutableArray *imageM = [NSMutableArray arrayWithArray:images];
    if (imageM && imageM.count > 0) {
        // 去除不合格项
        for (int i = 0; i < images.count; i ++) {
            id subItem = images[i];
            if ([subItem isKindOfClass:[UIImage class]] || [subItem isKindOfClass:[NSString class]]) {
                // 符合要求
            } else {
                NSLog(@"%@:%s,images图片数组索引[%d]内容设置错误!",CLASSNAME, __FUNCTION__, i);
                [imageM removeObjectAtIndex:i];
                return;
            }
        }
        
        //
        _pageCount = imageM.count;
        [self refreshUI];
        _action = action;
        
        // 加载图片
        for (int i = 0; i < imageM.count; i ++) {
            id subImage = imageM[i];
            if ([subImage isKindOfClass:[UIImage class]]) {
                [self setImage:subImage atIndex:i];
            } else if ([subImage isKindOfClass:[NSString class]]) {
                [self setImageWithUrlString:subImage atIndex:i];
            }
        }
    }
}

#pragma mark -

// 设置某个位置处的图片
- (void)setImage:(UIImage *)image atIndex:(int)index {
    if(index < 0 || index > _pageCount - 1) {
        return;
    }
    if(index == _pageCount - 1) {
        _preImageView.image = image;
    }
    if(index == 0) {
        _lastImageView.image = image;
    }
    
    UIImageView *view = _imageViewArray[index];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.clipsToBounds = YES;
    view.image = image;
}

// 设置某个位置处的图片
- (void)setImageWithUrlString:(NSString *)urlString atIndex:(int)index {
    if(index < 0 || index > _pageCount - 1) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 下载图片
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        // 下载完成设置图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(index == self->_pageCount - 1) {
                self->_preImageView.image = [UIImage imageWithData:data];
            }
            if(index == 0) {
                self->_lastImageView.image = [UIImage imageWithData:data];
            }
            
            UIImageView *view = self->_imageViewArray[index];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = YES;
            view.image = [UIImage imageWithData:data];
            
        });
        
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / (_pageCount + 2)) / scrollView.frame.size.width) + 1;
    if (currentPage == 0) {
        // go last but 1 page
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * _pageCount, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }
    else if (currentPage == (_pageCount + 1)) {
        // 如果是最后+1,也就是要开始循环的第一个
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }
    
    [self updateCurrentPage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_autoScroll == YES) {
        [self updateCurrentPage];
    }
}

// 手动滑动开始关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

// 手动滑动结束开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self beginTimer];
}

#pragma mark -

- (void)updateCurrentPage {
    if(_scrollView.frame.size.width == 0) {
        return;
    }
    int index = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    _myPageControl.currentPage = index - 1;
    // 改变点图片
    [self updatePageControlImage:_myPageControl.currentPage];
}

- (void)pageControlClick:(UIPageControl *)sender {
    CGSize viewSize = self.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

/**
 初始化定时器
 */
- (void)beginTimer {
    if (!_myTimer)
    {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(updateScrollViewContentOffset) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateScrollViewContentOffset {
    CGPoint pt = _scrollView.contentOffset;
    NSInteger count = _pageCount;
    if(pt.x == _scrollView.frame.size.width * count) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];//保证末尾到开头的顺畅
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    } else {
        [_scrollView scrollRectToVisible:CGRectMake(pt.x + _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    }
}

#pragma mark -

- (CGRect)getPageControlFrame:(MJPageControlAlignment)alignment {
    CGFloat pageControlY = self.frame.size.height - PAGECONTROL_HEIGHT - _pageControlSpacBottom;
    CGFloat pageControlWidth = _pageCount * 14 + PAGECONTROL_LEADING * 2;
    CGFloat pageControlX;
    
    switch (alignment) {
        case MJPageControlBottomLeft:
            pageControlX = 0;
            break;
        case MJPageControlBottomCenter:
            pageControlX = (self.frame.size.width - pageControlWidth) / 2.0;
            break;
        case MJPageControlBottomRight:
            pageControlX = self.frame.size.width - pageControlWidth;
            break;
            
        default:
            break;
    }
    
    CGRect rect = CGRectMake(pageControlX, pageControlY, pageControlWidth, PAGECONTROL_HEIGHT);
    return rect;
}

#pragma mark -

- (void)orientChangeUpdateFrame:(CGRect)frame {
    if (_saveImagesArray && _saveImagesArray.count > 0 && _action) {
        self.frame = frame;
        [self startAutoRunningImages:self.saveImagesArray clickAction:_action];
    }
}

- (void)dealloc {
    [_myTimer invalidate];
    _myTimer = nil;
}

@end
