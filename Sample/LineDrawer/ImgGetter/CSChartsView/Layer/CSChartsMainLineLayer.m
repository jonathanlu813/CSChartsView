//
//  CSChartsMainLineLayer.m
//  ImgGetter
//
//  Created by 沈凯 on 14-3-4.
//  Copyright (c) 2014年 CruiseShen. All rights reserved.
//

#import "CSChartsMainLineLayer.h"
#import "NSString+BoundingRect.h"
#import "CSChartsPoint.h"

@interface CSChartsMainLineLayer (){
	CGSize yAxisCharacterSize;
    CGSize xAxisCharacterSize;
    CGFloat bottomSpacing;
    CGFloat leftSpacing;
    CGFloat topSpacing;
    NSInteger horizontalLineAmount;
	CGFloat horizontalSpacing;
	NSUInteger verticalLineAmount;
    CGFloat portSpacing;
    CGFloat verticalSpacing;
	CGFloat chartsContentHeight;
	CGFloat yAxisMax;
	CGFloat yAxisMin;
}

@property (nonatomic, weak) CSChartsMaiLine *mainLine;

@end

@implementation CSChartsMainLineLayer

-(void)drawInContext:(CGContextRef)ctx{
	[self paramsPreparation];
    /*******************/
    /* draw main lines */
    /*******************/
	[self drawMainLines:ctx];
	
    /***************/
    /* draw points */
    /***************/
	[self drawPoints:ctx];
	
	/********************/
    /* draw detail rect */
    /********************/
	[self drawDetailRect:ctx];
}

- (CSChartsMaiLine*)mainLine{
    return [self.charts.lines objectAtIndex:self.index];
}

-(void)drawDetailRect:(CGContextRef)ctx{
	NSArray *pointArray = self.mainLine.pointArray;
    for (int i = 0; i < pointArray.count; i++) {
		CSChartsPoint *tempPoint = [pointArray objectAtIndex:i];
		if (tempPoint.shouldShowDetail) {
			CGFloat detailRectWidth = self.mainLine.detailRect.size.width;
			CGFloat detailRectHeight = self.mainLine.detailRect.size.height;
			CGPoint detailRectPoint = [self calculateDetalRectPosition:self.mainLine -> points[i]];
			CGFloat detailRectX = detailRectPoint.x;
			CGFloat detailRectY = detailRectPoint.y;
			//draw detail rect
			//set line color
			CGContextSetFillColorWithColor(ctx, self.mainLine.detailRect.color.CGColor);
			//set fill rect
			CGContextBeginPath(ctx);
			//set 4 points for the rect
			//1
			CGContextMoveToPoint(ctx, detailRectX, detailRectY);
			//2
			CGContextAddLineToPoint(ctx, detailRectX + detailRectWidth, detailRectY);
			//3
			CGContextAddLineToPoint(ctx, detailRectX + detailRectWidth, detailRectY + detailRectHeight);
			//4
			CGContextAddLineToPoint(ctx, detailRectX, detailRectY + detailRectHeight);
			
			CGContextClosePath(ctx);
			//commit draw
			CGContextFillPath(ctx);
			
			//draw detail rect triangle
			//set line color
			CGContextSetFillColorWithColor(ctx, self.mainLine.detailRect.color.CGColor);
			//set fill triangle
			CGContextBeginPath(ctx);
			//set 3 points for the triangle
			CGFloat point1Y = detailRectY - self.mainLine -> points[i].y < 0 ? self.mainLine -> points[i].y - CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING : self.mainLine -> points[i].y + CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING;
			CGFloat point2Y = detailRectY - self.mainLine -> points[i].y < 0 ? detailRectY + detailRectHeight - 1 : detailRectY + 1;
			//1
			CGContextMoveToPoint(ctx, self.mainLine -> points[i].x, point1Y);
			//2
			CGContextAddLineToPoint(ctx, self.mainLine -> points[i].x - 6, point2Y);
			//3
			CGContextAddLineToPoint(ctx, self.mainLine -> points[i].x + 6, point2Y);
			
			CGContextClosePath(ctx);
			//commit draw
			CGContextFillPath(ctx);
			
			//draw detail text
			//set Anti alias
			CGContextSetShouldAntialias(ctx, YES);
			CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
			UIGraphicsPushContext(ctx);
			
			NSString *drawString = [NSString stringWithFormat:self.mainLine.detailRect.textFormat,tempPoint.y];
			CGSize drawStringSize = [drawString boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.mainLine.detailRect.font withLineSpacing:3];
			NSString *unitString = self.mainLine.detailRect.unitString;
			CGSize unitStringSize = [unitString boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.mainLine.detailRect.unitFont withLineSpacing:3];
			
			//draw characters
			[drawString drawAtPoint:CGPointMake(detailRectX + (detailRectWidth - drawStringSize.width - unitStringSize.width) / 2, detailRectY + (detailRectHeight - drawStringSize.height) / 2) withFont:self.mainLine.detailRect.font];
			//draw unit
			
			[unitString drawAtPoint:CGPointMake(detailRectX + (detailRectWidth - drawStringSize.width - unitStringSize.width) / 2 + drawStringSize.width, detailRectY + (detailRectHeight - unitStringSize.height) / 2 ) withFont:self.mainLine.detailRect.unitFont];
			UIGraphicsPopContext();
		}
	}
}

