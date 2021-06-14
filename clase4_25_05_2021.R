# ---- Aplicación de mutatings joins ----

library(dplyr)
band_members
band_instruments

left_join(band_members, band_instruments, by = "name") 
# band_member --> tabla a mantener, que la una con band_instruments, y que utilice 
# como referencia la columna "name"

#con right_join() sucede...

right_join(band_members, band_instruments, by = "name")

#al usar inner_join() ...

inner_join(band_members, band_instruments, by = "name")

# y al usar full_join() ...

full_join(band_members, band_instruments, by = "name")

# Se puede hacer lo mismo con pipes.

# en el caso de left_join() ...

band_members %>% left_join(band_instruments, by = "name")

# Creación de objetos "songs" y "albums"

songs <- tibble(song = c("Come together", "Dream On", "Hello, Goodbye", "It's Not Unusual"),
                album = c("Abbey Road", "Aerosmith", "Magical Mystery Tour", "Along Came Jones"),
                first = c("John", "Steven", "Paul", "Tom"),
                last = c("Lennon", "Tyler", "McCartney", "Jones"))
albums <- tibble(album = c("A Hard Day's Night", "Magical Mystery Tour", "Beggar's Banquet", "Abbey Road", "Led Zeppelin IV", "The Dark Side of the Moon", "Aerosmith", "Rumours", "Hotel California"),
                 band = c("The Beatles", "The Beatles", "The Rolling Stones", "The Beatles", "Led Zeppelin", "Pink Floyd", "Aerosmith", "Fleetwood Mac", "Eagles"),
                 year = c(1964, 1967, 1968, 1969, 1971, 1973, 1973, 1977, 1982))

songs
albums

songs %>% inner_join(albums)

# Puedo restringir la cantidad de columnas que quiero unir de cualquiera de los dos 
# dataframes ...
songs [c(1,2)] %>% 
         inner_join(albums [-3], by = "album")

# también puede realizarse usando select ...
songs %>% 
  inner_join(albums) %>% 
  select(song, album, band)

# Ejercicio Express 1

# Creemos estas dos tibbles de artists y bands

artists <- tibble(first = c("Jimmy", "George", "Mick", "Tom", "Davy", 
                            "John", "Paul", "Jimmy", "Joe", "Elvis", "Keith",
                            "Paul", "Ringo", "Joe", "Brian", "Nancy"),
                  last = c("Buffett", "Harrison", "Jagger", "Jones", "Jones",
                           "Lennon", "McCartney", "Page", "Perry", "Presley", 
                           "Richards", "Simon", "Starr", "Walsh", "Wilson", "Wilson"),
                  instrument = c("Guitar", "Guitar", "Vocals", "Vocals", "Vocals", 
                                 "Guitar", "Bass", "Guitar", "Guitar", "Vocals",
                                 "Guitar", "Guitar", "Drums", "Guitar", "Vocals", "Vocals"))

bands <- tibble(first = c("John", "John Paul", "Jimmy", "Robert", "George", "John", 
                          "Paul", "Ringo", "Jimmy", "Mick", "Keith",  "Charlie", "Ronnie"),
                last = c("Bonham", "Jones", "Page", "Plant", "Harrison", "Lennon", "McCartney",
                         "Starr", "Buffett", "Jagger", "Richards", "Watts", "Wood"), 
                band = c("Led Zeppelin", "Led Zeppelin", "Led Zeppelin", "Led Zeppelin", 
                         "The Beatles", "The Beatles", "The Beatles", "The Beatles", 
                         "The Coral Reefers", "The Rolling Stones", "The Rolling Stones", 
                         "The Rolling Stones", "The Rolling Stones"))

# Generar una base de datos que contenga first (nombre), last (apellido), instrument y 
# la banda, para todos los artistas presentes en la base artist

# ¿Qué pueden observar sobre la base resultante?

artists %>% 
  left_join(bands)  
  
# o

artists %>% 
  left_join(bands, by = "first", "last") #En este caso da lo mismo, porque R asume como columnas llave a "first" y "last"

# ¿Qué pasa si las columnas tienen distinto nombre?

