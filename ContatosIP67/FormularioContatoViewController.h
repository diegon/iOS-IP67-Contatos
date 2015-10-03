//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void)contatoAtualizado:(Contato *)contato;
- (void)contatoAdicionado:(Contato *)contato;

@end

@interface FormularioContatoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
// Movido para ContatoDao
//@property (strong) NSMutableArray *contatos; // o default é strong, atomic; nao precisaria colocar.
@property ContatoDao *dao;
@property Contato *contato;

// delegates SEMPRE tem q ser weak, esquecer isso pode gerar ilhas de isolamento e dar crash na VM
@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *botaoFoto;
- (IBAction)selecionaFoto:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *carregandoEndereco;

@end

