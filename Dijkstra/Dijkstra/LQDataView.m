//
//  LQDataView.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDataView.h"


@interface LQDataView ()
@property (nonatomic , assign) CGPoint startPoint;
@property (nonatomic , assign) CGPoint toPoint;
@property (nonatomic , strong) UIButton *edit;
@property (nonatomic , strong) NSMutableArray *lines;


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
    
    UIButton *edit = [[UIButton alloc] initWithFrame:CGRectMake(200, 30, 50, 30)];
    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit setTitle:@"完成" forState:UIControlStateSelected];
    [edit addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:edit];
    self.edit = edit;
    
    for (int i = 0; i < number; i++) {
        {
           UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(130, 230, 30, 30)];
           view.backgroundColor = UIColor.darkGrayColor;
               view.text = @"A";
               view.textAlignment = NSTextAlignmentCenter;
               view.layer.cornerRadius = 15;
               view.layer.masksToBounds = YES;
           [self addSubview:view];
           }
        }
    
    {
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(130, 130, 30, 30)];
    view.backgroundColor = UIColor.darkGrayColor;
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"B";
        view.layer.cornerRadius = 15;
        view.layer.masksToBounds = YES;
    [self addSubview:view];
    }
    
    {
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(230, 130, 30, 30)];
    view.backgroundColor = UIColor.darkGrayColor;
        view.text = @"C";
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.cornerRadius = 15;
        view.layer.masksToBounds = YES;
    [self addSubview:view];
    }
    
    {
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(230, 230, 30, 30)];
    view.backgroundColor = UIColor.darkGrayColor;
        view.text = @"D";
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.cornerRadius = 15;
        view.layer.masksToBounds = YES;
    [self addSubview:view];
    }
    
}

-(void)startEdit:(UIButton *)btn{
    btn.selected = !btn.selected;
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSLog(@"start point = %@",NSStringFromCGPoint(point));
    
    self.startPoint = point;
    
    
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touched = %@",touches);
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSLog(@"point = %@",NSStringFromCGPoint(point));
    
    self.toPoint = point;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (!self.edit.selected) {
        return;
    }
    NSLog(@"开始划线");
    
    
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.lines addObject:path];
    [path moveToPoint:self.startPoint];
    path.lineWidth = 1;
    [[UIColor colorWithWhite:1.0 alpha:1] setStroke];

    [path addLineToPoint:self.toPoint];
    [path stroke];
    
    
    
    
}
-(NSMutableArray *)lines{
    if (_lines == nil) {
        _lines = [NSMutableArray arrayWithCapacity:2];
    }
    return _lines;
}

@end
