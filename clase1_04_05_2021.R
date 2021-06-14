#---- 1. USO DE R COMO CALCULADORA ----
4+5
6*8
(4+5)+(6*8)
#Se pueden hacer cosas mucho más interesantes. Para eso es útil asignar valores a objetos
x<-5
x
#Entonces, podríamos hacer cosas como ésta.
a<-20
b<-5
a+b
#El signo "^" representa al exponencial. También se puede usar "**"
a+b^2
a+b**2
# ---- EJERCICIO EXPRESS 1----
#1- ¿Qué sucede si cambiamos el valor de "a" por 45 y volvemos a realizar la última operación?
a<-45
b<-5
a+b^2
#¿es posible asignar el resultado a una nueva variable "c"? ¿Cómo lo harían?
c<-a+b^2
c

#---- FUNCIONES ----
3+3
sum(3,3)
#PARA SUMAR DECIMALES, LA NOTACIÓN EN INGLÉS ES CON PUNTOS, POR LO TANTO:
sum(4.5,2.3,4)
#R CONTIENE VARIADAS FUNCIONES MATEMÁTICAS
sqrt(4) #raíz cuadrada
round(9.556789) #aproximar
floor(9.556789) #truncar

#Las funciones tienen argumentos, y podemos consultarlos con la función args()
args(round)

round(9.556789, digits = 2)
#RESPETANDO EL ORDEN, TAMBIÉN SE PUEDE PONER..
round(9.556789, 2)

#Para obtener ayuda sobre una función lo hacemos de la siguiente forma:
?round
help(round) # help también es una función

#---- Vectores ----
#forma de almacenar datos que permite contener una serie de valores del mismo tipo.
#algunos ejemplos
nombres<-c("hans","claudia","sara","pablo")
a<-c(1,5,6,9:12)
b<-c(1,2,3,"gato")

#con la función length() se pueden contar los elementos de un vector
length(nombres)
length(a)
length(b)

#Existen 5 tipos de vectores en R:
  
character <- c("gato", "perro")
numeric <- c(8, 15.9) # reales o decimales
integer <-  c(2L, 4L) # L indica que son enteros
logical <- c(TRUE, FALSE, TRUE) 
complex <- 3 + 4i # complejos

#Podemos consultar cuál es el tipo de vector con class() o typeof()

class(a)
class(complex)
typeof(b)
typeof(logical)

#Que los vectores sean atómicos ⚛️ significa que sólo pueden contener un tipo de datos.
b<-c(1,2,3,"gato")
typeof(b)
b <- c(1, 2L, 3+4i, TRUE, "gato") #cambio de 2 vectores numéricos por 1 integer, otro complejo y otro lógico, para ver de qué tipo queda
typeof(b)

#---- Crear Vectores ----
x<-c(1,2,3,4,5)
#Una secuencia sencilla también podemos crearla de la siguiente manera.
y<-1:20
y

#Sin embargo, existen funciones más poderosas para crear vectores.
#¿Cómo crearían un vector que vaya del 1 al 5 y que avance en intervalos de 0.5?
a<-seq(from=1,to=5,by=0.5)
a
#¿Cómo crearían un vector que vaya del 1 al 10 y contenga 100 valores?
b<-seq(from=1,to=10,length=100)
b
#se puede dejar separado por 0.1 (arroja 92 valores)
b<-seq(from=1,to=10,by=0.1)
b
#Si uno aplica una operación a un vector, R aplica la operación a cada valor del vector
a<-seq(from=1,to=5,by=0.5)
a
a*2
a**2

#---- Operaciones matemáticas ----
#R ofrece los siguientes operadores matemáticos

x + y   # suma
x - y   # resta
x * y   # multiplicación
x / y   # división
x ^ y   # exponenciación
x %% y  # modulo división (resto) 10 %% 3 = 1 
x %/% y # división por enteros: 10 %/% 3 = 3

#módulo %% para programar
#marcar una secuencia de datos cada 3 valores
#tomando la variable "y"

y
y%%4
#0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3

#---- indexación ----
bandas_cl <- c("Los prisioneros", "Los Bunkers", 
               "Los Ángeles Negros")
bandas_arg <- c("Pescado rabioso", "Spinetta Jade", 
                "Virus", "Soda Stereo")
bandas <- c(bandas_cl, bandas_arg) # acá uno los dos vectores
bandas
bandas[5]

