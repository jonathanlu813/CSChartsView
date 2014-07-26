//
//  CSChartsView.h
//  ImgGetter
//
//  Created by 沈凯 on 14-3-4.
//  Copyright (c) 2014年 CruiseShen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChartsPoint.h"

@protocol CSChartsViewDelegate <NSObject>

@optional
-(void)pointSelected:(NSIndexPath*)indexPath;
-(void)leftSwipeGesturePerformed;
-(void)rightSwipeGesturePerformed;
-(void)pinchGesturePerformed:(UIPinchGestureRecognizer *) pinchGestureRecognizer;
@end

@interface CSChartsView : UIView
@property(nonatomic,strong) UIColor *mainLineColor UI_APPEARANCE_SELECTOR;

//delegate
@property(nonatomic,weak) id<CSChartsViewDelegate> delegate;

//detail rect
@property(nonatomic) CGSize detailRectSize UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIFont *detailRectFont UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIColor *detailRectColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) NSString *detailRectTextFormat UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) NSString *detailRectUnitString UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIFont *detailRectUnitFont UI_APPEARANCE_SELECTOR;

//background
@property(nonatomic,strong) UIColor *backgroundViceLineColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIColor *backgroundMainLineColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) NSArray *colorRegionArray UI_APPEARANCE_SELECTOR;
@property(nonatomic) BOOL isRegionSeparated UI_APPEARANCE_SELECTOR;
@property(nonatomic) BOOL shouldDrawHorizontalViceLines UI_APPEARANCE_SELECTOR;

//y Axis
@property(nonatomic,strong) UIFont *yAxisFont UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIColor *yAxisColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) NSString *yAxisSignFormat UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) NSString *yAxisUnitString UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIFont *yAxisUnitFont UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIColor *yAxisUnitColor UI_APPEARANCE_SELECTOR;
@property(nonatomic) BOOL needYAxis UI_APPEARANCE_SELECTOR;

//x Axis
@property(nonatomic,strong) UIColor *xAxisColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIColor *xAxisSignColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong) UIFont *xAxisSignFont UI_APPEARANCE_SELECTOR;

//necessary property
@property(nonatomic,strong) NSArray *xAxisSignArray;
@property(nonatomic) NSInteger yAxisSignAmount;
@property(nonatomic) CGFloat yAxisMax;
@property(nonatomic) CGFloat yAxisMin;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic,strong) NSArray *lineLayers;
@property(nonatomic) BOOL tappable;

//set line property
- (void)setLinePoints:(NSArray*)points atIndex:(NSInteger)index;
- (void)setLineColor:(UIColor*)color atIndex:(NSInteger)index;
- (void)setLineWidth:(CGFloat)lineWidth atIndex:(NSInteger)index;
- (void)setDetailRectSize:(CGSize)detailRectSize atIndex:(NSInteger)index;
- (void)setDetailFont:(UIFont*)detailRectFont atIndex:(NSInteger)index;
- (void)setDetailColor:(UIColor*)detailRectColor atIndex:(NSInteger)index;
- (void)setDetailTextFormat:(NSString*)detailRectTextFormat atIndex:(NSInteger)index;
- (void)setDetailUnitString:(NSString*)detailRectUnitString atIndex:(NSInteger)index;
- (void)setDetailUnitFont:(UIFont*)detailRectUnitFont atIndex:(NSInteger)index;

//set visibility for lines
- (void)setVisible:(BOOL)isVisible atIndex:(NSInteger)index;

//refresh view
-(void) refreshCSChartsView;
-(void) refreshBackgroundLayer;
-(void) refreshMainLineLayer;
-(void) refreshXAxisLayer;

@end








