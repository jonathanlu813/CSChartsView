//
//  RootViewController.m
//  ImgGetter
//
//  Created by 沈凯 on 14-3-3.
//  Copyright (c) 2014年 CruiseShen. All rights reserved.
//

#import "RootViewController.h"
#import "CSChartsColorRegion.h"

@interface RootViewController ()<CSChartsViewDelegate>{
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chartsView = [[CSChartsView alloc] initWithFrame:CGRectMake(0, 135, 320, 433)];
	[self.view addSubview:self.chartsView];
    self.chartsView.yAxisMax = 100;
    self.chartsView.yAxisMin = 0;
    self.chartsView.yAxisSignAmount = 5;
	self.chartsView.yAxisSignFormat = @"%0.0f";
	self.chartsView.detailRectUnitString = @"times/h";
	self.chartsView.detailRectSize = CGSizeMake(80, 25);
    self.chartsView.xAxisSignArray = [NSArray arrayWithObjects:@"Feb 9",@"10",@"11",@"12",@"13",@"14",@"Feb 15      ", nil];
    self.chartsView.numberOfLines = 1;
    self.chartsView.tappable = NO;

	self.chartsView.delegate = self;
	//p0
    CSChartsPoint *point0 = CSChartsPointMake(-1, 40);
    point0.pointStyle = CSChartsPointStyleNone;
	point0.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
	//p1
    CSChartsPoint *point1 = CSChartsPointMake(0.5, 50);
    point1.pointStyle = CSChartsPointStyleNone;
	point1.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
    //p2
	CSChartsPoint *point2 = CSChartsPointMake(1, 22);
    point2.pointStyle = CSChartsPointStyleNone;
	point2.color = [UIColor colorWithRed:154 / 255.0 green:0 / 255.0 blue:28 / 255.0 alpha:1];
	//p3
	CSChartsPoint *point3 = CSChartsPointMake(2, 30);
    point3.pointStyle = CSChartsPointStyleNone;
	point3.color = [UIColor colorWithRed:154 / 255.0 green:0 / 255.0 blue:28 / 255.0 alpha:1];
	//p4
	CSChartsPoint *point4 = CSChartsPointMake(3, 0);
    point4.pointStyle = CSChartsPointStyleNone;
	point4.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
	//p5
	CSChartsPoint *point5 = CSChartsPointMake(4, 65);
    point5.pointStyle = CSChartsPointStyleNone;
	point5.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
	//p6
	CSChartsPoint *point6 = CSChartsPointMake(6, 100);
    point6.pointStyle = CSChartsPointStyleNone;
	point6.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
	//point6.shouldShowDetail = YES;
	
    [self.chartsView setLinePoints:[NSArray arrayWithObjects:point0,point1,point2,point3,point4,point5, point6, nil] atIndex:0];
    [self.chartsView setLineColor:[UIColor redColor] atIndex:0];
    [self.chartsView setLineWidth:2 atIndex:0];
    [self.chartsView setLineShouldSmooth:YES atIndex:0];
    [self.chartsView refreshMainLineLayer];
    
	self.chartsView.detailRectTextFormat = @"%0.f ";
	self.chartsView.isRegionSeparated = NO;
	self.chartsView.colorRegionArray = [NSArray arrayWithObjects:CSChartsColorRegionMake([UIColor colorWithRed:211 / 255.0 green:234 / 255.0 blue:210 / 255.0 alpha:1], 40),CSChartsColorRegionMake([UIColor colorWithRed:244 / 255.0 green:250 / 255.0 blue:246 / 255.0 alpha:1], 40),nil];
}

-(void)leftSwipeGesturePerformed{
	NSLog(@"leftSwipeGesturePerformed");
}

-(void)rightSwipeGesturePerformed{
	NSLog(@"rightSwipeGesturePerformed");
}

-(void)pinchGesturePerformed:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
	if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		NSLog(@"pinchGesturePerformed");
	}
}
@end
