//
//  LQDataView.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDataView.h"
#import "LQPointModel.h"
#define  kWindowSize UIScreen.mainScreen.bounds.size
@interface LQDataView ()<UITextFieldDelegate>
@property (nonatomic , strong) NSMutableArray *linesArray;
@property (nonatomic , assign) CGPoint beginPoint;
@property (nonatomic , assign) CGPoint toPoint;
@property (nonatomic , assign) CGPoint endPoint;
@property (nonatomic , strong) UIButton *edit;
@property (nonatomic , weak) UITextField *currentEditTextField;
@property (nonatomic , assign) CGRect origFrame;


@property (nonatomic , strong) UIButton *moveItem;


@property (nonatomic , strong) NSMutableArray *viewArray;
@property (nonatomic , weak) UIView *currentMoveView;

@property (nonatomic , weak) UILabel *temp1Label;
@property (nonatomic , weak) UILabel *temp2Label;
@end

@implementation LQDataView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
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
    BOOL is = !btn.selected;
    
    
    if ([btn isEqual:self.edit]) {
           if (!btn.selected) {
               
               self.moveItem.selected = NO;
           }else{
               self.beginPoint = CGPointZero;
               self.endPoint = CGPointZero;
               [self setNeedsDisplay];
           }
       }
       if ([btn isEqual:self.moveItem] && !btn.selected) {
           self.edit.selected = NO;
       }
    
    
    btn.selected = is;
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    
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
        CGPoint center = CGPointMake((startPoint.x+endPoint.x)/2.0, (startPoint.y+endPoint.y)/2.0);
        
        model.textf.frame = CGRectMake(center.x-15, center.y-15, 30, 30);
        
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
    [self.currentEditTextField resignFirstResponder];
    
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
                [self addValueWithModel:point];
                [self.linesArray addObject:point];
                self.beginPoint = CGPointZero;
                self.toPoint = CGPointZero;
                [self setNeedsDisplay];
            }
            
            
           
        }else{
            
        }
    }
}


- (void)addValueWithModel:(LQPointModel *)model{
    UITextField *textF = [[UITextField alloc] init];
    textF.textAlignment = NSTextAlignmentCenter;
    textF.delegate = self;
    textF.keyboardType = UIKeyboardTypeNumberPad;
    CGPoint begin = model.startPointValue.CGPointValue;
    CGPoint end = model.endPointValue.CGPointValue;
    CGPoint center = CGPointMake((begin.x+end.x)/2.0, (begin.y+end.y)/2.0);
    
    textF.frame = CGRectMake(center.x-15, center.y-15, 30, 30);
    textF.text = @"15";
    
    
    model.textf = textF;
    [self addSubview:textF];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentEditTextField = textField;
    self.origFrame = textField.frame;
    
    [self showTempViewWithDuration:0.25 y:510];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.currentEditTextField.frame = self.origFrame;
    self.currentEditTextField = nil;
}



-(void)showTempViewWithDuration:(NSTimeInterval)duration y:(CGFloat)y{
    //获取两端点
    LQPointModel *currentM = nil;
    for (LQPointModel *model in self.linesArray) {
        if ([model.textf isEqual:self.currentEditTextField]) {
            currentM = model;
            break;
        }
    }
    
    NSString *p1 = currentM.startView.text;
    NSString *p2 = currentM.endView.text;
    
    //创建label在textf两端
    if (self.temp1Label == nil) {
        UILabel *tempLabel1 = [[UILabel alloc] init];
      
        tempLabel1.textColor = UIColor.greenColor;
        self.temp1Label = tempLabel1;
        [self addSubview:self.temp1Label];
    }
    if (self.temp2Label == nil) {
        UILabel *tempLabel2 = [[UILabel alloc] init];
       
        tempLabel2.textColor = UIColor.greenColor;
        self.temp2Label = tempLabel2;
        [self addSubview:self.temp2Label];
    }
    self.temp1Label.text = p1;
    self.temp2Label.text = p2;

    [UIView animateWithDuration:duration animations:^{
        
        self.currentEditTextField.frame = CGRectMake((kWindowSize.width-self.origFrame.size.width)/2, y-self.origFrame.size.height-10-self.frame.origin.y, self.origFrame.size.width, self.origFrame.size.height);
        
        self.temp1Label.frame = CGRectMake(self.currentEditTextField.frame.origin.x - 30 - 10, self.currentEditTextField.frame.origin.y, 30, self.currentEditTextField.frame.size.height);
        self.temp2Label.frame = CGRectMake(CGRectGetMaxX(self.currentEditTextField.frame) +  10, self.currentEditTextField.frame.origin.y, 30, self.currentEditTextField.frame.size.height);
        self.temp2Label.alpha = 1;
        self.temp1Label.alpha = 1;
    }];
}

