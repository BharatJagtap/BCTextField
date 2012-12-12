//
//  BCTextField.h
//  CustomTextField
//
//  Created by Bitcode Macmini 2 on 06/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCTextFieldDelegate;

typedef enum  {
   BCTextFieldTypeNone = 0,
   BCTextFieldTypePicker = 1 ,
   BCTextFieldTypeDatePicker = 2     
} BCTextFieldType;


@interface BCTextField : UITextField <UIPickerViewDelegate,UIPickerViewDataSource>
{
    
@private;
    UIPopoverController * popOverController;
}
-(id)initWithType:(BCTextFieldType)type_;
@property(nonatomic,strong) NSDate * date;
@property(nonatomic) BCTextFieldType type;
@property(nonatomic,strong) NSArray * items;
@property(nonatomic) UIDatePickerMode datePickerMode;
@property(nonatomic,strong) NSDateFormatter * dateFormatter;
@property(nonatomic,assign) id<BCTextFieldDelegate> bcDelegate;
@end

@protocol BCTextFieldDelegate <NSObject>

-(void)next:(BCTextField*)textField;
-(void)previous:(BCTextField*)textField;

@end