bands_2 <- tibble(nombre = c("John", "John Paul", "Jimmy", "Robert", "George", "John", 
                          "Paul", "Ringo", "Jimmy", "Mick", "Keith",  "Charlie", "Ronnie"),
                apellido = c("Bonham", "Jones", "Page", "Plant", "Harrison", "Lennon", "McCartney",
                         "Starr", "Buffett", "Jagger", "Richards", "Watts", "Wood"), 
                band = c("Led Zeppelin", "Led Zeppelin", "Led Zeppelin", "Led Zeppelin", 
                         "The Beatles", "The Beatles", "The Beatles", "The Beatles", 
                         "The Coral Reefers", "The Rolling Stones", "The Rolling Stones", 
                         "The Rolling Stones", "The Rolling Stones"))

# La programación debe necesariamente incluir el by

artists %>% 
  left_join(bands_2, by = c("first"="nombre", "last"="apellido"))

# Generar una base de datos, a partir de artists y bands, que contenga first (nombre), 
# last (apellido), instrument y la banda, que incluye sólo a los artistas que tienen 
# información en las 4 variables

artists %>% 
  inner_join(bands)

# ¿Cuántas observaciones tiene la base creada? respuesta --> 8 observaciones

#bin_cols y bind_rows
artists_2 = artists # duplicamos este data frame sólo con un fin pedagógico
ensamble <- bind_rows(original = artists, duplic = artists_2, .id = "base_datos")

print(ensamble)
View(ensamble)

# ---- Variables con tiempo en R ----

mi_cumple <- ("1974-10-12")
str(mi_cumple)

# Darle formato de fecha

mi_cumple <- as.Date(mi_cumple)
str(mi_cumple)

as.numeric(mi_cumple)
# [1] 1745 ¿Qué representa ese número?

as.numeric(as.Date("1970-01-01"))
# [1] 0

# Es la distancia desde un momento escogido de manera arbitraria: el 1 de enero de 1970.

install.packages("anytime")
library(anytime)

mi_cumple <- as.Date(anydate("12-10-1974")); str(mi_cumple)

# R base tiene funciones para extraer la fecha y hora en el momento de la consulta

Sys.Date() # La fecha de hoy

Sys.time() # el momento exacto, con fecha, horas, minutos y segundos

## [1] "2021-06-03 11:08:17 -04". El -04 refiere a la diferencia con GMT. Greenwich Mean 
# Time

library(lubridate)

today() # La fecha de hoy
## [1] "2021-05-26"

now() # el momento exacto, con fecha, horas, minutos y segundos
## [1] "2021-05-26 01:35:08 -04"

# ---- Manejo de fechas con lubridate ----

ymd("1974-10-12")

mdy("Oct 12, 1974")

dmy("12/oct/1974")

ymd(19741012)

dmy(12101974)

# ---- 2. Creación desde componentes date-time individuales ----

# A veces las fechas nos llegan en un data frame separadas en día, mes, año.

# Debemos unirlas para operarlas como objetos date. Usaremos la base de nacimientos de EEVV 2017.

# Para crear un objeto date que llamaremos fecha_nac usamos la función make_date() de lubridate.

# cargamos la base
library(tidyverse)
library(readxl)
library(lubridate)

nac2017 <- read_excel("C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/S4_nac_2017.xlsx")

View(nac2017)

# seleccionamos día, mes, año de nacimiento y creamos una fecha
nac2017 %>% 
  select(dia_nac, mes_nac, ano_nac) %>% 
  mutate(fecha_nac = make_date(ano_nac, mes_nac, dia_nac)) %>% 
  head(5)

# Ejercicio express 2

# Utilizando la base de datos "nac2017" que acabamos de cargar en nuestro entorno de 
# trabajo.

# 1- Generar dentro de la base de datos (en la misma o un objeto nuevo) una variable 
# llamada "fecha_nac" que contenga en un solo campo la fecha de nacimiento completa de 
# cada nacido.

# 2- Generar además una variable llamada "fecha_ins" que contenga en un solo campo la fecha 
# de inscripción completa de cada nacido.

nac2017 %>% 
  select(dia_nac, mes_nac, ano_nac, dia_ins, mes_ins, ano_ins) %>% 
  mutate(fecha_nac = make_date(ano_nac, mes_nac, dia_nac),
         fecha_ins = make_date(ano_ins, mes_ins, dia_ins)) %>% 
  head(5)

