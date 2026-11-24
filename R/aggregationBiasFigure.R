library(ecTools)
library(tidyverse)
library(patchwork)

# Conceptual aggregation displacement for two equally weighted observations.
ec_aggregation_bias <- function(var, xmin, xmax, x0, x100,
                                x60 = NULL, ..., gradient = FALSE,
                                show_difference = FALSE) {
  stopifnot(is.numeric(var), length(var) == 2L,
            all(is.finite(var)), xmin < xmax,
            all(var >= xmin & var <= xmax), length(unique(var)) == 2L)
  var <- sort(var)
  scale_fun <- function(x) {
    if (is.null(x60)) {
      ecTools::ec_normalise(x, x0 = x0, x100 = x100, ...)
    } else {
      ecTools::ec_normalise(x, x0 = x0, x60 = x60, x100 = x100, ...)
    }
  }
  ind <- scale_fun(var)
  meanvar <- mean(var)
  meanind <- mean(ind)
  indFromMeanVar <- scale_fun(meanvar)
  diff <- indFromMeanVar - meanind

  # Find where the mean indicator intersects the normalisation function.
  x_cross <- uniroot(function(x) scale_fun(x) - meanind,
                     interval = range(var), tol = 1e-10)$root

  col_variable <- "#555555"
  #col_indicator <- "#0ff526"
  col_indicator <- "#075bf7"
  xrange <- xmax - xmin
  x_arrow <- xmin + 0.07 * xrange
  x_text <- x_arrow + 0.04 * xrange

  # Include exact breakpoints in the curve.
  curve_dat <- tibble(var = sort(unique(c(seq(xmin, xmax, length.out = 2001),
                                         x0, x60, x100, var, meanvar, x_cross)))) |>
    filter(var >= xmin, var <= xmax) |>
    mutate(ind = scale_fun(var))

  # Merge coincident symbolic ticks (e.g. X100 = V2).
  merge_ticks <- function(values, labels) {
    groups <- split(seq_along(values), match(values, unique(values)))
    list(breaks = vapply(groups, function(j) values[j[1]], numeric(1)),
         labels = as.expression(lapply(groups, function(j) {
           Reduce(function(a, b) call("==", a, b), labels[j])
         })))
  }
  xt <- merge_ticks(c(x0, var[1], meanvar, x60, x100, var[2]),
                    c(expression(X[0], V[1], bar(V)),
                      if (!is.null(x60)) expression(X[60]),
                      expression(X[100], V[2])))
  # Nudge the combined X100 = V2 label to the right
  if (!is.null(x60) && x100 == var[2]) {
    xt$labels[xt$breaks == x100] <-
     expression(phantom("          ") * X[100] == V[2])
  }
  yt <- merge_ticks(c(0, ind[1], meanind, indFromMeanVar, ind[2]),
                    expression(0, f(V[1]), bar(i), hat(i), f(V[2])))

  p <- ggplot(data.frame(var, ind), aes(var, ind))
  if (gradient) {
    p <- p + geom_line(data = curve_dat, aes(colour = ind),
                       linewidth = 1.5, lineend = "round") +
      scale_colour_gradient(low = "red", high = "green",
                            limits = c(0, 1), guide = "none")
  } else {
    p <- p + geom_line(data = curve_dat, colour = "#555555", linewidth = 1)
  }

  # Both horizontal aggregation lines end at the normalisation curve.
  p +
    annotate("segment", x = xmin, xend = var, y = ind, yend = ind,
             colour = "black", linewidth = 0.7, linetype = "dashed") +
    annotate("segment", x = var, xend = var, y = 0, yend = ind,
             colour = "black", linewidth = 0.7, linetype = "dashed") +
    annotate("segment", x = meanvar, xend = meanvar, y = 0,
             yend = indFromMeanVar,
             colour = col_variable, linewidth = 1, linetype = "dashed") +
    annotate("segment", x = xmin, xend = meanvar,
             y = indFromMeanVar, yend = indFromMeanVar,
             colour = col_variable, linewidth = 1, linetype = "dashed") +
    annotate("segment", x = xmin, xend = x_cross, y = meanind, yend = meanind,
             colour = col_indicator, linewidth = 2, linetype = "solid") +
    #geom_point(size = 2.5) +
    annotate("segment", x = x_arrow, xend = x_arrow,
             y = meanind, yend = indFromMeanVar, linewidth = 0.7,
             arrow = if (abs(diff) > 0.025) grid::arrow(
               ends = "both", length = grid::unit(0.12, "cm")) else NULL) +
    annotate("text", x = x_text, y = mean(c(meanind, indFromMeanVar)),
             label = if (show_difference) sprintf("Aggregation\ndisplacement = %.3f", diff)
                     else "Aggregation\ndisplacement",
             hjust = 0, size = 5) +
    scale_x_continuous(breaks = xt$breaks, labels = xt$labels) +
    scale_y_continuous(breaks = yt$breaks, labels = yt$labels) +
    coord_cartesian(xlim = c(xmin, xmax), ylim = c(0, 1), clip = "off") +
    labs(x = expression("Condition variable (" * V * ")"),
         y = expression("Condition indicator (" * i * ")")) +
    theme_bw(base_size = 16) +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(colour = "grey90"))
}

# A: linear scaling with truncation
fig1 <- ec_aggregation_bias(var = c(100, 195), xmin = 50, xmax = 200,
                            x0 = 60, x100 = 160, fun = "linear", gradient = TRUE,
                                show_difference = FALSE)

# B: piecewise linear scaling with X60
fig2 <- ec_aggregation_bias(var = c(100, 160), xmin = 50, xmax = 200,
                            x0 = 60, x60 = 150, x100 = 160, fun = "linear", gradient = TRUE)

out <- fig1 + fig2 + plot_annotation(tag_levels = "A", tag_suffix = ")")
out

#dir.create("img", showWarnings = FALSE, recursive = TRUE)
ggsave(plot = out, filename = "img/aggregation_bias_refactored_v2.png",
       width = 30, height = 16, units = "cm", dpi = 300)
