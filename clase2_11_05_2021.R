# ---- Importación de datos ----
# R tiene distintos paquetes para importar datos, diferenciando la extensión de 
# los archivos.

# Estos archivos pueden ser asignados a un objeto.

#En esta sesión veremos como importar:
  
#- Archivos de STATA (.dta), de SAS (.sas7bdat) y de SPSS (.sav).
#- Archivos de texto plano delimitados (.csv).
#- Archivos de excel (.xlsx, .xls).

#Para importar archivos guardados desde STATA, SAS o SPSS, existe el paquete `haven`

#El paquete haven forma parte del universo de tidyverse

library(tidyverse)
library(haven)
# El archivo se puede cargar desde una carpeta...
# esi <- read_dta(file = "C:/Users/usuario/Desktop/esi-2019---personas.dta")

# ...o desde un sitio web
# esi <- read_sav(file = "http://www.ine.cl/docs/default-source/encuesta-suplementaria-de-ingresos/bbdd/spss_esi/2019/esi-2019---personas.sav")

esi<-read_sav(file="https://www.ine.cl/docs/default-source/encuesta-suplementaria-de-ingresos/bbdd/spss_esi/2019/esi-2019---personas.sav?sfvrsn=21b83737_4&download=true")

esi_hog_sb <- read_dta(file="https://www.ine.cl/docs/default-source/encuesta-suplementaria-de-ingresos/bbdd/stata_esi/2019/esi-2019---hogares-sin-becas.dta?sfvrsn=c08ba058_4&download=true")

ene <- read_sav(file="C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/ene-2021-02-efm.sav")

# Las funciones incluídas consideran un lenguaje bastante explícito:
  
#STATA: read_dta() permite importar archivos con extensión ".dta".

#SPSS: read_sav() permite importar archivos con extensión ".sav".

#SAS: read_sas() permite importar archivos con extensión ".sas7bdat".

#El argumento "file" en estas funciones indica la ruta y el nombre del archivo a importar a R.

#La dirección del archivo debe utilizar forward-slash ("/") en vez de backslash ("\"). Otra opción es utilizar un doble backslash ("\")

#Si queremos trabajar con más de un archivo, y cada uno de ellos se encuentra en la misma carpeta de nuestra computador, ¿es posible establecer un "atajo" al momento de importar los archivos?
  
#Directorio de trabajo
#El directorio o carpeta de trabajo es el lugar en nuestro computador donde R buscará archivos para importarlos.

#Para identificar cuál es la ruta del directorio que está usando R se debe utilizar la función getwd().

getwd()
## [1] "C:/Users/klehm/OneDrive - Instituto Nacional de Estadisticas/capacitacion/capacitacion_monitores/sesion_2"

#Es posible cambiar el directorio de trabajo usando la función setwd().

setwd("C:/Users/elgra/Desktop")

#Volvamos a la importación de datos...

# ---- Importación de archivos de texto plano delimitados ----
#Si el archivo que queremos importar corresponde a un archivo de texto plano delimitado, el universo de tidyverse cuenta con el paquete readr.

#Entre las funciones de readr se encuentran:
  
#read_csv(): se utiliza para importar archivos delimitados por coma.

#read_csv2(): se utiliza para importar archivos delimitados por punto y coma. Este tipo de delimitación se utiliza cuando la coma se utiliza para separar números decimales.

#read_delim(): se utiliza para importar archivos planos con cualquier delimitador. Al usar esta función es necesario definir el argumento delim, para identificar el tipo de delimitador.

#Todas estas funciones tienen una sintaxis similar.

library(readr)

esi <- read_csv2(file = "C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/esi-2019---personas.csv")

#Estas funciones emplean la primera fila de los datos para los nombres de las columnas.

#En caso de que los datos no incluyan los nombres, se puede agregar el argumento col_names = FALSE, y la función entenderá que se deberán crear nombres ficticios, etiquetados secuencialmente desde X1 a Xn.

# ---- Importación de archivos de Excel ----
#El paquete readxl nos permite importar archivos de Excel.

#Una de sus funciones es read_excel().

#Se debe definir donde se encuentra el archivo con el parámetro path

#Los libros de Excel pueden tener más de una hoja; el argumento sheet se utiliza para definir la hoja que se importará.