-(void)drawPoints:(CGContextRef)ctx{
	NSArray *pointArray = self.mainLine.pointArray;
    for (int i = 0; i < pointArray.count; i++) {
        //set line width
		
        CGContextSetLineWidth(ctx, 1.8);
        //set line color
        CGContextSetStrokeColorWithColor(ctx, self.mainLine.color.CGColor);
        //draw points
        CSChartsPoint *tempPoint = [pointArray objectAtIndex:i];
        
        if (tempPoint.pointStyle == CSChartsPointStyleSolid) {
			//draw solid point
            CGContextSetFillColorWithColor(ctx, self.mainLine.color.CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 3, 0, 360, 0);
			CGContextStrokePath(ctx);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 3, 0, 360, 0);
			CGContextFillPath(ctx);
        }else if(tempPoint.pointStyle == CSChartsPointStyleHollow){
			//draw hollow point
			CGContextSetFillColorWithColor(ctx, self.mainLine.color.CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 3, 0, 360, 0);
			CGContextStrokePath(ctx);
			CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 3, 0, 360, 0);
			CGContextFillPath(ctx);
        }else if(tempPoint.pointStyle == CSChartsPointStyleSolidWhite){
			//draw SolidWhite point
			CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 6, 0, 360, 0);
			CGContextFillPath(ctx);
			CGContextSetFillColorWithColor(ctx, tempPoint.color.CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 4, 0, 360, 0);
			CGContextFillPath(ctx);
		}else if(tempPoint.pointStyle == CSChartsPointStyleSolidWhiteBorder){
			//draw SolidWhiteBorder point
			CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 6, 0, 360, 0);
			CGContextFillPath(ctx);
			CGContextSetFillColorWithColor(ctx, tempPoint.color.CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 3, 0, 360, 0);
			CGContextFillPath(ctx);
			CGContextSetStrokeColorWithColor(ctx, tempPoint.color.CGColor);
			CGContextAddArc(ctx, self.mainLine -> points[i].x, self.mainLine -> points[i].y, 6, 0, 360, 0);
			CGContextStrokePath(ctx);
		}
    }
}

#pragma mark - private
-(CGPoint)calculateDetalRectPosition:(CGPoint) point{
	CGFloat detailRectWidth = self.mainLine.detailRect.size.width;
	CGFloat detailRectHeight = self.mainLine.detailRect.size.height;
	CGFloat detailRectX = point.x - detailRectWidth / 2;
	if (detailRectX < 10) {
		detailRectX = 10;
	}else if(detailRectX + detailRectWidth > self.charts.frame.size.width - 10){
		detailRectX = self.charts.frame.size.width - 2 - detailRectWidth;
	}
	CGFloat detailRectY = point.y - detailRectHeight / 3 - CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING - detailRectHeight;
	if (detailRectY < 0) {
		detailRectY = point.y + CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING + 10;
	}
	return CGPointMake(detailRectX, detailRectY);
}

