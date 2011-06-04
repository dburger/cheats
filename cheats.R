# definiting a simple function
combinations <- function(n, r) {
  return (factorial(n) / (factorial(r) * factorial(n - r)));
}
