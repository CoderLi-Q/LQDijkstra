//
//  LQDataView.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDataView.h"
#import "LQPointModel.h"

@interface LQDataView ()
@property (nonatomic , strong) NSMutableArray *linesArray;
@property (nonatomic , assign) CGPoint beginPoint;
@property (nonatomic , assign) CGPoint toPoint;
@property (nonatomic , assign) CGPoint endPoint;
@property (nonatomic , strong) UIButton *edit;


@property (nonatomic , strong) UIButton *moveItem;


@property (nonatomic , strong) NSMutableArray *viewArray;
@property (nonatomic , weak) UIView *currentMoveView;

@end

@implementation LQDataView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setNumber:(NSInteger)number{
    _number = number;
    
    UIButton *edit = [[UIButton alloc] initWithFrame:CGRectMake(200, 30, 100, 30)];
    [edit setTitle:@"添加连接" forState:UIControlStateNormal];
    edit.backgroundColor = UIColor.darkGrayColor;
    [edit setTitle:@"连接完成" forState:UIControlStateSelected];
    [edit setTitleColor:UIColor.redColor forState:UIControlStateSelected];
    [edit addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:edit];
    self.edit = edit;
    
    
    {
        UIButton *edit = [[UIButton alloc] initWithFrame:CGRectMake(80, 30, 100, 30)];
        [edit setTitle:@"编辑位置" forState:UIControlStateNormal];
        edit.backgroundColor = UIColor.darkGrayColor;
        [edit setTitle:@"编辑完成" forState:UIControlStateSelected];
        [edit setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        [edit addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:edit];
        self.moveItem = edit;
    }
    
    

    CGFloat w = 30;
    CGFloat h = 30;
    
    for (int i = 0; i < number; i++) {
        
        CGFloat x = arc4random_uniform(self.frame.size.width-100)+50;
        CGFloat y = arc4random_uniform(self.frame.size.height-150)+50;
        
        
            UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
            view.backgroundColor = UIColor.darkGrayColor;

            char a = 'A';
            char n = a + i;
            view.text = [NSString stringWithFormat:@"%c",n];
            view.textAlignment = NSTextAlignmentCenter;
            view.layer.cornerRadius = 15;
            view.layer.masksToBounds = YES;
            [self addSubview:view];
        
        [self.viewArray addObject:view];
    }
    
  
}

-(void)startEdit:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if ([btn isEqual:self.edit] && btn.selected) {
        self.moveItem.selected = NO;
    }
    if ([btn isEqual:self.moveItem] && btn.selected) {
        self.edit.selected = NO;
    }
    
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (!self.edit.selected && !self.moveItem.selected) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    [UIColor.redColor setStroke];
    
    if (!CGPointEqualToPoint(self.beginPoint, CGPointZero) && !CGPointEqualToPoint(self.toPoint, CGPointZero)) {
        [path moveToPoint:self.beginPoint];
        [path addLineToPoint:self.toPoint];
    }
    
    
    for (LQPointModel *model in self.linesArray) {
        NSLog(@"%@",model);
        CGPoint startPoint = model.startPointValue.CGPointValue;
        CGPoint endPoint = model.endPointValue.CGPointValue;
        
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
    }

    [path stroke];
}

-(UIView *)isInAnyView:(CGPoint )point event:(UIEvent *)event{

    for (UIView *view in self.viewArray) {
        CGPoint viewPoint = [self convertPoint:point toView:view];
        if ([view pointInside:viewPoint withEvent:event]) {
            return view;
        }
    }
    return nil;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
        self.beginPoint = CGPointZero;
        self.endPoint = CGPointZero;
    
    if (!self.edit.selected && !self.moveItem.selected) {
        return;
    }else{
        if (self.edit.selected) {
                UITouch *touch = touches.anyObject;
            self.beginPoint = [touch locationInView:self];
            
            NSLog(@"start--%@",NSStringFromCGPoint(self.beginPoint));
        }else if(self.moveItem.selected){
            self.currentMoveView = nil;
            UITouch *touch = touches.anyObject;
            CGPoint point = [touch locationInView:self];
            

            
            
            UIView *vi = [self isInAnyView:point event:event];
            if (vi) {
                self.currentMoveView = vi;
                self.beginPoint = point;
                NSLog(@"Move--%@",NSStringFromCGPoint(self.beginPoint));
            }
            
            
        }
    }

    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.edit.selected && !self.moveItem.selected) {
        return;
    }else{
        if (self.edit.selected) {
            UITouch *touch = touches.anyObject;
            self.toPoint = [touch locationInView:self];
            NSLog(@"start--%@",NSStringFromCGPoint(self.beginPoint));
            [self setNeedsDisplay];
        }else if(self.moveItem.selected){
            UITouch *touch = touches.anyObject;
            self.toPoint = [touch locationInView:self];
            
//            CGPoint viewPoint = [self convertPoint:self.toPoint toView:self.currentMoveView];
            
            if (self.currentMoveView) {
                CGPoint viewPoint = [self convertPoint:self.toPoint toView:self];
                CGRect fram = self.currentMoveView.frame;
                fram.origin  = viewPoint;
                self.currentMoveView.frame = fram;
                
                //找到线，更新点
                
                
                for (LQPointModel *model in self.linesArray) {
                     NSString *key = [model containView:self.currentMoveView];
                    
                    if (key != nil) {
                        [model setValue:[NSValue valueWithCGPoint:self.currentMoveView.center] forKey:key];
                        NSLog(@"model - %@",model);
                    }
                }
                self.toPoint = CGPointZero;
                [self setNeedsDisplay];
            
            }
        }
    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.edit.selected && !self.moveItem.selected) {
        return;
    }else{
        if (self.edit.selected) {
            UITouch *touch = touches.anyObject;
            self.endPoint = [touch locationInView:self];
            
            
            UIView *endV = [self isInAnyView:self.endPoint event:event];
            UIView *beginV = [self isInAnyView:self.beginPoint event:event];
            if (endV && beginV && ![endV isEqual:beginV]) {
                
                LQPointModel *point = [[LQPointModel alloc] init];
                point.startPointValue = [NSValue valueWithCGPoint:beginV.center];
                point.endPointValue = [NSValue valueWithCGPoint:endV.center];
                point.startView = beginV;
                point.endView = endV;
                [self.linesArray addObject:point];
                self.beginPoint = CGPointZero;
                self.toPoint = CGPointZero;
                [self setNeedsDisplay];
            }
            
            
           
        }else{
            
        }
    }
    

    
}
-(NSMutableArray *)linesArray{
    if (_linesArray == nil) {
        _linesArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _linesArray;
}
-(NSMutableArray *)viewArray{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _viewArray;
}

@end
