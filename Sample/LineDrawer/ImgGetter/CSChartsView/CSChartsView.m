//
//  CSChartsView.m
//  ImgGetter
//
//  Created by 沈凯 on 14-3-4.
//  Copyright (c) 2014年 CruiseShen. All rights reserved.
//

#import "CSChartsView.h"
#import "CSCharts.h"
#import "CSChartsBackgroundLayer.h"
#import "CSChartsMainLineLayer.h"
#import "CSChartsXAxisLayer.h"

@interface CSChartsView (){
    CSCharts *charts;
    CSChartsBackgroundLayer *backgroundLayer;
    CSChartsXAxisLayer *xAxisLayer;
	UITapGestureRecognizer *tapGestureRecognizer;
}

@end

@implementation CSChartsView


#pragma mark - life cycle methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        charts = [[CSCharts alloc] init];
        charts.frame = frame;
        
        backgroundLayer = [CSChartsBackgroundLayer layer];
        backgroundLayer.charts = charts;
        backgroundLayer.frame = CGRectInset(self.layer.bounds,0,0);
		backgroundLayer.contentsScale = [[UIScreen mainScreen] scale];
        
        xAxisLayer = [CSChartsXAxisLayer layer];
        xAxisLayer.charts = charts;
        xAxisLayer.frame = CGRectInset(self.layer.bounds,0,0);
		xAxisLayer.contentsScale = [[UIScreen mainScreen] scale];
        
        [self.layer addSublayer:backgroundLayer];
        [self.layer addSublayer:xAxisLayer];
		
		//add gesture
		tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturePerformed)];
		[self addGestureRecognizer:tapGestureRecognizer];
		[self refreshCSChartsView];
    }
    return self;
}

#pragma mark - refresh methods
-(void) refreshCSChartsView{
    [self refreshBackgroundLayer];
    [self refreshMainLineLayer];
    [self refreshXAxisLayer];
}

-(void) refreshBackgroundLayer{
    [backgroundLayer setNeedsDisplay];
}

-(void) refreshMainLineLayer{
    for (CSChartsMainLineLayer *layer in self.lineLayers) {
        [layer setNeedsDisplay];
    }
}

-(void) refreshXAxisLayer{
    [xAxisLayer setNeedsDisplay];
}

#pragma mark - action method
-(void)tapGesturePerformed{
	CGPoint tapPoint = [tapGestureRecognizer locationInView:self];
	NSIndexPath *indexPath = [self pointsIndexTapped:tapPoint];
	if (index) {
		if ([self.delegate respondsToSelector:@selector(pointSelected:)]) {
			[self.delegate pointSelected:indexPath];
		}
	}
	[self setPointChosen:indexPath];
	[self refreshMainLineLayer];
}

#pragma mark - UIAppearance methods
-(BOOL)needYAxis{
	return charts.yAxis.isNeeded;
}

-(void)setNeedYAxis:(BOOL)needYAxis{
	charts.yAxis.isNeeded = needYAxis;
}

-(BOOL)shouldDrawHorizontalViceLines{
	return charts.background.shouldDrawHorizontalViceLines;
}

-(void)setShouldDrawHorizontalViceLines:(BOOL)shouldDrawHorizontalViceLines{
	charts.background.shouldDrawHorizontalViceLines = shouldDrawHorizontalViceLines;
}

-(NSString *)yAxisSignFormat{
	return charts.yAxis.signFormat;
}

-(void)setYAxisSignFormat:(NSString *)yAxisSignFormat{
	charts.yAxis.signFormat = yAxisSignFormat;
}

-(NSString *)yAxisUnitString{
	return charts.yAxis.axisUnit.unitString;
}

-(void)setYAxisUnitString:(NSString *)yAxisUnitString{
	charts.yAxis.axisUnit.unitString = yAxisUnitString;
}

-(UIColor *)yAxisUnitColor{
	return charts.yAxis.axisUnit.color;
}

-(void)setYAxisUnitColor:(UIColor *)yAxisUnitColor{
	charts.yAxis.axisUnit.color = yAxisUnitColor;
}

-(UIFont *)yAxisUnitFont{
	return charts.yAxis.axisUnit.font;
}

-(void)setYAxisUnitFont:(UIFont *)yAxisUnitFont{
	charts.yAxis.axisUnit.font = yAxisUnitFont;
}

-(BOOL)isRegionSeparated{
	return charts.background.isRegionSeparated;
}

-(void)setIsRegionSeparated:(BOOL)isRegionSeparated{
	charts.background.isRegionSeparated = isRegionSeparated;
}

-(NSArray *)colorRegionArray{
	return charts.background.colorRegionArray;
}

-(void)setColorRegionArray:(NSArray *)colorRegionArray{
	charts.background.colorRegionArray = colorRegionArray;
}

-(UIColor *)yAxisColor{
    return charts.yAxis.color;
}

-(void)setYAxisColor:(UIColor *)yAxisColor{
    charts.yAxis.color = yAxisColor;
}

-(UIFont *)yAxisFont{
    return charts.yAxis.font;
}

-(void)setYAxisFont:(UIFont *)yAxisFont{
    charts.yAxis.font = yAxisFont;
}

-(UIColor *)backgroundMainLineColor{
    return charts.background.mainLineColor;
}

-(void)setBackgroundMainLineColor:(UIColor *)backgroundMainLineColor{
    charts.background.mainLineColor = backgroundMainLineColor;
}

-(UIColor *)backgroundViceLineColor{
    return charts.background.viceLineColor;
}

-(void)setBackgroundViceLineColor:(UIColor *)backgroundViceLineColor{
    charts.background.viceLineColor = backgroundViceLineColor;
}

