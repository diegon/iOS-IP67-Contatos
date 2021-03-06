//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 26/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import "ContatoDao.h"
#import "MKMapView+ZoomOut.h"

@interface ContatosNoMapaViewController ()

@property (nonatomic, strong) ContatoDao *dao;
@property (nonatomic, strong) NSArray *contatos;

@end

@implementation ContatosNoMapaViewController

- (id)init {
    self = [super init];
    if(self) {
        // obtendo tabbar e editando a apresentacao
        self.tabBarItem.title = @"Mapa";
        self.tabBarItem.image = [UIImage imageNamed:@"mapa-contatos.png"];
        self.navigationItem.title = @"Localização";
        self.dao = [ContatoDao contatoDaoInstance];
        self.contatos = [self.dao lista];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // criando o mapa programaticamente
//    float x = self.navigationController.view.frame.origin.x;
//    float y = self.navigationController.view.frame.origin.y;
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height + self.tabBarController.view.frame.size.height + self.navigationController.view.frame.size.height;
//    self.mapa = [[MKMapView alloc]initWithFrame:CGRectMake(x,y,width,height)];
//    [self.view addSubview:self.mapa];
    // --
    
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem = botaoLocalizacao;

    // links uteis
    // http://stackoverflow.com/questions/28661963/locationmanager-requestwheninuseauthorization-not-working (propriedade do Info.plist para funcionar o requestWhenInUseAuthorization)
    // http://nevan.net/2014/09/core-location-manager-changes-in-ios-8/
    // --
    self.manager = [CLLocationManager new];
    //[self.manager requestAlwaysAuthorization]; // mostra ao abrir o view controller do mapa
    [self.manager requestWhenInUseAuthorization]; // mostra ao abrir usar o botao de localizacao
    //self.mapa.delegate = self; // me tornando chefe do mapa, mas pode fazer visualmente pelo .xib (botao direito na view)
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapa addAnnotations:self.contatos];
    [self.mapa zoomOut];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.mapa removeAnnotations:self.contatos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if([annotation isKindOfClass:[Contato class]]) {
        Contato *contato = (Contato *) annotation;
        static NSString *identificador = @"pino";
        MKPinAnnotationView *pino = (MKPinAnnotationView *) [self.mapa dequeueReusableAnnotationViewWithIdentifier:identificador];
        if(!pino) {
            pino = [[MKPinAnnotationView alloc] initWithAnnotation:contato reuseIdentifier:identificador];
        } else {
            pino.annotation = annotation;
        }
        
        pino.pinColor = MKPinAnnotationColorGreen;
        pino.canShowCallout = YES;
        
        if(contato.foto) {
            UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
            imagemContato.image = contato.foto;
            pino.leftCalloutAccessoryView = imagemContato;
        }
        
        pino.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return pino;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"clicou no callout %@", control);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