#Tenemos diferentes alternativas para indicar posición. Veamos ejemplos:
# primero creamos vectores
numeros <- 20:40 
nombres <- c("hans", "claudia", "sara", "pablo")
#Seleccionar con operador lógico
numeros[numeros>30]
#Seleccionar múltiplos de 5
numeros[numeros%%5==0]

#Seleccionar con un vector numérico
numeros[c(8,15,17)]

#Puedo seleccionar en desorden y R los pondrá en el orden que los pedí
numeros[c(8,18,21,3)]

#Seleccionar con selección negativa
nombres[-2]

#---- Ejercicio express 2 ----
#Crea un vector numérico del 1 al 30 y asígnalo a un objeto (ponle el nombre que quieras).
d<-seq(from=1,to=30, by=1)
d
#Selecciona el valor de la quinta posición.
d[5]
#Selecciona los valores mayores a 13.
d[d>13]
#Crea un segundo objeto a partir del primero que no contenga el último valor (30).
e<-d[-30]
e
#Crea un tercer vector que vaya del 0 al 30, pero que contenga solo los números pares.
f<-seq(from=0,to=30,by=2)
f

#---- Operadores lógicos ----

#R cuenta con operadores de comparación binaria.

x < y    # menor que
x > y    # mayor que
x <= y   # menor o igual que
x >= y   # mayor o igual que
x == y   # igual a 
x != y   # distinto a

#Algunos ejemplos con números:
  
x <- c(1,2,5)
y <- c(4,4,3)
x == y
#> [1] FALSE FALSE FALSE
x != y
#> [1] TRUE TRUE TRUE
x < y
#> [1]  TRUE  TRUE FALSE

#Ahora con caracteres:
  
a <- c("izzy", "jazz", "tyler")
b <- c("devon", "vanessa", "hilary")
a < b   # orden alfabético
#> [1] FALSE  TRUE FALSE

#También podemos modificar elementos específicos de un vector.
#primero creamos un vector
x<-1:10
x[5]<-0
x

#¿Qué creen que hace esta sentencia?
x <- 1:10
x[x > 5] <- x[x > 5] + 5
x

#---- Data Frames ----
curso <- data.frame(nombre = c("Klaus", "Juan", "Ignacio"),
                    notas = c(7, 7, 1))
curso


#---- Matrices ----
curso <- matrix(c("Klaus", "Juan", "Ignacio", 7, 7, 1),
                nrow = 3,
                ncol = 2)
colnames(curso) <- c("nombre", "nota")
curso

#---- Listas ----
a <- c(1,2,3,4,5)
b <- c("rojo", "verde")
c <-  data.frame(nom = "Klaus", "Juan",
                 nota = 7, 7)
lista1 <- list(a,b,c)
lista1

#---- Factores ----
ocupacion <- factor(x = c(1,2,3,1,2,1,3,4,1,5), 
                    labels = c("profesor", "musico", "doctora",
                               "taxista", "pescador"))
ocupacion


install.packages("guaguas")
library(guaguas)
#Primero carguemos la base en nuestro ambiente de trabajo.
data<-guaguas
guaguas
class(data)
is.data.frame(data)
dim(data)
str(data)
head(data)
names(data)

#También usando lenguaje base podemos pedir tablas de resumen.

#Para eso podemos utilizar la función table() y el operador "$", que vincula a una variable con un objeto.
table(data$anio)
table(data$nombre)

#También podemos pedir la proporción, aplicando prop.table() sobre table().
prop.table(table(data$sexo))

#Podemos seleccionar columnas por su posición.
data_2 <- data[,1]
dim(data_2)
data_2
data_2
data_3 <- data[,c(2:5)]
dim(data_3)
data_3

#También podemos seleccionar por nombre de columnas
data_4 <- data[,c("anio", "nombre", "n")]
names(data_4)
data_4

#Se pueden seleccionar filas de distintas maneras.
data_5 <- data[data$anio==2019,]
table(data_5$anio)
data_5
data_6 <- data[data$anio > 2010,]
table(data_6$anio)
data_6

library(tidyverse)
library(dplyr)


#Seleccionar filas y columnas
data_7<- data[data$anio>2010 & data$anio<2015, c("anio", "nombre", "n", "sexo")]

# ---- Ordenar Vectores y Data Frames

#Así podemos ordenar el data frame por anio.
arrange(data, anio)

#le podemos pedir que lo haga en forma descendente
arrange(data, desc(anio))

#Además puede ordenarse por más de una variable.
arrange(data, desc(anio, n))