-(void)keyboardShow:(NSNotification *)noti{
    NSLog(@"%@",noti);
    NSDictionary *userInfo = noti.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
//    [self showTempViewWithDuration:duration y:y];
    
}

-(void)keyboardHidden:(NSNotification *)noti{
    NSLog(@"%@",noti);
    NSDictionary *userInfo = noti.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        self.temp2Label.alpha = 0;
        self.temp1Label.alpha = 0;
            self.currentEditTextField.frame = self.origFrame;
        
    }completion:^(BOOL finished) {

    }];

}

-(NSArray<LQPathModel *> *)pathDatas{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3];
    for (LQPointModel *model in self.linesArray) {
        LQPathModel *path = [[LQPathModel alloc] init];
        path.startPoint = model.startView.text;
        path.endPoint = model.endView.text;
        path.value = model.textf.text.floatValue;
        
        [arr addObject:path];
    }
    return arr;
}

-(void)setPathDatas:(NSArray<LQPathModel *> *)pathDatas{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3];
    for (LQPathModel *model in self.pathDatas) {
        LQPointModel *path = [[LQPointModel alloc] init];
        CGFloat x = arc4random_uniform(self.frame.size.width-100)+50;
        CGFloat y = arc4random_uniform(self.frame.size.height-150)+50;
        path.startPointValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        x = arc4random_uniform(self.frame.size.width-100)+50;
        y = arc4random_uniform(self.frame.size.height-150)+50;
        path.endPointValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        
        UILabel *startView = [[UILabel alloc] init];
        CGPoint start = path.startPointValue.CGPointValue;
        startView.frame = CGRectMake(start.x-15, start.y-15, 30, 30);
        startView.textAlignment = NSTextAlignmentCenter;
        startView.layer.cornerRadius = 15;
        startView.layer.masksToBounds = YES;
        path.startView = startView;
        [self addSubview:startView];
        
        {
            UILabel *startView = [[UILabel alloc] init];
            CGPoint start = path.endPointValue.CGPointValue;
            startView.frame = CGRectMake(start.x-15, start.y-15, 30, 30);
            startView.textAlignment = NSTextAlignmentCenter;
            startView.layer.cornerRadius = 15;
            startView.layer.masksToBounds = YES;
            path.endView = startView;
            [self addSubview:startView];
        }
        
        path.value = model.value;
        
        
        {
            UITextField *textF = [[UITextField alloc] init];
            textF.textAlignment = NSTextAlignmentCenter;
            textF.delegate = self;
            textF.keyboardType = UIKeyboardTypeNumberPad;
            CGPoint begin = path.startPointValue.CGPointValue;
            CGPoint end = path.endPointValue.CGPointValue;
            CGPoint center = CGPointMake((begin.x+end.x)/2.0, (begin.y+end.y)/2.0);
            
            textF.frame = CGRectMake(center.x-15, center.y-15, 30, 30);
            [self addSubview:textF];
            path.textf = textF;
        }
        [arr addObject:path];
    }
    self.linesArray = [NSArray arrayWithArray:arr];
    [self setNeedsDisplay];
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
