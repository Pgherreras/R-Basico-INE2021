# Un ejemplo de uso de pipes, utilizando el siguiente dataframe...

df <- data.frame(x1 = c(1, 2, 3, 4),
                 x2 = c("perro", "gato", "caballo", "conejo"))
print(df[1:2, ])

library(tidyverse)
library(dplyr)
library(haven)

df %>%
  #... crear una columna con el número de caracteres que tiene x2  
  mutate(n = nchar(x2)) %>% # nchar(), función utilizada para contar caracteres
  #...filtrar aquellos registros con más de 5 caracteres
  filter(n > 5) %>%
  #...luego ordenar de manera descendente, según el número de caracteres
  arrange(desc(n))

# Ejemplo: if_else consecutivos

ene<-read_sav(file="C:/Users/Patricio/Desktop/Proyectos RStudio/R Básico INE 2021/R Básico INE 2021/Datos/ene-2019-11.sav")

ene <- ene %>%
  mutate(
    tramos_etarios = if_else(edad < 15,
                             "menores a 15",
                             ""),
    tramos_etarios = if_else(edad >= 15 & edad <= 30,
                             "entre 15 y 30 años",
                             tramos_etarios),
    tramos_etarios = if_else(edad > 30,
                             "mayores de 30 años",
                             tramos_etarios)
  )
table(ene$tramos_etarios, useNA = "always")

# Ejemplo: método 2
ene <- ene %>%
  mutate(tramos_etarios3 = case_when(edad < 15               ~ "menores a 15",
                                     edad >= 15 & edad <= 30 ~ "entre 15 y 30 años",
                                     edad > 30               ~ "mayores de 30 años",
                                     TRUE                    ~ "fuera de rango")
  )

table(ene$tramos_etarios3, useNA = "always")

# Pequeño Ejercicio

ene <- ene %>%
  mutate(tramos1 = case_when(edad >= 0 & edad < 15  ~ 1,
                             edad >= 15 & edad < 30 ~ 2,
                             edad >= 30 & edad < 60 ~ 3,
                             edad >= 60             ~ 4,                                   
                             TRUE                   ~ 999)
  )

table(ene$tramos1, useNA = "always")

# Cálculo de la edad media de las mujeres base de datos ene-2019-11.sav

ene_mujeres <- ene %>% 
  filter(sexo==2) %>% 
  mutate(media=mean(edad))
ene$media

#resultado arrojado: media de la columna, igual valor para todo.

#aplicando group by...

ene_agrup <- ene %>% 
  group_by(sexo) %>% 
  mutate(n_sexo=n())
table(ene_agrup$n_sexo)


# Número de hombres

ene_agrup %>% 
  filter(sexo==1) %>%
  select(sexo, n_sexo) %>% 
  slice(1:2)

# Número de mujeres

ene_agrup %>% 
  filter(sexo==2) %>%
  select(sexo, n_sexo) %>% 
  slice(1:2)

# Retomemos nuestro trabajo con guaguas

#Utilizando la base guaguas, obtener el nombre más utilizado en Chile en todos los tiempos

library(guaguas)
guaguas %>% 
  group_by(nombre) %>% 
  mutate(total=sum(n)) %>% 
  arrange(desc(total)) %>% 
  slice(1)

# group_by sigue operando, hasta que se indique lo contrario
# Si queremos realizar una operación no agrupada, luego de haber usado group_by,
# debemos desagrupar con ungroup

guaguas %>%
  group_by(nombre) %>%
  mutate(total = sum(n)) %>%
  ungroup() %>%
  arrange(desc(total)) %>% 
  select(nombre, total) %>% 
  slice(1)

# ---- Ejercicio express ----

# Utilizando la base de la ENE, creemos una columna llamada media_edad que contenga 
# la media de edad en cada una de las regiones

ene_medregs <- ene %>% 
  group_by(region) %>% 
  mutate(media_edad = mean(edad))

# Para ver en específico la Región de Arica y Parinacota...
ene_medregs %>% 
  filter(region == 15) %>% 
  select(region, media_edad) %>%
  slice(1:2)

# ---- Uso de summarise... ----

ene %>%
  group_by(region) %>%
  summarise(n = n(), promedio = mean(edad), mediana = median(edad))

# Ejercicio express

# Construir un cuadro de resumen que incluya lo siguiente:
# Número de registros de la región de O'Higgins, por grupo ocupacional (b1).

ene %>% 
  filter(region == 6) %>% 
  group_by(b1) %>% 
  summarise(n = n())

# ---- Uso de función pivot_wider() ----

library(tidyr)

ene %>%
  group_by(region, sexo) %>%
  summarise(n = n()) %>%
  mutate(sexo = if_else(sexo == 1, "hombre", "mujer")) %>% 
  pivot_wider(names_from = sexo,
              values_from = n)

# Uso del parámetro names_prefix

ene %>%
  group_by(region, sexo) %>%
  summarise(n = n()) %>%
  pivot_wider(names_from = sexo,
              values_from = n,
              names_prefix = "sexo" )

# Uso de pivot_longer()

df1 <- data.frame(region = c(1, 2),
                  hombres = c(100, 200),
                  mujeres = c(50, 300))
df1

df1 %>%
  pivot_longer(cols = -region , names_to = "sexo", values_to = "total_sexo")

# ---- Ejercicio Express 2 ----

# Utilizando la base ene, calcule el número de registros según grupo ocupacional (b1), 
# por mes (mes_encuesta).

# Presente el resultado como un cuadro de resumen, con los grupos ocupacionales en las 
# filas y los meses en las columnas.

ene %>%
  group_by(b1, mes_encuesta) %>%
  summarise(n = n()) %>%
  pivot_wider(names_from = mes_encuesta,
              names_prefix = "mes_",
              values_from = n)