mi_cumple <- dmy("12-10-1974")
year(mi_cumple)

month(mi_cumple, label=T) # con label se pide la etiqueta

mday(mi_cumple)

wday(mi_cumple)

# ---- Operaciones aritméticas con fechas ----

# Por ejemplo, pueden saber cuántos días de vida tienen.

today() - ymd("1974-10-12")

# Existe un set de funciones que sirven para operar sobre periodos de tiempo de una manera intuitiva y versatil: se llaman periods y algunos da ellos son:
  
# days(1)
# weeks(1)
# months(1) # esta función es de R base
# years(1)

# ¿Qué podemos hacer con ellos?
  
  # ¿que fecha es en un año y un mes más?
  
today() + years(1) + months(1)

## [1] "2022-07-03"

# Podemos, por ejemplo, crear una variable deadline que indique cuándo es un mes después de un punto inicial.

inicio <- as.Date("2020-08-30")
inicio + months(1)

## [1] "2020-09-30"

# Pero no es una función tan robusta. ¿Qué pasa con los meses de 31 días?
  
inicio <- ymd("2020-08-31") # esta otra función es parecida a as.Date
inicio + months(1)

## [1] NA

# No sabe qué hacer y entrega un NA. Pero lubridate() contiene operadores robustos para solucionarlo.

inicio %m+% months(1)

## [1] "2020-09-30"

# %m+% también funciona con años y días. También existe %m-% para restar periodos.

bisiesto <- ymd("2020-02-29")
bisiesto %m+% years(1)

## [1] "2021-02-28"

bisiesto %m+% days(1)

## [1] "2020-03-01"

# Además se pueden generar automáticamente varios periodos. Esto puede ser muy útil para 
# validar datos

inicio <- ymd("2020-08-31")
inicio %m+% months(1:6)

## [1] "2020-09-30" "2020-10-31" "2020-11-30" "2020-12-31" "2021-01-31"
## [6] "2021-02-28"

# Tambien podemos calcular intervalos de tiempo entre dos momentos de manera consistente.

# Para eso utilizamos el operador %--%.

siguiente_año <- today() + years(1)
(today() %--% siguiente_año) / days(1) # diferencia en días

## [1] 365

# Para encontrar cuántos períodos caen dentro de un intervalo, con %/% pueden obtener la 
# división entera:
  
(today() %--% siguiente_año) / weeks(1)

## [1] 52.14286

# Ahora con %/%.

(today() %--% siguiente_año) %/% weeks(1)

## [1] 52

# Ejercicio express 3

# Vamos a utilizar la base de datos donde creamos "fecha_nac" y "fecha_ins".

# La variable "fecha_nac" refiere a la fecha de nacimiento de un nacido durante el año 
# estadístico 2017 y "fecha_ins" indica la fecha en que el nacido fue inscrito.

nac2017_EE3 <- nac2017 %>% 
  select(dia_nac, mes_nac, ano_nac, dia_ins, mes_ins, ano_ins) %>% 
  mutate(fecha_nac = make_date(ano_nac, mes_nac, dia_nac),
         fecha_ins = make_date(ano_ins, mes_ins, dia_ins))

nac2017_EE3_1_2 <- nac2017_EE3 %>% 
  mutate(dif_days = (fecha_nac %--% fecha_ins) / days(1),# 1- Genera una variable llamada 
         # "dif_days" que indique la diferencia en días entre que los nacidos nacieron y 
         #fueron inscritos. 
         dif_weeks = (fecha_nac %--% fecha_ins) %/% weeks(1)) # 2- Genera una variable 
         #llamada "dif_weeks" que indique la diferencia en semanas enteras (sin decimales) 
         #entre que los nacidos nacieron y fueron inscritos.

nac2017_EE3_3 <- nac2017_EE3_1_2 %>% 
    summarise(media_dif = mean(dif_days), mediana_dif = median(dif_days), 
              minima_dif = min(dif_days),maxima_dif = max(dif_days))

nac2017_EE3_3 # 3- Escoje una de las dos variables creadas y genera una tabla de 
# resumen que contenga la mínima diferencia, la máxima, diferencia media y la mediana.

nac2017_EE3_1_2



