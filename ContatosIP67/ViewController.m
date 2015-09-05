//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"Carregou: %@", self.labelHello.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pegaDadosDoFormulario {
    NSLog(@"Clicou");
    
    NSString *nome = self.nome.text;
    self.labelHello.text = nome;
}

@end
