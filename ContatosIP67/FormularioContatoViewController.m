//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import <CoreLocation/CoreLocation.h>

@interface FormularioContatoViewController ()
//@property (strong) NSMutableArray *contatos; // poderia colocar aqui
//@property Contato *contato;
@end

@implementation FormularioContatoViewController

// SOBRESCRITA DE CONSTRUTOR DEFAULT
// storyboard NAO CHAMA este
// xib CHAMA este
// um typedef de NSObject * é o id
- (id) init {
    self = [super init];
    if(self) {
        // Movido para ContatoDao
        //self.contatos = [NSMutableArray new];
    }
    return self;
}

// CONSTRUTOR COM PARAMETROS
// storyboard CHAMA este
// xib NAO CHAMA este
- (id) initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if(self) {
        // Movido para ContatoDao
        //self.contatos = [NSMutableArray new];
        self.dao = [ContatoDao contatoDaoInstance];
    }
    return self;
}
//--

- (void)viewDidLoad {
    // é rodado uma unica vez no ciclo de vida do formulario
    if(self.contato) {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        
        // arredondar bordas
        // http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
        if(self.contato.foto) {
            [self.botaoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
        }
        
        UIBarButtonItem *botaoAdd = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        
        // @[] é um atalho para criar um array imutavel
        // @"" é um atalho para criar uma string
        // obtendo o navigation bar e adicionando botao na direita
        self.navigationItem.rightBarButtonItems = @[botaoAdd];
        self.navigationItem.title = @"Atualizar";
        
    } else {
        //self.contatos = [NSMutableArray new];
        UIBarButtonItem *botaoAdd = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        
        // @[] é um atalho para criar um array imutavel
        // @"" é um atalho para criar uma string
        // obtendo o navigation bar e adicionando botao na direita
        self.navigationItem.rightBarButtonItems = @[botaoAdd];
        self.navigationItem.title = @"Novo";
    }
    
    // UITextField nao funciona, testar com um UILabel!!
//    UITapGestureRecognizer *orelha = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orelhaEscutou)];
//    [self.nome addGestureRecognizer:orelha];
}

- (void)orelhaEscutou {
    NSLog(@"escutou!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pegaDadosDoFormulario {
    
    // movido para metodo criaContato
    //Contato *contato = [Contato new];
    
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    
    // existe ternário:
    //[self.botaoFoto backgroundImageForState:UIControlStateNormal] ? self.contato.foto = [self.botaoFoto backgroundImageForState:UIControlStateNormal] : nil;
    
    if([self.botaoFoto backgroundImageForState:UIControlStateNormal]) {
        self.contato.foto = [self.botaoFoto backgroundImageForState:UIControlStateNormal];
    }

    //[self.contatos addObject:contato];
    // movido para metodo criaContato
    //[self.dao adicionaContato:contato];
    
    // para um array o description já itera automaticamente.
    //NSLog(@"Array: %@", self.contatos);
    // poderia ser:
    /*
    for (NSString *contato in contatos) {
        NSLog(@"%@", contato);
    }
    */
    //NSLog(@"Array: %@", self.dao.contatos);
    //NSLog(@"Array lenght: %lu", self.contatos.count);
    //NSLog(@"Array lenght: %lu", self.dao.contatos.count);
    
    /*
    NSLog(@"Dados: %@", [contato description]); // o metodo description é análogo ao toString
    // podemos fazer NSLog(@"Dados: %@", contato) que vai invocar o description automaticamente
    */
}

- (void)criaContato {
    
    // adicionando o contato
    // Utilizando o CoreData
    //self.contato = [Contato new];
    self.contato = [self.dao criaNovo];
    [self pegaDadosDoFormulario];
    [self.dao adicionaContato:self.contato];
    
    NSLog(@"Array lenght: %lu", self.dao.contatos.count);
    
    // criando e apresentando um alert
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Titulo" message:@"Mensagem" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    */
    
    // chamando o delegate
    if(self.delegate) {
        [self.delegate contatoAdicionado:self.contato];
    }
    // --
    
    // removendo eu mesmo da pilha de telas, para retornar a anterior
    [self.navigationController popViewControllerAnimated:YES];
    
    // Salvando no banco de dados
    [self.dao saveContext];
    
    // Volta para o root view controller destruindo todas as janelas empurradas (pushed)
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)atualizaContato {
    
    // IMPORTANTE!
    // o contato que foi passado pelo ListaContatosViewController é passado por referencia, ai podemos altera-lo diretamente
    [self pegaDadosDoFormulario];
    
    // chamando o delegate
    if(self.delegate) {
        [self.delegate contatoAtualizado:self.contato];
    }
    // --
    
    // Salvando no banco de dados
    [self.dao saveContext];
    
    // removendo eu mesmo da pilha de telas, para retornar a anterior
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)selecionaFoto:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // camera
    } else {
        // biblioteca
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        
        picker.delegate = self;
        
        // posso colocar este bloco como parametro do completion
//        void (^block) (void) = ^{
//            // alerta com bloco
//            [[[UIAlertView alloc] initWithTitle:@"Aviso"
//                                        message:@"Capriche"
//                                       delegate:nil
//                              cancelButtonTitle:@"ok"
//                              otherButtonTitles:nil] show];
//        };
//        
//        [self presentViewController:picker animated:YES completion:block]
        //
        
        [self presentViewController:picker animated:YES completion:^{
            // alerta com bloco
            [[[UIAlertView alloc] initWithTitle:@"Aviso"
                                        message:@"Capriche"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        }];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)buscarCoordenadas:(UIButton *)sender {
    
    if ([self.endereco.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Aviso"
                                    message:@"Preencha o endereco"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
        return;
    }
    
    [self.carregandoEndereco startAnimating];
    sender.hidden = YES;
    
    CLGeocoder *geo = [CLGeocoder new];
    
    [geo geocodeAddressString:self.endereco.text completionHandler:^(NSArray *resultados, NSError *error) {
        if(error == nil && [resultados count] > 0) {
            CLPlacemark *resultado = resultados[0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f",coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f",coordenada.longitude];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Aviso"
                                        message:@"Nenhum resultado encontrado"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        }
        [self.carregandoEndereco stopAnimating];
        sender.hidden = NO;
    }];
    
}

@end
