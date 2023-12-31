# Set Calculator

This Ruby command-line application implements a simple Set Calculator with sets represented as Binary Search Trees (BSTs). The key features include maintaining up to three sets (X, Y, and Z), performing set operations, and ensuring that all sets hold exclusively numerical values without duplicates.

## Project Overview

1. **Set Initialization:**
   - `X values`: Initialize set X with a comma-separated list of numeric values. The previous content of X is replaced.

   - `Y values`: Similar to `X values`, but for set Y.

   - `Z values`: Similar to `X values`, but for set Z.

2. **Element Insertion:**
   - `a i`: Insert a numeric value i into set X at an appropriate location while preserving the BST properties. Sets Y and Z remain unchanged.

3. **Rotation and Switching:**
   - `r`: Rotate the contents of sets X, Y, and Z. Set Y takes the content of X, set Z takes the content of Y, and set X takes the previous content of Z. BSTs are not modified or copied.

   - `s`: Switch the contents of sets X and Y. BSTs are not modified or copied.

4. **Set Operations:**
   - `u`: Take the union of sets X and Y, storing the result in X.

   - `i`: Take the intersection of sets X and Y, storing the result in X.

5. **Deep Copy and Lambda Evaluation:**
   - `c`: Recursively deep copy set X into set Y, replacing the previous content of Y.

   - `l aString`: Apply a one-argument lambda expression, defined by a string, to every element of set X. Output the result of each lambda execution on the console. Set X is not modified.

6. **Quit:**
   - `q`: Quit the project.

## Execution and Output

- After each command execution, the contents of sets X, Y, and Z are displayed on the console.

## Evaluation Criteria

Your project will be evaluated based on the following criteria:

1. **Compliance with Specification:**
   - Implement the specified features according to the given requirements.

2. **Code Comments:**
   - Include meaningful code comments to enhance readability and understanding.

3. **Conciseness:**
   - Avoid unnecessary data structure definitions and maintain code conciseness.

## Additional Hints

- Use the `eval()` method to evaluate string representations of lambda expressions.

Example:
```ruby
aString = "-> {a, b = 10, 20 ; c = a + b ;}"
aBlock = eval aString
aBlock.call  # This returns 30
```

Feel free to explore and extend the functionality of the Set Calculator as needed.
