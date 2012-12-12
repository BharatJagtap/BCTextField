//
//  BCTextField.m
//  CustomTextField
//
//  Created by Bitcode Macmini 2 on 06/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import "BCTextField.h"



@interface BCTextField(Private) <UIPopoverControllerDelegate> 

@end


@implementation BCTextField
@synthesize type;
@synthesize items;
@synthesize date;
@synthesize datePickerMode;
@synthesize bcDelegate;
@synthesize dateFormatter;



-(id)initWithType:(BCTextFieldType)type_
{
    self = [super init];
    if(self)
    {
        self.type = type_;
    }
    return self;
}
-(UIView*)inputView
{
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    if(type == 0 )
    {
        return [super inputView];
    }
    if(type == BCTextFieldTypePicker)
    {
        UIPickerView * picker = [[UIPickerView alloc]init];
        picker.dataSource = self;
        picker.delegate = self;
        picker.showsSelectionIndicator = YES; 
        return picker;
    }
    else if(type == BCTextFieldTypeDatePicker)
    {
        UIDatePicker * datePicker = [[UIDatePicker alloc]init];
        [datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        return datePicker;
    }
    else
        return nil;
    }
    else if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(type == BCTextFieldTypePicker)
        {
            UIPickerView * picker = [[UIPickerView alloc]init];
            picker.dataSource = self;
            picker.delegate = self;
            picker.showsSelectionIndicator = YES; 
            
            UIViewController * vc = [[UIViewController alloc]init];
            vc.contentSizeForViewInPopover = CGSizeMake( picker.bounds.size.width, picker.bounds.size.height);
            vc.view = picker;
            vc.title = ( self.placeholder ? self.placeholder : @"");
            
            UIBarButtonItem * doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(selectPickerValue:)];
            vc.navigationItem.rightBarButtonItem = doneBtn;
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            UIPopoverArrowDirection direction;
            
            if( (self.frame.origin.y + self.frame.size.height) < ( [[self superview] bounds].size.height - 250 ))
            {
                direction = UIPopoverArrowDirectionUp;
            }
            else
            {
                direction = UIPopoverArrowDirectionDown;
            }
            
            
            popOverController = [[UIPopoverController alloc]initWithContentViewController:nav];
            [popOverController presentPopoverFromRect:[self frame] inView:[self superview] permittedArrowDirections:direction animated:YES];
            popOverController.delegate = self;
            UIView * v =[[UIView alloc]initWithFrame:CGRectZero];
            v.backgroundColor = [UIColor clearColor];
            return v;
        }
        else if(type == BCTextFieldTypeDatePicker)
        {
            
            UIDatePicker * datePicker = [[UIDatePicker alloc]init];
            [datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
            
            UIViewController * vc = [[UIViewController alloc]init];
            vc.contentSizeForViewInPopover = CGSizeMake( datePicker.bounds.size.width, datePicker.bounds.size.height);
            vc.view = datePicker;
            vc.title = ( self.placeholder ? self.placeholder : @"");
            
            UIBarButtonItem * doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(selectPickerValue:)];
            vc.navigationItem.rightBarButtonItem = doneBtn;
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            UIPopoverArrowDirection direction;
            
            if( (self.frame.origin.y + self.frame.size.height) < ( [[self superview] bounds].size.height - 250 ))
            {
                direction = UIPopoverArrowDirectionUp;
            }
            else
            {
                direction = UIPopoverArrowDirectionDown;
            }

            popOverController = [[UIPopoverController alloc]initWithContentViewController:nav];
            [popOverController presentPopoverFromRect:[self frame] inView:[self superview] permittedArrowDirections:direction animated:YES];
            popOverController.delegate = self;
            UIView * v =[[UIView alloc]initWithFrame:CGRectZero];
            v.backgroundColor = [UIColor clearColor];
            return v;

            
        }
        else
            return [super inputView];
   
        
    }
    return [super inputView];
}


-(UIView*)inputAccessoryView
{ 
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return nil;
    
    
    UIToolbar * toolbar = [[UIToolbar alloc]init];
    CGRect rect = [[UIScreen mainScreen]bounds];
    toolbar.frame = CGRectMake(0, 0, rect.size.width, 44);
    UIBarButtonItem * dontbtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    UIBarButtonItem * flexBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:[UIImage imageNamed:@"left.png"],[UIImage imageNamed:@"right.png"], nil]];
    
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    [seg setWidth:40 forSegmentAtIndex:0];
    [seg setWidth:40 forSegmentAtIndex:1];
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem * nextPrevBtn = [[UIBarButtonItem alloc]initWithCustomView:seg];
    
    [toolbar setItems:[NSArray arrayWithObjects:nextPrevBtn,flexBtn,dontbtn, nil]];
    
    return toolbar;
}

-(void)done:(id)sender
{
    
    [self resignFirstResponder];

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return items.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [items objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setText:[items objectAtIndex:row]];
}

-(void)dateSelected:(id)sender
{
    if(dateFormatter)
    {
        NSString * dateText = [self.dateFormatter stringFromDate:[(UIDatePicker*)sender date]];
        [self setText:dateText];
    }
    else
        [self setText:[[(UIDatePicker*)sender date]description]];
    
    [self setDate:[(UIDatePicker*)sender date]];
}

-(void)segChanged:(id)sender
{
    if([(UISegmentedControl*)sender selectedSegmentIndex] == 0)
    {
        if([bcDelegate respondsToSelector:@selector(previous:)])
            [bcDelegate previous:self];
    }
    else
    {
        if([bcDelegate respondsToSelector:@selector(next:)])
           [bcDelegate next:self];
    }
    
    
    [(UISegmentedControl*)sender setSelectedSegmentIndex:-1];
}

-(void)selectPickerValue:(id)sender
{
    [popOverController dismissPopoverAnimated:YES];
        [self resignFirstResponder];
}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self resignFirstResponder];
}
    

@end
