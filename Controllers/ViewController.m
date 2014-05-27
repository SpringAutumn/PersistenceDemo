//
//  ViewController.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "ViewController.h"
#import "CodeMonkey.h"
#import "PropertyListStore.h"
#import "JSONStore.h"
#import "ObjectArchiveStore.h"
#import "SQLiteStore.h"
#import "CoreDataStore.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *manifestTextField;
@property (weak, nonatomic) IBOutlet UITextField *locTextField;

- (IBAction)usePropertyList:(id)sender;
- (IBAction)useJSON:(id)sender;
- (IBAction)UseObjectArchive:(id)sender;
- (IBAction)useSQLite:(id)sender;
- (IBAction)useCoreData:(id)sender;

- (CodeMonkey *)WelcomeCodeMonkey;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
  [self.view addGestureRecognizer:tap];
    
  self.nameTextField.text = @"Jack";
  self.manifestTextField.text = @"I think therefore I exist";
  self.locTextField.text = @"99999";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (IBAction)usePropertyList:(id)sender {
    CodeMonkey *cm = [self WelcomeCodeMonkey];
    [[PropertyListStore sharedStore] save:cm];
    CodeMonkey *jack = [[PropertyListStore sharedStore] load];
    NSLog(@"Property List Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)useJSON:(id)sender {
    CodeMonkey *cm = [self WelcomeCodeMonkey];
    [[JSONStore sharedStore] save:cm];
    CodeMonkey *jack = [[JSONStore sharedStore] load];
    NSLog(@"JSON Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)UseObjectArchive:(id)sender {
    CodeMonkey *cm = [self WelcomeCodeMonkey];
    [[ObjectArchiveStore sharedStore] save:cm];
    CodeMonkey *jack = [[ObjectArchiveStore sharedStore] load];
    NSLog(@"Object Archive Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)useSQLite:(id)sender {
    CodeMonkey *cm = [self WelcomeCodeMonkey];
    [[SQLiteStore sharedStore] save:cm];
    CodeMonkey *jack = [[SQLiteStore sharedStore] load];
    NSLog(@"SQLite Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)useCoreData:(id)sender {
    CodeMonkey *cm = [self WelcomeCodeMonkey];
    [[CoreDataStore sharedStore] save:cm];
    CodeMonkey *jack = [[CoreDataStore sharedStore] load];
    NSLog(@"Core Data Show CodeMonkey = %@", [jack toDict]);
}

- (CodeMonkey *)WelcomeCodeMonkey; {
    CodeMonkey *cm = [[CodeMonkey alloc] init];
    if ([self.nameTextField.text length] > 0) {
        cm.name = self.nameTextField.text;
    } else {
        cm.name = @"NA";
    }
    
    if ([self.manifestTextField.text length] > 0) {
        cm.manifest = self.manifestTextField.text;
    } else {
        cm.manifest = @"NA";
    }
    if ([self.locTextField.text length] > 0) {
        cm.linesOfCode = [self.locTextField.text integerValue];
    } else {
        cm.linesOfCode = 0;
    }

  return cm;
}

- (void)hideKeyboard:(UITapGestureRecognizer *)sender {
  [self.nameTextField resignFirstResponder];
  [self.manifestTextField resignFirstResponder];
  [self.locTextField resignFirstResponder];
}

@end