library(readxl)
esi <- read_excel(path = "data/esi-2019---personas.xlsx",
                  sheet = "Hoja1")

Energia_gen <- read_excel(path = "C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/Base_Energia.xlsx",
                  sheet = "Generacion")

# ---- Importación de archivos de R ----
#Los archivos de R poseen la extensión ".RData".

#La función load() se utiliza para cargar el archivo.

#No es necesario cargar librerías para poder utilizar la función.

#No se debe asignar el valor al objeto a cargar.

#Importante: estos archivos pueden incluir más de un objeto.

load(file = "data/esi-2019---personas.RData")

#La desventaja de load es que no tenemos la posibilidad de nombrar el objeto

#Se cargará en el ambiente con el nombre con el que fue guardado el archivo

# ---- Importación feather ----

#Wes McKinney y Hadley Wickham implementaron formato feather

#Funciona para python y R

#Es muy liviano

#Tarda muy poco en leer (read) y escribir (write)

#Nos permite nombrar el objeto que estamos cargando en el ambiente

library(feather)
ene <-  read_feather("data/ene-2019-11.feather")

#Es muy recomendable trabajar con el formato feather

# ---- Un pequeño ejercicio... ----

#Cargue el archivo "ene-2019-11.csv" (se utiliza "," para separar los valores)

#Asigne al objeto "ene" el archivo cargado.

#Identifique la clase del objeto "ene".

#Identifique las dimensiones del objeto "ene".

library(readr)
ene <- read_csv(file = "C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/ene-2019-11.csv")
class(ene)
## [1] "data.frame"
dim(ene)
## [1] 96240   144

# ---- Transformación de datos ----

# ---- El paquete dplyr ----

#Para la manipulación de los data frames existe un paquete llamado dplyr.

#Durante esta sesión veremos algunas funciones del paquete dplyr, que se utilizan para la manipulación de data frames.

# ---- Manipulación básica de columnas ----

#select(): selecciona y devuelve un conjunto de columnas.

#rename(): renombra variables en un data frame.

# ---- Manipulación básica de filas ----

#arrange(): reordena filas de un data frame.

#filter(): selecciona y devuelve un conjunto de filas según una o varias condiciones lógicas.

# ---- Herramientas básicas de edición de datos ----

#if_else(): evaluación de condiciones, y asignación de valores.

#mutate(): añade nuevas variables o transforma variables existentes.

#Todas estas funciones tienen en común una serie de argumentos:
  
#El primer argumento es el data frame a manipular.

# Los otros argumentos describen qué hacer con el data frame especificado en el primer argumento.

# El valor de retorno de la función es un nuevo data frame.

# Estas funciones serán algunas de nuestras mejores compañeras y siempre nos acompañarán en nuestro camino de programación.

# Como veremos en esta sesión, una de las principales ventajas de estas funciones es que podemos referirnos a las columnas en el data frame directamente, sin utilizar el operador "$", es decir, solo con el nombre de la variable.

# Se trabajará con un archivo distinto al ene-2019-11.csv, el cual será reemplazado por el archivo ene-2019-11.sav


ene<-read_sav(file="C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/ene-2019-11.sav")

# ---- Función select() ----

# Esta función es utilizada para seleccionar columnas dentro de un data frame.

# El resultado de esta función corresponde a un data frame que solo incluye las variables seleccionadas.

# El orden de las variables corresponde al orden seleccionado.

# Existen múltiples formas de seleccionar las columnas utilizando esta función.

# ---- Selección de las columnas a través del nombre de los campos. ----

library(dplyr)
head(select(ene, ano_encuesta, mes_encuesta, cae_especifico, b1, b14_rev4cl_caenes),
     n = 3) # el argumento n corresponde a la función "head"


# Selección de las columnas a través de la posición que ocupan en el data frame.
head(select(ene, 1, 2, 3, 4, 5),
     n = 3)

# ---- Selección de las columnas a través de rangos.----

# Estos rangos se pueden definir a través de los nombres de campos o de las posiciones.

head(select(ene, c(idrph:mes_central)), n = 3)

# ----Selección negativa utilizando el signo "-" antes de la variable. ----

