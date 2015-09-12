//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@interface ListaContatosViewController ()

@end

@implementation ListaContatosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // criando botao para colocar no navigation bar, filho de UIButton
    UIBarButtonItem *form = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
    
    // @[] é um atalho para criar um array imutavel
    // @"" é um atalho para criar uma string
    // obtendo o navigation bar e adicionando botao na direita
    self.navigationItem.rightBarButtonItems = @[form];
    
    self.navigationItem.title = @"Contatos";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
                             
- (void)exibeFormulario {
    NSLog(@"Exibindo form");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *formularioContatoViewController = [storyboard instantiateViewControllerWithIdentifier:@"Form_Contato"];
    [self.navigationController pushViewController:formularioContatoViewController animated:YES];
}

@end
