# Tarea final del curso

# Ejercicios:
# 1.- Carga los archivos nacimientos_2017.feather y proyecciones.feather (1 punto).

library(tidyverse)
library(readr)
install.packages("feather")
library(feather)

nacimientos_017 <-  read_feather("C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/nacimientos_2017.feather")

proyecciones <-  read_feather("C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/proyecciones.feather")

# 2.- Crea la fecha de inscripción (fecha_ins) a partir de las variables dia_ins, 
# mes_ins y ano_ins,
# y fecha de nacimiento (fecha_nac) a partir de las variables ano_nac, mes_nac y 
# dia_nac.

library(lubridate)
library(dplyr)

nacs_017 <- nacimientos_017 %>% 
  mutate(fecha_ins = make_date(ano_ins, mes_ins, dia_ins),
         fecha_nac = make_date(ano_nac, mes_nac, dia_nac))
 
# Calcula la diferencia, medida en días, entre la fecha de inscripción (fecha_ins) 
# y la fecha de nacimiento (fecha_nac) en una nueva variable llamada fecha_diff (3 puntos).

difdias <- nacs_017 %>% 
  mutate(fecha_diff = (fecha_nac %--% fecha_ins) / days(1))

# 3.- Crea la variable “tramo_edad_madre”, a partir de la variable edad_m (3 puntos):
  
# Menores de 15 años
# 15 a 19 años
# 20 a 24 años
# 25 a 29 años
# 30 a 34 años
# 35 a 39 años
# 40 a 44 años
# 45 a 49 años
# 50 años y más (no incluir 99)
# No especificado (edad_m == 99)

TEM <- nacimientos_017 %>%
  mutate(tramo_edad_madre = case_when(edad_m >= 0 & edad_m < 15   ~ "Menores de 15 años",
                                      edad_m >= 15 & edad_m <= 19 ~ "15 a 19 años",
                                      edad_m >= 20 & edad_m <= 24 ~ "20 a 24 años", 
                                      edad_m >= 25 & edad_m <= 29 ~ "25 a 29 años",
                                      edad_m >= 30 & edad_m <= 34 ~ "30 a 34 años",
                                      edad_m >= 35 & edad_m <= 39 ~ "35 a 39 años",
                                      edad_m >= 40 & edad_m <= 44 ~ "40 a 44 años",
                                      edad_m >= 45 & edad_m <= 49 ~ "45 a 49 años",
                                      edad_m >= 50 & edad_m != 99 ~ "50 años y más",                              
                                      edad_m == 99                ~ "No especificado",)
  )

table(TEM$tramo_edad_madre)

# 4.- A partir de la tabla de nacimientos, calcula el número de nacimientos por 
# comuna, guárdalo en un objeto llamado nac_comuna e imprime las primeras 10 filas 
# (2 puntos).

nac_comuna <- nacimientos_017 %>%
  group_by(comuna) %>%
  summarise(n = n()) %>% 
  slice(1:10)

# 5.- A partir de la tabla de proyecciones, calcula el total de la variable 
# poblacion_2017 por comuna, guárdalo en un objeto llamado proy_2017 e imprime 
# las primeras 10 filas (2 puntos).

pob_2017 <- proyecciones %>%
  group_by(comuna) %>%
  summarise(suma = sum(poblacion_2017)) %>% 
  slice(1:10)

# 6.- Une las tablas nac_comuna y proy_2017, calcula la tasa bruta de natalidad 
# (por 1.000 habitantes) por comuna 
# \(\frac{NacimientosEn La Comuna}{Proyección De Población En La Comuna}*1000\) 
# e imprime las primeras 10 filas del resultado (4 puntos).
# Nota: La tasa bruta de natalidad no necesariamente deberá coincidir con la 
# publicada, pues el dato publicado se calcula con nacidos vivos corregidos, de 
# acuerdo con el método: “Estimación del registro tardío de nacimientos”.

ij_nac_comuna <- nac_comuna%>% 
  inner_join(pob_2017) 

ij_nac_comuna %>% 
  mutate(tasa_natalidad = (ij_nac_comuna$n / ij_nac_comuna$suma) *1000) %>% 
  slice(1:10)

# 7.- A partir de la tabla de nacimientos, calcula el número de nacimientos por 
# tramo_edad_madre (la variable que ya creaste) e imprime la tabla resultante 
# (3 puntos).

nac_TEM <- TEM %>%
  group_by(tramo_edad_madre) %>%
  summarise(n = n()) 
  
# 8.- Genera un gráfico boxplot que muestre la edad (eje y) y el grupo ocupacional 
# (eje x) de los padres. El gráfico debe mostrar la situación de los hombres y de 
# las mujeres por separado. Para este ejercicio deberías utilizar las siguientes 
# variables (5 puntos):
  
# ocupa_p: grupo ocupacional del padre
# ocupa_m: grupo ocupacional de la madre
# edad_p: edad del padre
# edad_m: edad de la madre
# sexo_p: sexo del padre
# sexo_m: sexo de la madre
# Considera que los valores “X” y “99” corresponden a datos perdidos y que los 
# casos activ_p = 1 y activ_m = 1 corresponden a las personas ocupadas.

nacimientos_017 %>% 
  ggplot(aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point() +
  scale_size(range = c(1, 7)) 
  
library(ggplot2)
library(patchwork)
hombre <- ggplot(nacimientos_017) + geom_boxplot(aes(ocupa_p, edad_p, group = ocupa_p, fill = ocupa_p))
mujer <-  ggplot(nacimientos_017) + geom_boxplot(aes(ocupa_m, edad_m, group = ocupa_m, fill = ocupa_m))
hombre + mujer


nac_simp <- nacimientos_017 %>% 
  select(sexo, ocupa_p, ocupa_m, edad_p, edad_m)


