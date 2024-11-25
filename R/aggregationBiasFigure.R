library(tidyverse)
library(eaTools)
library(sf)
library(ggtext)

var <- seq(50, 200, 0.1)
dat <- data.frame(var = var)

X0 <- 60
X100 <- 160
Vbar <- ((X100-X0)/2)+X0

V1 <- 100
V2 <- 195
Vbar <- ((V2-V1)/2)+V1

dat <- var |>
  tibble() |>
  mutate(ind = case_when(
    var > X100 ~ 1,
    var >X0 ~ (var -X0)/(X100-X0),
    var <= X0 ~ 0,
  ),
  ind = round(ind, 3))

low <- "red"
high <- "green"
#ridge <- ggridges::geom_density_ridges_gradient(scale = 3, 
#                                                size = 0.3)
mySize <- 4
myAlpha <- 1
lt = 2
lc <- "black"

fV1 <- dat |>
  filter(var == V1) |>
  pull(ind)
fV2 <- dat |>
  filter(var == V2) |>
  pull(ind)
fVhatt <- dat |>
  filter(var == Vbar) |>
  pull(ind)
fVbar <- ((fV2-fV1)/2)+fV1

dat_x <- dat |>
  distinct(ind,
           .keep_all = T) |>
  add_row(ind = 0, var = X0) |>
  add_row(ind = 1, var = 200)


# ggtext and element markdown doesnt work for some mathematical signs, like bar.
## PLOT 1 -------------
dat_x |>
  ggplot(aes(
    x = var,
    y = ind,
    colour = ind
  )) +
  geom_line(
    lineend = "round",
    size = mySize,
    alpha = myAlpha
  ) +
  ylab("") +
  xlab("") +
  scale_color_gradient("Indicator values",
    low = low,
    high = high
  ) +
  scale_x_continuous( # expand = expansion(mult = 0.2),
    breaks = c(X0, V1, Vbar, X100, V2),
    labels = c(
      expression(X[0]),
      expression(V[1]),
      expression(bar(V)),
      expression(X[100]),
      expression(V[2])
    )
  ) +
  scale_y_continuous( # expand = expansion(mult = 0.2),
    breaks = c(0, fV1, fVbar, fVhatt, 1),
    labels = c(
      "0",
      expression(paste("f(", V[1], ")")),
      expression(bar(i)),
      expression(hat(i)),
      expression(paste("f(", V[2], ")"))
    )
  ) +
  guides(color = "none") +
  theme_bw(base_size = 30) +
  theme(panel.grid.minor = element_blank()) +
  geom_segment(aes(x = 50, y = fV1, xend = V1, yend = fV1),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V1, y = fV1, xend = V1, yend = 0),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = 50, y = fV2, xend = V2, yend = fV2),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V2, y = fV2, xend = V2, yend = 0),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V1, y = fV1, xend = V2, yend = 1),
    color = lc, linewidth = 2, linetype = 1
  ) +
  geom_segment(aes(x = 50, y = fVbar, xend = Vbar, yend = fVbar),
    color = lc, linewidth = 2, linetype = lt
  ) + 
  geom_segment(aes(x = Vbar, y = fVbar, xend = Vbar, yend = 0),
    color = lc, linewidth = 2, linetype = lt
  ) + 
  geom_segment(aes(x = 50, y = fVhatt, xend = Vbar, yend = fVhatt),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = Vbar, y = fVhatt, xend = Vbar, yend = fVbar),
    color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = 60, y = fVbar, xend = 60, yend = fVhatt),
               color = lc, linewidth = 2, linetype = 1, 
               arrow = arrow(ends = "both")
  ) +
  geom_text(x = 60+20, y = fVbar+0.08,
            label = "aggregation\nerror",
            color = "black",
            size = 6
            )


#ggsave("img/aggregation_bias_truncations.PNG")


## PLOT 2 --------------
# add X60


X60 <- 150
X100 <- 160
V2 <- 170
Vbar <- ((V2-V1)/2)+V1

dat2 <- var |>
  tibble() |>
  mutate(ind = case_when(
    var > X100 ~ 1,
    var >X60 ~ (var-X60)/(X100-X60) *(1 - 0.6) + 0.6,
    var >X0 ~ (var-X0)/(X60-X0) *0.6,
    var <= X0 ~ 0,
  ),
  ind = round(ind, 3))

fV1x <- dat2 |>
  filter(var == V1) |>
  pull(ind)
fV2x <- dat2 |>
  filter(var == V2) |>
  pull(ind)
fVhattx <- dat2 |>
  filter(var == Vbar) |>
  pull(ind)
fVbarx <- ((fV2x-fV1x)/2)+fV1x

dat3 <- dat2 |>
  distinct(ind,
           .keep_all = T) |>
  add_row(ind = 0, var = X0) |>
  add_row(ind = 1, var = 200)

dat3 |>
  ggplot(aes(
    x = var,
    y = ind,
    colour = ind
  )) +
  geom_point()+
  geom_line(
    lineend = "round",
    linejoin = "bevel",
    size = mySize,
    alpha = myAlpha
  ) +
  scale_color_gradient("Indicator values",
                       low = low,
                       high = high
  ) +
  ylab("") +
  xlab("") +
  scale_x_continuous( # expand = expansion(mult = 0.2),
    breaks = c(X0, V1, Vbar, X60, X100, V2),
    labels = c(
      expression(X[0]),
      expression(V[1]),
      expression(bar(V)),
      expression(X[60]),
      expression(X[100]),
      expression(V[2])
    )
  ) +
  scale_y_continuous( # expand = expansion(mult = 0.2),
    breaks = c(0, fV1x, fVbarx, fVhattx, 1),
    labels = c(
      "0",
      expression(paste("f(", V[1], ")")),
      expression(bar(i)),
      expression(hat(i)),
      expression(paste("f(", V[2], ")"))
    )
  ) +
  guides(color = "none") +
  theme_bw(base_size = 30) +
  theme(panel.grid.minor = element_blank()) +
  geom_segment(aes(x = 50, y = fV1x, xend = V1, yend = fV1x),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V1, y = fV1x, xend = V1, yend = 0),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = 50, y = fV2x, xend = V2, yend = fV2x),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V2, y = fV2x, xend = V2, yend = 0),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = V1, y = fV1x, xend = V2, yend = 1),
               color = lc, linewidth = 2, linetype = 1
  ) +
  geom_segment(aes(x = 50, y = fVbarx, xend = Vbar, yend = fVbarx),
               color = lc, linewidth = 2, linetype = lt
  ) + 
  geom_segment(aes(x = Vbar, y = fVbarx, xend = Vbar, yend = 0),
               color = lc, linewidth = 2, linetype = lt
  ) + 
  geom_segment(aes(x = 50, y = fVhattx, xend = Vbar, yend = fVhattx),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = Vbar, y = fVhattx, xend = Vbar, yend = fVbarx),
               color = lc, linewidth = 2, linetype = lt
  ) +
  geom_segment(aes(x = 60, y = fVbarx, xend = 60, yend = fVhattx),
               color = lc, linewidth = 2, linetype = 1, 
               arrow = arrow(ends = "both")
  ) +
  geom_text(x = 60+20, y = fVhattx+0.08,
            label = "aggregation\nerror",
            color = "black",
            size = 6
  )


#ggsave("img/aggregation_bias_x60.PNG")