-(UIColor *)xAxisColor{
    return charts.xAxis.color;
}

-(void)setXAxisColor:(UIColor *)xAxisColor{
    charts.xAxis.color = xAxisColor;
}

-(UIColor *)xAxisSignColor{
    return charts.xAxis.signColor;
}

-(void)setXAxisSignColor:(UIColor *)xAxisSignColor{
    charts.xAxis.signColor = xAxisSignColor;
}

-(UIFont *)xAxisSignFont{
    return charts.xAxis.signFont;
}

-(void)setXAxisSignFont:(UIFont *)xAxisSignFont{
    charts.xAxis.signFont = xAxisSignFont;
}

#pragma mark - necessary property setter and getter
- (void)setNumberOfLines:(NSInteger)numberOfLines{
    NSMutableArray *lines = [NSMutableArray array];
    NSMutableArray *lineLayers = [NSMutableArray array];
    for (int i = 0; i < numberOfLines; i++) {
        CSChartsMaiLine *line = [[CSChartsMaiLine alloc] init];
        CSChartsMainLineLayer *mainLineLayer = [[CSChartsMainLineLayer alloc] init];
        mainLineLayer.charts = charts;
        mainLineLayer.index = i;
        mainLineLayer.frame = CGRectInset(self.layer.bounds,0,0);
		mainLineLayer.contentsScale = [[UIScreen mainScreen] scale];
        [lines addObject:line];
        [lineLayers addObject:mainLineLayer];
        [self.layer addSublayer:mainLineLayer];
    }
    self.lineLayers = lineLayers;
    charts.lines = lines;
}

-(CGFloat)yAxisMax{
    return charts.yAxis.max;
}

-(void)setYAxisMax:(CGFloat)yAxisMax{
    charts.yAxis.max = yAxisMax;
}

-(CGFloat)yAxisMin{
    return charts.yAxis.min;
}

-(void)setYAxisMin:(CGFloat)yAxisMin{
    charts.yAxis.min = yAxisMin;
}

-(NSInteger)yAxisSignAmount{
    return charts.yAxis.signAmount;
}

-(void)setYAxisSignAmount:(NSInteger)yAxisSignAmount{
    charts.yAxis.signAmount = yAxisSignAmount;
}

-(NSArray *)xAxisSignArray{
    return charts.xAxis.signArray;
}

-(void)setXAxisSignArray:(NSArray *)xAxisSignArray{
    charts.xAxis.signArray = xAxisSignArray;
}

-(void)setLinePoints:(NSArray *)points atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.pointArray = points;
}

- (void)setLineColor:(UIColor*)color atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.color = color;
}

- (void)setDetailRectSize:(CGSize)detailRectSize atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.size = detailRectSize;
}

- (void)setDetailFont:(UIFont*)detailRectFont atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.font = detailRectFont;
}

- (void)setDetailColor:(UIColor*)detailRectColor atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.color = detailRectColor;
}

- (void)setDetailTextFormat:(NSString*)detailRectTextFormat atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.textFormat = detailRectTextFormat;
}

- (void)setDetailUnitString:(NSString*)detailRectUnitString atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.unitString = detailRectUnitString;
}

- (void)setDetailUnitFont:(UIFont*)detailRectUnitFont atIndex:(NSInteger)index{
    CSChartsMaiLine *line = [charts.lines objectAtIndex:index];
    line.detailRect.unitFont = detailRectUnitFont;
}

- (void)setVisible:(BOOL)isVisible atIndex:(NSInteger)index{
    CSChartsMainLineLayer *lineLayer = [self.lineLayers objectAtIndex:index];
    lineLayer.opaque = !isVisible;
}

#pragma mark - delegate setter
-(void)setDelegate:(id<CSChartsViewDelegate>)delegate{
	_delegate = delegate;
	//add gesture
//	UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(leftSwipeGesturePerformed)];
//	leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//	UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(rightSwipeGesturePerformed)];
//	rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(pinchGesturePerformed:)];
//
//	[self addGestureRecognizer:leftSwipeGestureRecognizer];
//	[self addGestureRecognizer:rightSwipeGestureRecognizer];
	[self addGestureRecognizer:pinchGestureRecognizer];
}

#pragma mark - private
-(CGFloat)distanceBetweenPoint:(CGPoint) pointA and:(CGPoint) pointB{
	return sqrt((pointA.x - pointB.x) * (pointA.x - pointB.x) + (pointA.y - pointB.y) * (pointA.y - pointB.y));
}

-(NSIndexPath*)pointsIndexTapped:(CGPoint) point{
	for (int i = 0; i < charts.lines.count; i++) {
        CSChartsMaiLine *line = [charts.lines objectAtIndex:i];
        for (int j = 0; j< line.pointArray.count; j++) {
            if ([self distanceBetweenPoint:line->points[j] and:point] <= TAP_GESTURE_REG_RADIUS) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
	}
	return nil;
}

-(void)setPointChosen:(NSIndexPath*)indexPath{
	if (indexPath) {
		for (int i = 0; i < charts.lines.count; i++) {
            CSChartsMaiLine *line = [charts.lines objectAtIndex:i];
			for (int j = 0; j < line.pointArray.count; j++) {
                CSChartsPoint *point = [line.pointArray objectAtIndex:j];
                point.shouldShowDetail = NO;
                point.pointStyle = CSChartsPointStyleSolidWhite;
            }
		}
		CSChartsPoint *point = [((CSChartsMaiLine*)[charts.lines objectAtIndex:indexPath.section]).pointArray objectAtIndex:indexPath.row];
		point.shouldShowDetail = YES;
		point.pointStyle = CSChartsPointStyleSolidWhiteBorder;
	}
}
@end









