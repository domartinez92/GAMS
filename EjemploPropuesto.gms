$ontext
 J.C. Nickles recibe pagos de tarjeta de credito desde cuatro regiones del pais
(Oeste, Oeste medio, Este y Sur). El valor promedio diario de pagos que envian
por correo los clientes desde cada region es como se indica: Oeste, 70000 dolares;
Oeste medio, 50000 dolares; Este, 60000 dolares, Sur, 40000 dolares. Nickles tiene
que decidir en dónde los clientes deben enviar por correo sus pagos. Como Nickles
puede ganar 20% de interes anual si invierte estos ingresos, le gustaria recibir
los pagos tan rapido como sea posible. Nickles piensa iniciar un sistema de percepcion
de pagos para procesar los pagos tan rapido como sea posible en cuatro ciudades distintas:
Los Angeles, Chicago, Nueva York y Atlanta.

La cantidad promedio de dias (desde el momento en que el pago se envia) hasta
que es aprobado el cheque y Nickles puede depositar el dinero, depende de la
ciudad a la cual se envia el pago, según se muestra en la tabla 1. Por ejemplo,
si se envia un cheque desde el Oeste hasta Atlanta, se requieren 8 dias promedio
antes de que Nickles pueda ganar intereses con el cheque. El costo anual de
financiar un sistema de percepcion de pagos en cualquier ciudad es 50000 dolares.
Plantee un PE con el que Nickles pueda minimizar la suma de los costos debido al
interes perdido y a las operaciones del sistema de percepcion de pagos. Suponga
que cada region tiene que enviar todo su dinero a una sola ciudad, y que no hay
limite en cuanto a la cantidad de dinero que puede manejar cada sistema de percepcion
de pagos.

Tabla 1: Duracion promedio en dias del envio de pagos para Nickles
          Los Angeles        Chicago        Nueva York        Atlanta
Oeste           2               6                8               8
Medio Oeste     6               2                5               5
Este            8               5                2               5
Sur             8               5                5               2
$offtext

**Establecer los conjuntos del problema, normalmente relacionados con elementos
** importantes del problema para este caso (Ciudades y Zonas)
sets i   zonas           /Oeste, MedioOeste, Este, Sur/
     j   ciudades        /LosAngeles, Chicago, NuevaYork, Atlanta/;
** Datos proporcionados por el problema
*Pagos realizados por cada zona
parameter pagos(i) pagos por cada zona
/
Oeste            70000
MedioOeste       50000
Este             60000
Sur              40000
/;
** interes perdido por Nickles
scalar interes /0.2/;
** Cantidad de dias en promedio de envios de cada zona a cada ciudad
table dias(i,j) duracion en dias de los envios

                 LosAngeles      Chicago         NuevaYork       Atlanta
Oeste                 2             6                8              8
MedioOeste            6             2                5              5
Este                  8             5                2              5
Sur                   8             5                5              2;
**Costo anual por habilitar un centro de percepción de pagos en una ciudad cualquiera
scalar cabrir costo de apertura de un centro /50000/;
**definicion de variables de decision
** en este problema se deben tomar dos decisiones la primera es que ciudades habilitar
** para ser puntos de percepcion de pagos y que zona debe ser asignado a cada punto
** de pago habilitado.

**decision de habilitar la ciudad como punto de percepcion
binary variable y(j) toma el valor de cero si no se habilita uno si se habilita la ciudad j;
binary variable x(i,j) se asigna la zona i a la ciudad j;
free variable z variable para la funcion objetivo;
**Declarar las equaciones requeridas para el problema
**las ecuaciones requeridas para este problema son
** 1.funcion objetivo: costo total anual
** 2.restriccion tipo 1: cada region debe enviar sus pagos a una sola ciudad
** 3.restriccion tipo 2: Si se asigna una zona a una ciudad esta debe considerar el cargo fijo del punto de percepcion de pagos (50000)
equations
funobj           funcion objetivo costos anuales
rtipo1(i)        restriccion tipo 1
rtipo2(i,j)      restriccion tipo 2;

** Definir las ecuaciones declaradas
** costo anual = costo anual de operacion + costo anual del interes perdido
funobj.. z=e= sum((i,j),dias(i,j)*pagos(i)*interes*x(i,j))+sum(j, cabrir*y(j));
** restriccion para cada zona i en la cual asegura que solo se asigne una ciudad
rtipo1(i).. sum(j, x(i,j))=e= 1;
** restriccion para cada zona y ciudad que garantiza que cada variable binaria x(i,j)
** se actualice con cada y(j) es decir si y(j) es igual a 1 x(i,j) puede ser igual a 1
rtipo2(i,j).. x(i,j)=l=y(j);
** se define el modelo y se llama ejemplo en el cual se especifica que todas las ecuaciones hacen parte del modelo
model ejemplo /all/;
** sentencia de solucion la cual dice que debe minimizarse la variable z
** utilizando un solver de tipo MIP -Mixed Integer Programin o Programacion
** Entera Mixta
solve ejemplo minimizing z using MIP;