#pragma mark -- draw method
-(void)drawMainLines:(CGContextRef)ctx{
    NSArray *pointArray = self.mainLine.pointArray;
    CGFloat allLeftSpacing = portSpacing + leftSpacing;
    
    for (int i = 0; i < pointArray.count; i++ ) {
        CSChartsPoint *curPoint = [pointArray objectAtIndex:i];
        CGFloat percentOfHeight = (yAxisMax - curPoint.y) / (yAxisMax - yAxisMin);
		self.mainLine -> points[i].y = topSpacing + chartsContentHeight * percentOfHeight;
		self.mainLine -> points[i].x = allLeftSpacing + curPoint.x * verticalSpacing;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.miterLimit = -5;
    CGPoint previousLineChartPoint;
    CGFloat previousSlope = 0.0f;
    CGFloat firstXPosition = 0.0f;
    CGFloat lastXPosition = 0.0f;
    
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint lineChartPoint = self.mainLine -> points[i];
        if (i ==0) {
            [path moveToPoint:CGPointMake(lineChartPoint.x, lineChartPoint.y)];
            firstXPosition = lineChartPoint.x;
        }
        else{
            CGPoint nextLineChartPoint;
            if (i != ([pointArray count] - 1))
            {
                nextLineChartPoint = self.mainLine -> points[i+1];
            }
            
            CGFloat nextSlope = (i != ([pointArray count] - 1)) ? ((nextLineChartPoint.y - lineChartPoint.y)) / ((nextLineChartPoint.x - lineChartPoint.x)) : previousSlope;
            CGFloat currentSlope = ((lineChartPoint.y - previousLineChartPoint.y)) / (lineChartPoint.x-previousLineChartPoint.x);
            
            BOOL deltaFromNextSlope = ((currentSlope >= (nextSlope + 0.01)) || (currentSlope <= (nextSlope - 0.01)));
            BOOL deltaFromPreviousSlope = ((currentSlope >= (previousSlope + 0.01)) || (currentSlope <= (previousSlope - 0.01)));
            BOOL deltaFromPreviousY = (lineChartPoint.y >= previousLineChartPoint.y + 1) || (lineChartPoint.y <= previousLineChartPoint.y - 1);
            
            if (self.mainLine.shouldSmooth && deltaFromNextSlope && deltaFromPreviousSlope && deltaFromPreviousY)
            {
                CGFloat deltaX = lineChartPoint.x - previousLineChartPoint.x;
                CGFloat controlPointX = previousLineChartPoint.x + (deltaX / 2);
                
                CGPoint controlPoint1 = CGPointMake(controlPointX, previousLineChartPoint.y);
                CGPoint controlPoint2 = CGPointMake(controlPointX, lineChartPoint.y);
                
                [path addCurveToPoint:CGPointMake(lineChartPoint.x, lineChartPoint.y) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
            }
            else
            {
                [path addLineToPoint:CGPointMake(lineChartPoint.x, lineChartPoint.y)];
            }
            lastXPosition = lineChartPoint.x;
            previousSlope = currentSlope;
        }
        previousLineChartPoint = lineChartPoint;
    }
    
    //set line width
    CGContextSetLineWidth(ctx, self.mainLine.lineWidth);
	//set line color
    CGContextSetStrokeColorWithColor(ctx, self.mainLine.color.CGColor);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);
}

#pragma mark -- param init method
-(void)paramsPreparation{
	yAxisCharacterSize = [[NSString stringWithFormat:@"%0.f",self.charts.yAxis.max] boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.charts.yAxis.font withLineSpacing:3];
	xAxisCharacterSize = [[self.charts.xAxis.signArray objectAtIndex:0] boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.charts.xAxis.signFont withLineSpacing:3];
    bottomSpacing = xAxisCharacterSize.height + CSCHARTS_SPACING * 2;
    if (self.charts.yAxis.isNeeded) {
		leftSpacing = yAxisCharacterSize.width + CSCHARTS_SPACING * 2;
	}else{
		leftSpacing = 0;
	}
    topSpacing = yAxisCharacterSize.height / 2 + CSCHARTS_TOP_EXTRA_SPACING;
    horizontalLineAmount = (self.charts.yAxis.signAmount - 1) * 5;
	horizontalSpacing = (self.charts.frame.size.height - topSpacing - bottomSpacing) / (horizontalLineAmount - 1);
	verticalLineAmount = self.charts.xAxis.signArray.count;
    portSpacing = (self.charts.frame.size.width - leftSpacing) * PORT_SPACING_RATE;
    
    verticalSpacing = (self.charts.frame.size.width - portSpacing * 2 - leftSpacing) / (verticalLineAmount - 1);
	yAxisMax = self.charts.yAxis.max;
	yAxisMin = self.charts.yAxis.min;
	chartsContentHeight = self.charts.frame.size.height - bottomSpacing - topSpacing;
}

@end