# Consiste en seleccionar las variables que no queremos en la base final.

head(select(ene, -c(4:length(ene))), n = 3)
##     idrph ano_trimestre mes_central
## 1  808409          2019          11
## 2  808410          2019          11
## 3 1100843          2019          11

# A continuación un resumen de las principales funciones auxiliares que se pueden utilizar con select():
  
# "-": se utiliza para identificar los campos a excluir de la selección.

# ":": se utiliza para definir un rango.

# contains(): selecciona variables cuyo nombre contiene la cadena de texto definida.

# ends_with(): selecciona variables cuyo nombre termina con la cadena de texto definida,

# start_with(): selecciona variables cuyo nombre comienza con la cadena de texto definida,

# matches(): selecciona las variables cuyos nombres coinciden con una expresión regular.

# Ejemplo de uso de starts_with

head(select(ene, starts_with("id")), n=3)

# ---- Dos pequeños ejercicios... ----

# Seleccione las variables idrph, edad, sexo, cine.

head(select(ene, idrph, edad, sexo, cine), n = 3)

# Seleccione la variable idrph y las variables que terminen en "caenes"

head(select(ene, idrph, ends_with("caenes")), n = 3)

# ---- Función rename() ----

# Si necesitamos renombrar una variable (columna) de un data frame, existen múltiples formas y varias muy complejas.

# La función rename() permite editar el nombre de una variable de una manera sencilla, y sin afectar al resto de variables.

# Esta función permite renombrar más de una variable a la vez.

# si queremos obtener el nombre de las variables de un data frame, se utiliza la función names()

names(ene)

# A continuación se mostrarán dos formas de renombrar variables...

ene_5 <- select(ene, idrph, edad, sexo, cine)
names(ene_5)

# a través del lenguaje base 

names(ene_5)[names(ene_5) == "sexo"] <- "sex"
names(ene_5)

# ...a través de rename()

names(rename(ene_5, identificador = idrph, niveleducacional = cine))
## [1] "identificador"    "edad"             "sex"              "niveleducacional"

# Si queremos obtener el nombre de las variables de un data frame, se utiliza la función names()

# ---- Uso de pipes (%>%) ----

# Como hemos visto hasta ahora, estas funciones siguen la misma estructura:
  
# - Primer argumento: data frame sobre el que se aplica la función.
# - Resto de argumentos: elementos del data frame sobre los cuales actua la función.

# Lo anterior nos puede hacer pensar: ¿es posible encadenar estas funciones?.

# Sí...sí se puede, utilizando el operador %>% (llamado pipe).

# El operador %>% nos permite tomar el resultado de una función y mandarlo directamente a la siguiente función, concatenando acciones.

# Se puede leer como "luego" o "a continuación".

# Este operador nos ayudará enormemente a mejor la legibilidad de un código.

# El atajo en Windows para escribir pipes es: ctrl + shift + m.

# Para utilizar los pipes, es necesario seguir la siguiente estructura:
  
  df %>% # data frame sobre el que se ejecutará la función
  funcion() %>% # esta función se aplica sobre el data frame "df"
  funcion() # esta función se aplica sobre el resultado de la función anterior

# Utilizando pipes, el resultado del ejercicio de renombrar es posible escribirlo de la siguiente manera:
  
  ene_6 <- ene %>%
  select(idrph, edad, sexo, cine) %>%
  rename(identificador = idrph, niveleducacion = cine)
names(ene_6)

## [1] "identificador"  "edad"           "sexo"           "niveleducacion"

# ---- Función filter() ----

# Al aplicar esta función, los resultados que quedarán en el dataframe resultante serán solo aquellos en los que se cumpla la condición definida. Por ejemplo...

# ...el número de filas del data frame "ene" es:
  
  dim(ene)

## [1] 96240   144

