# ProductsApp

En el siguiente texto se explicara la arquitectura logica para la aplicación ProductsApp.

__________________
ARQUITECTURA VIPER

VIPER es un acrónimo de View, Interactor, Presenter, Entity y Router.

VIEW. la responsabilidad de la vista es de enviar las acciones del usuario al presentar y enseñar lo que le dice el presenter.

INTERACTOR. Contiene la lógica de negocio descrita por el use cases en la aplicación. El interactor es responsable de atraer data desde la capa de mode, y su implementación es totalmente independiente de la interface del usuario.

PRESENTER. Su responsabilidad es de coger data desde el interactor en acciones de usuario, crear un ejemplo de modelo vista y llevarlo hacia el View para mostrarlo.

ENTITY. Contiene el modelo básico de objetos usados por el interactor. Tiene parte de responsabilidades de la capa modelo en otras arquitecturas.

ROUTER. Tiene toda la lógica de navegación para describir lo que la pantalla quiere mostrar y cuando.

Esta arquitectura está basada en Principios de Responsabilidad Unica, que guía hacia una arquitectura más limpia.

El aplicativo cuenta con una carpeta Modules, la cual tiene tres subcarpetas que representan las vistas que tiene el APP, estas son:

- Home: Es la encargada de la logica inicial del app junto con la vista inicial, este modulo no realiza ningun consumo a API.
- Product: Este modulo se encarga de la busqueda de productos, por este motivo realiza el llamado al API para obtener los productos, como tambien genera el modelo de Producto segun el DTO que recibe.
- ProductDetail: Por ultimo este modulo es el encargado de mostrar los detalles del producto seleccionado. El modelo que tiene la información es suministrado por el modulo Product.

Cada uno de estos modulos sigue la arquitectura VIPER y principios SOLID.

_______________
NETWORKING

En la carpeta NetworkManager se encuentra toda la logica de conexión al API que proveede toda la información del los productos. Este modulo se ayuda del package dependecy de Alamofire para poder realizar las peticiones. En este caso solo se realiza una petición GET.

_________
UNIT TEST

El app cuenta con Unit Test a las clases Presenter e Interactor. Los Unit Test tienen un sut (System under test), este sera el encargado de ejecutar el test. Segun la clase es necesario requerir un Mock de las clases View, Router, Interactor, Presenter.

