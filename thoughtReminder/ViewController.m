//
//  ViewController.m
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import "ViewController.h"
#import "ThoughtsStorage.h"
@import FirebaseAnalytics;

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionTextField.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)saveButtonPressed:(id)sender {
    [[ThoughtsStorage sharedInstance] addThoughts:self.questionTextField.text];
    [FIRAnalytics logEventWithName:@"save_thought" parameters:@{@"thought": self.questionTextField.text}];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.questionTextField endEditing:YES];
    self.saveButton.enabled = YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.saveButton.enabled = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.saveButton.enabled = YES;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