# ...mientras que el número de filas del data frame "ene" que corresponde al mes de encuestaje de diciembre es:
  
  dim(ene %>% filter(mes_encuesta == 12))

  ## [1] 34402   144
  
  # Las condiciones para filtrar un data frame pueden ser construidas mediante operadores relacionales.
  
  # A continuación se presenta un listado de operadores relacionales:
    
  # "<": menor que
  # ">": mayor que
  # "==": igual que
  # "<=": menor o igual que
  # ">=": mayor o igual que
  # "!=": diferente que
  # "%in%": pertenece al conjunto
  # "is.na": es NA
  # "!is.na": no es NA
  
  # ¿Es posible filtrar un data frame por más de una condición al mismo tiempo?
    
  # Sí, es posible utilizando operadores lógicos.
  
  # Estos operadores se utilizan para analizar el valor de verdad de dos sentencias.
  
  # Algunos operadores lógicos o booleanos son:
    
  # "&": conjunción y
  # "|": conjunción o
  # "!": operador no
  # "any": al menos una sentencia es verdadera
  # "all": todas las sentencias son verdaderas
  
  # Algunos ejemplos...
  
  # Obtener el número de filas de registros con edad mayor a 50 y cuyo grupo ocupacional corresponde a profesionales científicos e intelectuales (b1 == 2).
  dim(ene %>% filter(edad > 50 & b1 == 2))
  
  
  # Obtener el número de filas de registros que cumplan al menos una de las dos relaciones siguiente:
    
  # Mujeres (sexo == 2) de la región 6.
  # Hombres (sexo == 1) de la región 12.
  
  dim(ene %>% filter(sexo == 2 & region == 6 | sexo == 1 & region == 12))
  
# ---- Función arrange() ----
  
# Esta función se utiliza para reordenar las filas de un data frame.
  
 # El orden se puede realizar según una o más variables.
  
 # El reordenamiento se realiza según el orden de las columnas seleccionadas.
  
 # Por defecto, el orden es ascendente.
  
 # Para ordenar de manera descendente se debe utilizar la función auxiliar desc().
  
  library(guaguas)
  head(guaguas %>% arrange(desc(n)), n = 3)
  
  # ---- Algunos ejercicios sobre lo visto hasta ahora en clases... ----
  
  # Utilizando la base de guaguas, filtre según su año de nacimiento, su sexo de nacimiento, y luego ordene el resultado por la variable "n", de forma descendente.
  
  # Utilice la función "head", con el argumento "n == 5", e identifique cuantos nombres de los 5 más repetidos comienzan con la letra "J".
  
  library(guaguas)
  head(guaguas %>%
         filter(sexo == "M", anio == 1974) %>% # Hombres nacidos en 1974
         arrange(desc(n)), n = 5)
  
  # ---- Función mutate() ----
  
  # Esta función tiene la finalidad de realizar transformaciones sobre los valores de un data frame.
  
  # Algunas de las transformaciones posibles son:
    
  # Cambiar el formato de una variable.
  
  # Por ejemplo: modificar el formato de la variable "idrph" a character.
  
  class(ene$idrph)
  
  ene <- ene %>% mutate(idrph = as.character(idrph))
  class(ene$idrph)
  
  #Modificar el valor de alguna variable.
  
  # Esta función también nos permite crear nuevas variables en un data frame.
  
  # Con esta función se pueden combinar funciones básicas para realizar operaciones sobre las variables.
  
  # Con mutate() podemos editar y/o crear más de una variable. Es necesario separar las instrucciones entre variables con una coma.
  
  # Al trabajar sobre más de una variable, la función primero trabajará sobre la primera instrucción previa a la primera coma que separe las instrucciones, luego, avanzará sobre la siguiente.
  
  # Ejemplo
  
  df <- data.frame(x = c(1, 2),
                   y = c(5, 5))
  print(df)
  
  df <- df %>%
    mutate(y = 10,
           z = x*y)
  print(df)
  
  # Como pudimos ver, las variables creadas son agregadas al final del data frame.
  
  # ¿Es posible definir la posición donde serán agregadas?
    
  # Sí, agregando el argumento ".before" o el argumento ".after".
  
  df <- df %>% mutate(w = "ejemplo", .before = x)
  print(df)
  
  # El paquete dplyr también cuenta con la función relocate() que nos permite ordenar algunas columnas dentro de un data frame.
  
  df %>% relocate(c(w, z), .after = x)
  ##   x       w  z  y
  ## 1 1 ejemplo 10 10
  ## 2 2 ejemplo 20 10
  
 # Hasta ahora hemos visto como crear variables donde todas las filas cumplan las mismas condiciones, pero no siempre es así. ¿Cómo podemos trabajar cuando la creación de una variable depende del valor de otra?
    
 #   Por ejemplo:
    
 #   - Si la variable sexo es igual a 1, asigne tal valor, en cambio, si la 
 # variable sexo es igual a 2, asigne otro valor.
 
