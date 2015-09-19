//
//  GerenciadorDeAcoes.m
//  ContatosIP67
//
//  Created by ios5380 on 19/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "GerenciadorDeAcoes.h"

@implementation GerenciadorDeAcoes

- (id)initWithContato:(Contato *) contato {
    self = [super init];
    if(self) {
        self.contato = contato;
    }
    return self;
}

- (void)acoesDoController:(UIViewController *) controller {
    self.controller = controller;
    UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:self.contato.nome
                                                        delegate:self
                                               cancelButtonTitle:@"Cancelar"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar site", @"Abrir mapa", nil];
    [opcoes showInView:controller.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

@end
