library(ggplot2)
ggplot(data = pressure) +
  geom_point(mapping = aes(x = temperature, y = pressure))

pressure

library(guaguas)
library(tidyverse)

head(guaguas, 2)
library(ggplot2)
library(tidyverse)

tabla <- guaguas %>% 
  group_by(sexo) %>% 
  summarise(suma = sum(n))
tabla

# Gráfico de barra por sexo

options(scipen = "999") #se usa para evitar que valores del eje no quede como notación científica
ggplot(data = tabla, aes(x = sexo, y = suma))+
  geom_bar(stat = "identity") # no hacer nada con los datos, es decir, graficar la tabla sin modificaciones.

# geom_bar por defecto llama a la función stat_count

# stat_count espera como input una sola variable

ggplot(data = tabla, aes(x = sexo, y = suma)) + 
  geom_bar()

## Error: stat_count() can only have an x or y aesthetic.

# podemos agregar una segunda capa

ggplot(data = tabla, aes(x = sexo, y = suma)) + 
  geom_bar(stat = "identity") + 
  geom_hline(aes(yintercept = mean(suma)) )

mean(tabla$suma)

## [1] 10118752

# ejercicio express

# Creemos un gráfico de líneas que contenga la suma de guaguas inscritas para cada año

# Pista: la capa para crear un gráfico de líneas es geom_line

guaguas %>% 
  group_by(anio) %>% 
  summarise(suma = sum(n)) %>% 
  ggplot(aes(x = anio, y = suma)) +
  geom_line() 
  

# ---- Agregando más atributos ----

# Nombres de mujer más populares de 2019

top10 <- guaguas %>% 
  filter(anio == 2019 & sexo == "F") %>% 
  arrange(desc(n)) %>% 
  slice(1:10)
ggplot(top10, aes(x = nombre, y = n, fill = nombre)) +
  geom_bar(stat = "identity")

# Para ordenar de mayor a menor, puedo usar fct_reorder()

top10 <- guaguas %>% 
  filter(anio == 2019 & sexo == "F") %>% 
  arrange(desc(n)) %>% 
  slice(1:10)
ggplot(top10, aes(x = fct_reorder (nombre, desc(n)), y = n, fill = nombre)) +
  geom_bar(stat = "identity")

# Se puede manejar el color con el parámetro color

# Con la función labs podemos agregar etiquetas a nuestro gráfico

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia")

# la función theme controla características generales del gráfico: fuente, posición,
# tamaño de letra, etc.

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia", 
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5))

# existen variables internas que nos permiten acceder a los elementos del gráfico

# con element_text podemos modificar varias cosas

guaguas::guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust= 0.5)) # vjust= 0.5 centra 
# la etiqueta en las líneas del eje

# Con color manejamos el color de texto

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90),
        axis.title.x = element_text(color = "red"))

# Con face manejamos el tipo de letra (plain, italic, bold o bold.italic)

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90),
        axis.title.x = element_text(color = "red"),
        axis.text.y = element_text(face = "bold.italic"))

# Con legend.position manejamos la posición de la leyenda. En este caso decidimos 
# sacarla con none

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90),
        axis.title.x = element_text(color = "red"),
        axis.text.y = element_text(face = "bold.italic"),
        legend.position = "none")

# Con legend.background manejamos el fondo de la leyenda. En este caso usamos darkgray

guaguas %>% 
  filter(nombre == "Salvador" & anio <= 1990) %>% 
  ggplot(aes(x = anio, y = n, color = "coral")) +
  geom_line() +
  geom_vline(xintercept = 1971, linetype="dashed") +
  labs(title="El nombre Salvador a lo largo de la historia",
       x ="año", y = "frecuencia") + 
  theme(plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90),
        axis.title.x = element_text(color = "red"),
        axis.text.y = element_text(face = "bold.italic"),
        legend.position =  "bottom",
        legend.background = element_rect(fill = "darkgray") )

# ---- Agregando más atributos y capas ----

guaguas %>% 
  filter(nombre %in% c("Milenka", "Branco", "Salomé", "Jovanka") & anio > 1980) %>% 
  ggplot(aes(anio, n, color = nombre)) +
  geom_point() +
  geom_line() +
  labs(x = "año", y = "total inscripciones",
       title = "Inscripciones de nombres de personajes de Romané") +
  theme(plot.title = element_text(hjust = 0.5))

# Segundo Dataset

life <-  gapminder::gapminder %>% 
  filter(year == 2007)
ggplot(life, aes(x = lifeExp, y = log(gdpPercap)) ) + 
  geom_point()

# Aplicamos una transformación logarítmica para obtener una mejor visualización

# Agreguemos una variable para indicar el continente de cada país

ggplot(life, aes(x = lifeExp, y = log(gdpPercap), color = continent) ) + 
  geom_point()

# Ejercicio express

# Agreguemos otra variable para indicar la población de cada país

# Pista: El parámetro size puede ser de gran ayuda

ggplot(life, aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point() +
  scale_size(range = c(1, 7))

# Usando alpha (transparencia) para disminuir solucionar problema de superposición 
# de puntos

ggplot(life, aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point(alpha = 0.6) +
  scale_size(range = c(1, 5))

# geom_jitter agrega un ruido aleatorio

ggplot(life, aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point() +
  geom_jitter(width = 0.5) +
  scale_size()

# Paneles separados
# Con facet_wrap generamos un panel para cada categoría de la variable

ggplot(life, aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point() +
  scale_size(range = c(1, 5)) +
  facet_wrap(~continent)

# Ejercicio express
# Seleccionemos los años 1992, 1997, 2002, 2007 y generemos un gráfico con facetas para cada uno de dichos años

gapminder::gapminder %>% 
  filter(year %in% c(1992, 1997, 2002, 2007)) %>% 
  ggplot(aes(x = lifeExp, y = log(gdpPercap), color = continent, size = pop) ) + 
  geom_point() +
  scale_size(range = c(1, 7)) +
  facet_wrap(~year)

# patchwork

# En algunas ocasiones puede ser necesario unir varios gráficos

install.packages("patchwork")
library(patchwork)
p1 <- ggplot(mtcars) + geom_point(aes(mpg, hp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, hp, group = gear))
p1 + p2

# Tenemos flexibilidad para organizar el panel

p3 <- ggplot(mtcars) + geom_smooth(aes(hp, mpg))
p4 <- ggplot(mtcars) + geom_bar(aes(cyl))
(p1 | p2 | p3) /
  p4

# gganimate (bonus 2)
# En nuestras visualizaciones la variable tiempo no se aprecia tan bien

# Podemos incluir movimiento para mejorar la percepción de cómo cambia la relación entre pib y esperanza de vida a lo largo del tiempo

#install.packages("gifski") puede ser necesario

install.packages("gifski")
library(gganimate)
p <- ggplot(gapminder::gapminder, aes(gdpPercap, lifeExp, 
                                      color = continent)) +
  geom_point(aes(size = pop), show.legend = FALSE) +
  scale_y_continuous(breaks = seq(20,90,10)) +
  scale_size(range = c(2,12)) + 
  scale_x_log10() +
  transition_states(year) +
  labs(title = 'Año: {closest_state}', x = 'pib p/c', y = 'esperanza de vida') +
  theme(plot.title = element_text(hjust = 0.5))

animate(p, renderer = gifski_renderer(), fps=10)
