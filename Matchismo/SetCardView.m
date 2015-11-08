//
//  SetCardView.m
//  SuperSetCard
//
//  Created by Tatiana Kornilova on 2/17/13.
//  Copyright (c) 2013 Tatiana Kornilova. All rights reserved.
//  Most Code for shapes from  Marko Kuljanski
//  https://github.com/Kulja/Matchismo

#import "SetCardView.h"

@implementation SetCardView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath
                                  bezierPathWithRoundedRect:self.bounds
                                               cornerRadius:8.0];
    [roundedRect addClip]; //предотвращаем закрашивание углов карты
    
    if (self.faceUp) {
        [[UIColor lightGrayColor] setFill];
        UIRectFill(self.bounds);
    } else {
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
    }
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawCards];
}

#define SYMBOL_SCALE_X 2
#define SYMBOL_SCALE_Y 7
#define SIZE_OF_OVAL_CURVE 10
#define DIAMOND_ARM_SCALE 0.8
#define Y_OFFSET_FOR_NUMBER_2 2.7
#define Y_OFFSET_FOR_NUMBER_3 1.7
#define SHAPE_LINEWIDTH 4.0

- (void)drawCards
{
    if ([self.symbol isEqualToString:@"diamond"]) {
        [self drawDiamond];
    } else if ([self.symbol isEqualToString:@"squiggle"]) {
        [self drawSquiggle];
    } else if ([self.symbol isEqualToString:@"oval"]) {
        [self drawOval];
    }
}

- (void)drawSquiggle
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    CGPoint start = CGPointMake(middle.x + (middle.x / SYMBOL_SCALE_X),
                                middle.y - (middle.y / SYMBOL_SCALE_Y));
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:start];
    [path addQuadCurveToPoint:CGPointMake(start.x, middle.y +
                                          (middle.y / SYMBOL_SCALE_Y))
                 controlPoint:CGPointMake(start.x + SIZE_OF_OVAL_CURVE, middle.y)];
    
    [path addCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X),
                                      middle.y + (middle.y / SYMBOL_SCALE_Y))
            controlPoint1:CGPointMake(middle.x, middle.y +
                                      (middle.y / SYMBOL_SCALE_Y) +
                                      (middle.y / SYMBOL_SCALE_Y))
            controlPoint2:CGPointMake(middle.x, middle.y)];
    
    [path addQuadCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X), start.y)
                 controlPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X) -
                                          SIZE_OF_OVAL_CURVE, middle.y)];
    
    [path addCurveToPoint:CGPointMake(start.x, start.y)
            controlPoint1:CGPointMake(middle.x, middle.y -
                                      (middle.y / SYMBOL_SCALE_Y) -
                                      (middle.y / SYMBOL_SCALE_Y))
            controlPoint2:CGPointMake(middle.x, middle.y)];
  //----------------------------
      path.lineWidth =SHAPE_LINEWIDTH;
      [path closePath];
     [self drawAttributesFor:path];
}

- (void)drawOval
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGPoint start = CGPointMake(middle.x + (middle.x / SYMBOL_SCALE_X),
                                middle.y - (middle.y / SYMBOL_SCALE_Y));
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:start];
    [path addQuadCurveToPoint:CGPointMake(start.x, middle.y + (middle.y / SYMBOL_SCALE_Y))
                 controlPoint:CGPointMake(start.x + SIZE_OF_OVAL_CURVE, middle.y)];
    [path addLineToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X),
                                     middle.y + (middle.y / SYMBOL_SCALE_Y))];
    [path addQuadCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X), start.y)
                 controlPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X) -
                                          SIZE_OF_OVAL_CURVE, middle.y)];
    //----------------------------
    path.lineWidth =SHAPE_LINEWIDTH;
    [path closePath];
    [self drawAttributesFor:path];
}

- (void)drawDiamond
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGPoint start = CGPointMake(middle.x, middle.y - (middle.y / SYMBOL_SCALE_Y));
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:start];
    [path addLineToPoint:CGPointMake(middle.x + (middle.x / (SYMBOL_SCALE_X * DIAMOND_ARM_SCALE)),
                                     middle.y)];
    [path addLineToPoint:CGPointMake(middle.x, middle.y + (middle.y / SYMBOL_SCALE_Y))];
    [path addLineToPoint:CGPointMake(middle.x - (middle.x / (SYMBOL_SCALE_X * DIAMOND_ARM_SCALE)),
                                     middle.y)];
    //----------------------------
    path.lineWidth =SHAPE_LINEWIDTH;
    [path closePath];
    [self drawAttributesFor:path];
}

- (void)drawAttributesFor:(UIBezierPath *)path
{
    NSDictionary *colorPallette  = @{@"red":[UIColor redColor],
                                     @"green":[UIColor greenColor],
                                     @"purple":[UIColor purpleColor]};
    UIColor *cardColor    = colorPallette[self.color];
    
    [cardColor setStroke];
    if ([self.shading isEqualToString:@"solid"] ||
        [self.shading isEqualToString:@"striped"])
                                      [cardColor setFill];
    if (self.rank == 2) {
        CGFloat yOffset = self.bounds.size.height/2/Y_OFFSET_FOR_NUMBER_2;
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -yOffset);
        [path applyTransform:transform];
        [self drawPath:path];
        
        transform = CGAffineTransformMakeTranslation(0, yOffset * 2);
        [path applyTransform:transform];
        [self drawPath:path];
        
    } else if (self.rank == 3) {
        CGFloat yOffset = self.bounds.size.height/2/Y_OFFSET_FOR_NUMBER_3;
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -yOffset);
        [path applyTransform:transform];
        [self drawPath:path];
        
        transform = CGAffineTransformMakeTranslation(0, yOffset);
        [path applyTransform:transform];
        [self drawPath:path];
        
        transform = CGAffineTransformMakeTranslation(0, yOffset);
        [path applyTransform:transform];
        [self drawPath:path];
        
    } else {
        [self drawPath:path];
    }
}

-(void) drawPath:(UIBezierPath* )path
{
    [path stroke];
    if ([self.shading isEqualToString:@"striped"]){
        [path fill];
        [self stripes:path];}
    else {
        [path fill];}
}


static void drawStripes (void *info, CGContextRef context) {
    // предполагаем 3 x 1 cell
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, CGRectMake(0,0,2,1));
}

-(void)stripes: (UIBezierPath* )path
{
    // push context so add clip is only temporary
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // add clip for this copy of the context
    [path addClip];
    
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(nil);
    CGContextSetFillColorSpace (context, sp2);
    CGColorSpaceRelease (sp2);
    static const CGPatternCallbacks callback = {0, drawStripes, nil};
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGPatternRef pattern = CGPatternCreate(nil,
                                        CGRectMake(0,0,3,1),
                                        transform,
                                        3, 1,
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, self.bounds);
    
    // restore context = remove clipping
    CGContextRestoreGState(context);
}

- (void)setRank:(NSUInteger)rank
{
    _rank =rank;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color =color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading =shading;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

-(void) setFaceUp:(BOOL)faceUp
{
    _faceUp =faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Initialization
- (void)setup
{
    // do initializaion here
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;

}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    [self setup];
    return self;
}

@end
