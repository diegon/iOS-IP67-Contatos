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
    NSLog(@"index: %li", (long)buttonIndex);
    
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        case 4:
            break;
        default:
            break;
    }
    
}

- (void)abrirAplicativoComURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)ligar {
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]) {
        NSString *numero = [NSString stringWithFormat:@"tel:%@", _contato.telefone];
        [self abrirAplicativoComURL:numero];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligação!"
                                   message:@"Seu dispositivo não é um iPhone"
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }
}

- (void)abrirSite {
    NSString *url = _contato.site;
    NSRange range = [url rangeOfString:@"http://"];
    if(range.location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@", url];
    }
    [self abrirAplicativoComURL:url];
}

- (void)mostrarMapa {
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",_contato.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
}

- (void)enviarEmail {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEmail = [MFMailComposeViewController new];
        enviadorEmail.mailComposeDelegate = self;
        
        [enviadorEmail setToRecipients:@[_contato.email]];
        [enviadorEmail setSubject:@"Caelum"];
        
        [self.controller presentViewController:enviadorEmail animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                    message:@"Não é possível enviar email"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSLog(@"mailComposeController didFinishWithResult");
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}


@end
