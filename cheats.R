# definiting a simple function
combinations <- function(n, r) {
  return (factorial(n) / (factorial(r) * factorial(n - r)));
}

# and you can't show combinations without permutations
permutations <- function(n, r) {
  return (factorial(n) / factorial(n - r));
}