# - Si la variable región es igual a 1, 15, 2, la variable zona tendrá el 
# valor "norte", en cambio si la variable es igual a 12, la variable zona 
# tendrá el valor "sur".

  #  Esto se puede realizar utilizando una función llamada if_else(), cuyo objetivo es evaluar el valor de verdad de una sentencia, y luego entregar un resultado según ese valor. 
  # Esta función se puede utilizar junto a la función mutate().
  
  # La función if_else() trabaja con los siguientes argumentos:
    
  # condition: corresponde a la sentencia a evaluar.
  
  # true: indica el valor a asignar si la sentencia es verdadera.
  
  # false: indica el valor a asignar si la sentencia es falsa.
  
  # missing: indica el valor a asignar si la sentencia es missing.
  
  # La función if_else() actúa sobre cada fila, y otorga un valor distinto a cada celda dependiendo del valor de verdad por fila.
  
  # Ejemplo: recodificar la categoría 10 de la variable b1 y asignarle el valor 0.
  
  ene <- ene %>% mutate(b1 = if_else(b1 == 10, 0, as.numeric(b1),99))
  table(ene$b1)
  
  # Para ver los valores missing...
  
  ene <- ene %>% mutate(b1 = if_else(b1 == 10, 0, as.numeric(b1)))
  table(ene$b1)
  
  # Entre las funciones básicas de R, existe la función ifelse(), la cual es menos estricta que if_else(), pero no tiene un tratamiento especial para los missings.
  
  # La función ifelse() base solo trabaja con tres argumentos: "test", "yes" y "no".
  
  df2 <- data.frame(x = c(1, 2, NA))
  df2 %>% mutate(y = if_else(condition = (x == 1), true = "valido", 
                             false = "no valido", missing = "missing"))
  
  df2 %>% mutate(y = ifelse(test = (x == 1), yes = "valido", no = "no valido"))
  
 # Algunas funciones importantes que se pueden utilizar en conjunto con mutate() son:
    
 # La función sum(): utilizada para sumar los valores de una variable (suma de la columna).
  
 # La función row_number(): utilizada para asignarle un valor a cada fila igual a la posición que ocupan en el data frame.
  
 # La función mean(): utilizada para obtener la media de una columna.
  
 # La función max(): utilizada para obtener el valor máximo de una variable.
  
 # La función paste(): utilizada para concatenar variables y/o strings.
  
 # La función gsub(): utilizada para reemplazar el valor de texto dentro de una variable.
  
 # La función nchar(): utilizada para contar el número de caracter de una variable.
  
 # A continuación, un ejemplo...
  
  df4 <- data.frame(x1 = c(1, 2, 3, 4, NA),
                    x2 = c(5, 13, -2, 1, 5),
                    x3 = c("y_1", "y_2", "y_3", "y_4", "y_5"))
  df4 %>% mutate(
    total = sum(x1),
    total_x1 = sum(x1, na.rm = T), # con na.rm no se consideran los missing
    media_x2 = mean(x2),
    n_fila = row_number(),
    x3_v2 = gsub("y", "v", x3),
    x2_lag=lag(x2))
  
   # ---- Ejercicio final ----
  
  # Cree el data frame df3...
  
  df3 <- data.frame(x = c(1, 2, NA, 5),
                    y = c(2, 4, 0, 15))
  df3
  # Luego...
  
  # Edite la variable "x", de forma tal que el valor missing tome el valor 0.
  
  df3 <- df3 %>% 
    mutate(x=if_else(is.na(x),0,x))
  df3
  
  # Genere la variable "division", que sea igual a la división entre "y" y "x".
  
  df3 <- df3 %>%
    mutate(division=y/x)
  df3
  
  # Filtre los casos donde division sea distinto de 2.
  
  df3 %>%
    mutate(x = if_else(is.na(x), 0, x),
           division = y / x) %>%
    filter(division != 2)
  
  