# Basic Comparison of Various Computing Languages

We use simple test cases to compare various high level  programming languages.
We implement the test cases from an angle of a novice programmer who is not
familiar with the optimization techniques available on the languages.
The goal is to highlight the strengths and weaknesses of each language but not
to claim that one language is better than the other.

**Loops and Vectorization**

 * Copy Multidimensional Arrays
 
        An n x n x 3 matrix A is created and populated.
        Entries are copied from A(i, j, k-1) to A(i, j, k) for each k in each row
        and column (i, j). The elapsed time to perform this operation for the full
        matrix is measured using both iterative and vectorization methods.
        This tests the speed of the access to non-continuous memory locations.

**String Manipulations**

 * Look and Say Sequence
        The look and say sequence reads a single integer. In each subsequent entry,
        the number of appearances of each integer in the previous entry is
        concatenated to the front of that integer. For example, an entry of 1223
        would be followed by 112213, or "one 1, two 2's, one 3."
        Here, we start with the number 1223334444 and determine the look and sequence
        of order n (as n varies).

 o Count Unique words in a file
        We open an arbitrary file and count the number of unique words in it
        with the assumption that words such as:
                ab   Ab   aB    a&*(-b:    17;A#~!b
        are the same.

Numerical Computations
----------------------
 o Fibonacci Sequence
        The Fibonacci Sequence is a sequence of numbers where each successive number
        is the sum of the two that precede it:

                F_n = F_n-1 + F_n-2 .

        Its first entries are

                F_0 = 0 ,  F_1 = F_2 = 1 .

        We measure the elapsed time when calculating an nth Fibonacci number.
        The calculation times are taken for both iterative and recursive calculation
        methods.

 o Matrix Multiplication
        Two randomly generated n x n matrices A and B are multiplied.
        The time to perform the multiplication is measured. This test highlights the
        importance of using the language's built-in libraries.

 o Belief propagation algorithm
        Belief propagation is an algorithm used for inference, often in the fields of
        artificial intelligence, speech recognition, computer vision, image processing,
        medical diagnostics, parity check codes, and others. The algorithm requires
        repeated matrix multiplication and then a normalization of the matrix.
        This test measures the elapsed time when performing n iterations of the
        algorithm.


 o Metropolis-Hastings algorithm
        The Metropolis-Hastings algorithm is a an algorithm used to determine random
        samples from a probability distribution. This implementation uses a
        two-dimensional distribution (Domke 2012), and measures the elapsed time to
        iterate n times.

 o Compute the FFTs
        An matrix M with dimensions n x n is populated with random complex values.
        The Fast Fourier Transform (FFT) of M is calculated as matrix r, then
        the absolute value of r is taken. The time to complete this full operation
        is measured.

o  Iterative solver
        We use the Jacobi iterative solver to numerically approximate the solution
        of the two-dimensional Laplace equation (that was discretized with a
        fouth order compact schems) to a differential equation. we record the
        elapsed time as the number of grid point varies.

 o Square root of a matrix
        Given an n x n matrix A, we are looking for the matrix B such that:
                B * B = A
        In our calculations, we consider A with 6s on the diagonal and 1s elsewhere.


 o Gauss-Legendre quadrature
        Gauss-Legendre quadrature is a numerical method for approximating definite
        integrals. It uses a weighted sum of n values of the integrand function.
        The result is exact if the integrand function is a polynomial of degree 0
        to 2n - 1. Here we consier an exponential function over the interval [-3,3]
        and record the time to perform the integral when n varies.

 o Function evaluations
        We iteratively calculate trigonometric functions on an n-element list of
        values, and then compute inverse trigonometric functions on the same list.
        The time to complete the full operations is measured as n varies.

 o Munchausen Numbers
        A Munchausen number is a natural number that is equal to the sum of its
        there are four such numbers: 0, 1, 3435 and 438579088. We determine how
        much time it takes to find them.

Input/Output
-------------
 o Reading Large Collection of Files
       We have a set of daily NetCDF files (7305) covering a period of 20 years.
       The files for a given year are in a sub-directory labeled YYYY
       (for instance Y1990, Y1991, Y1992, etc.). We want to write a script that
       opens each file, reads a three-dimensional variable (longitude/latitude/level),
       and manipulates it. A pseudo code for the script reads:

           Loop over the years
                Obtain the list of NetCDF files
                Loop over the files
                     Read the variable (longitude/latitude/level)
                     Compute the zonal mean average (new array of latitude/level)
                     Extract the column array at latitude 86 degree South
                     Append the column array to a "master" array (or matrix)

       The goal is to be able to do a generate the three-diemsional arrays
       (year/level/value) and carry out a contour plot.

