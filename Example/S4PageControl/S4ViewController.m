//
//  S4ViewController.m
//  S4PageControl
//
//  Created by Dmitry Abramov on 12/10/2014.
//  Copyright (c) 2014 Dmitry Abramov<dmitry.i.abramov@gmail.com>. All rights reserved.
//

#import "S4ViewController.h"
#import <S4PageControl/S4PageControl.h>

@interface S4ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) S4PageControl* pageControl;
@property (strong, nonatomic) NSArray* colorMapping;
@property (strong, nonatomic) NSArray* sizeMapping;
@property (strong, nonatomic) NSArray* spaceMapping;
@property (strong, nonatomic) NSArray* shapeMapping;
@end

@implementation S4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorMapping = @[[UIColor redColor],
                          [UIColor blueColor],
                          [UIColor greenColor]];
    self.sizeMapping = @[[NSValue valueWithCGSize: CGSizeMake(10,10)],
                         [NSValue valueWithCGSize: CGSizeMake(20,20)],
                         [NSValue valueWithCGSize: CGSizeMake(30,30)]];
    self.spaceMapping = @[[NSNumber numberWithFloat:10],
                          [NSNumber numberWithFloat:20],
                          [NSNumber numberWithFloat:30]];
    self.shapeMapping = @[
                            ^(BOOL current, NSUInteger index, CGContextRef context, CGSize indicatorSize, UIColor* indicatorColor) {
                              UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, indicatorSize.width, indicatorSize.height)];
                              [indicatorColor setFill];
                              [ovalPath fill];
                            },
                            ^(BOOL current, NSUInteger index, CGContextRef context, CGSize indicatorSize, UIColor* indicatorColor) {
                                UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, indicatorSize.width, indicatorSize.height)];
                                [indicatorColor setFill];
                                [rectPath fill];
                            },
                            ^(BOOL current, NSUInteger index, CGContextRef context, CGSize indicatorSize, UIColor* indicatorColor) {
                                UIBezierPath *trianglePath = [UIBezierPath bezierPath];
                                [trianglePath moveToPoint:CGPointMake(indicatorSize.width/2, 0.0)];
                                [trianglePath addLineToPoint:CGPointMake(indicatorSize.width, indicatorSize.height)];
                                [trianglePath addLineToPoint:CGPointMake(0, indicatorSize.height)];
                                [trianglePath closePath];
                                [indicatorColor setFill];
                                [trianglePath fill];
                            }
                        ];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.colorMapping.count, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;

    CGRect frame = self.scrollView.frame;
    for (int i = 0; i < self.colorMapping.count; i++, frame.origin.x += frame.size.width) {
        UIView* view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = self.colorMapping[i];
        [self.scrollView addSubview:view];
    }
    
    self.pageControl = [S4PageControl new];
    self.pageControl.center = CGPointMake(self.bottomView.bounds.size.width/2, self.bottomView.bounds.size.height/2);
    self.pageControl.numberOfPages = self.colorMapping.count;
    [self updatePage:0];
    [self.bottomView addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    [self updatePage: floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1];
}

- (void) updatePage: (NSInteger) page
{
    self.pageControl.currentPage = page;
    self.pageControl.currentPageIndicatorTintColor = self.colorMapping[page];
    self.pageControl.pageIndicatorTintColor = [self.colorMapping[page] colorWithAlphaComponent:0.3];
    self.pageControl.indicatorSize = [self.sizeMapping[page] CGSizeValue];
    self.pageControl.indicatorSpace = [self.spaceMapping[page] floatValue];
    self.pageControl.indicatorBlock = self.shapeMapping[page];
}

@end
