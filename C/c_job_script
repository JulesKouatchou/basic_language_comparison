#!/bin/csh -f

#SBATCH --time=03:10:00
#SBATCH --job-name=C_test
#SBATCH --ntasks=40
#SBATCH --constraint=sky
#SBATCH -A j1008
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH -o C2021log-%j.out


#######################################################################
#                  System Environment Variables
#######################################################################

umask 022


source /usr/share/modules/init/csh
module purge
 
module load comp/gcc/9.3.0
module load comp/intel/20.0.0.166

rm -f *.exe

echo '--------------------------------------------------'
echo 'gcc - Matrix Copy: Regular'
echo '--------------------------------------------------'

gcc test_copy_matrix.c -o test_copy_matrix-gcr.exe

./test_copy_matrix-gcr.exe 5000
./test_copy_matrix-gcr.exe 7000
./test_copy_matrix-gcr.exe 9000

echo '--------------------------------------------------'
echo 'gcc - Matrix Copy: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_copy_matrix.c -o test_copy_matrix-gco.exe
#gcc -O3 -march=native -mfpmath=sse test_copy_matrix.c -o test_copy_matrix-gco.exe

./test_copy_matrix-gco.exe 5000
./test_copy_matrix-gco.exe 7000
./test_copy_matrix-gco.exe 9000

echo '--------------------------------------------------'
echo 'icc - Matrix Copy: Regular'
echo '--------------------------------------------------'

icc test_copy_matrix.c -o test_copy_matrix-icr.exe

./test_copy_matrix-icr.exe 5000
./test_copy_matrix-icr.exe 7000
./test_copy_matrix-icr.exe 9000

echo '--------------------------------------------------'
echo 'icc - Matrix Copy: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_copy_matrix.c -o test_copy_matrix-ico.exe
#icc -O3 -march=native -mfpmath=sse test_copy_matrix.c -o test_copy_matrix-ico.exe

./test_copy_matrix-ico.exe 5000
./test_copy_matrix-ico.exe 7000
./test_copy_matrix-ico.exe 9000

echo '--------------------------------------------------'
echo 'gcc - Look and Say: Regular'
echo '--------------------------------------------------'

gcc test_look_and_say.c -o test_look_and_say-gcr.exe -lm

./test_look_and_say-gcr.exe 40
./test_look_and_say-gcr.exe 45
./test_look_and_say-gcr.exe 48

echo '--------------------------------------------------'
echo 'gcc - Look and Say: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_look_and_say.c -o test_look_and_say-gco.exe -lm

./test_look_and_say-gco.exe 40
./test_look_and_say-gco.exe 45
./test_look_and_say-gco.exe 48

echo '--------------------------------------------------'
echo 'icc - Look and Say: Regular'
echo '--------------------------------------------------'

icc test_look_and_say.c -o test_look_and_say-icr.exe -lm

./test_look_and_say-icr.exe 40
./test_look_and_say-icr.exe 45
./test_look_and_say-icr.exe 48

echo '--------------------------------------------------'
echo 'icc - Look and Say: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_look_and_say.c -o test_look_and_say-ico.exe -lm

./test_look_and_say-ico.exe 40
./test_look_and_say-ico.exe 45
./test_look_and_say-ico.exe 48

echo '--------------------------------------------------'
echo 'gcc - Fibonacci: Regular'
echo '--------------------------------------------------'

gcc test_fibonacci.c -o test_fibonacci-gcr.exe -lm

./test_fibonacci-gcr.exe 25
./test_fibonacci-gcr.exe 35
./test_fibonacci-gcr.exe 45

echo '--------------------------------------------------'
echo 'gcc - Fobonacci: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_fibonacci.c -o test_fibonacci-gco.exe -lm
#gcc -O3 -march=native -mfpmath=sse test_fibonacci.c -o test_fibonacci-gco.exe -lm

./test_fibonacci-gco.exe 25
./test_fibonacci-gco.exe 35
./test_fibonacci-gco.exe 45

echo '--------------------------------------------------'
echo 'icc - Fibonacci: Regular'
echo '--------------------------------------------------'

icc test_fibonacci.c -o test_fibonacci-icr.exe

./test_fibonacci-icr.exe 25
./test_fibonacci-icr.exe 35
./test_fibonacci-icr.exe 45

echo '--------------------------------------------------'
echo 'icc - Fobonacci: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_fibonacci.c -o test_fibonacci-ico.exe
#icc -O3 -march=native -mfpmath=sse test_fibonacci.c -o test_fibonacci-ico.exe

./test_fibonacci-ico.exe 25
./test_fibonacci-ico.exe 35
./test_fibonacci-ico.exe 45

echo '--------------------------------------------------'
echo 'gcc - Matrix Multiplication: Regular'
echo '--------------------------------------------------'

gcc test_matrix_multiplication.c -o test_matrix_multiplication-gcr.exe

./test_matrix_multiplication-gcr.exe 1500 1500 1500
./test_matrix_multiplication-gcr.exe 1750 1750 1750
./test_matrix_multiplication-gcr.exe 2000 2000 2000

echo '----------------------------------------------------'
echo 'gcc - Matrix Multiplication: Optimized'
echo '----------------------------------------------------'

gcc -Ofast test_matrix_multiplication.c -o test_matrix_multiplication-gco.exe
#gcc -O3 -march=native -mfpmath=sse test_matrix_multiplication.c -o test_matrix_multiplication-gco.exe

./test_matrix_multiplication-gco.exe 1500 1500 1500
./test_matrix_multiplication-gco.exe 1750 1750 1750
./test_matrix_multiplication-gco.exe 2000 2000 2000

echo '--------------------------------------------------'
echo 'icc - Matrix Multiplication: Regular'
echo '--------------------------------------------------'

icc test_matrix_multiplication.c -o test_matrix_multiplication-icr.exe

./test_matrix_multiplication-icr.exe 1500 1500 1500
./test_matrix_multiplication-icr.exe 1750 1750 1750
./test_matrix_multiplication-icr.exe 2000 2000 2000

echo '----------------------------------------------------'
echo 'icc - Matrix Multiplication: Optimized'
echo '----------------------------------------------------'

icc -Ofast test_matrix_multiplication.c -o test_matrix_multiplication-ico.exe
#icc -O3 -march=native -mfpmath=sse test_matrix_multiplication.c -o test_matrix_multiplication-ico.exe

./test_matrix_multiplication-ico.exe 1500 1500 1500
./test_matrix_multiplication-ico.exe 1750 1750 1750
./test_matrix_multiplication-ico.exe 2000 2000 2000

echo '--------------------------------------------------'
echo 'gcc - Evaluate Functions: Regular'
echo '--------------------------------------------------'

gcc test_evaluate_functions.c -o test_evaluate_functions-gcr.exe -lm

./test_evaluate_functions-gcr.exe 80000
./test_evaluate_functions-gcr.exe 90000
./test_evaluate_functions-gcr.exe 100000

echo '--------------------------------------------------'
echo 'gcc - Evaluate Functions: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_evaluate_functions.c -o test_evaluate_functions-gco.exe -lm

./test_evaluate_functions-gco.exe 80000
./test_evaluate_functions-gco.exe 90000
./test_evaluate_functions-gco.exe 100000

echo '--------------------------------------------------'
echo 'icc - Evaluate Functions: Regular'
echo '--------------------------------------------------'

icc test_evaluate_functions.c -o test_evaluate_functions-icr.exe -lm

./test_evaluate_functions-icr.exe 80000
./test_evaluate_functions-icr.exe 90000
./test_evaluate_functions-icr.exe 100000

echo '--------------------------------------------------'
echo 'icc - Evaluate Functions: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_evaluate_functions.c -o test_evaluate_functions-ico.exe -lm

./test_evaluate_functions-ico.exe 80000
./test_evaluate_functions-ico.exe 90000
./test_evaluate_functions-ico.exe 100000

echo '--------------------------------------------------'
echo 'gcc - Belief: Regular'
echo '--------------------------------------------------'

gcc test_belief_propagation.c -o test_belief_propagation-gcr.exe -lm

./test_belief_propagation-gcr.exe 250
./test_belief_propagation-gcr.exe 500
./test_belief_propagation-gcr.exe 1000

echo '--------------------------------------------------'
echo 'gcc - Belief: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_belief_propagation.c -o test_belief_propagation-gco.exe -lm

./test_belief_propagation-gco.exe 250
./test_belief_propagation-gco.exe 500
./test_belief_propagation-gco.exe 1000

echo '--------------------------------------------------'
echo 'icc - Belief: Regular'
echo '--------------------------------------------------'

icc test_belief_propagation.c -o test_belief_propagation-icr.exe -lm

./test_belief_propagation-icr.exe 250
./test_belief_propagation-icr.exe 500
./test_belief_propagation-icr.exe 1000

echo '--------------------------------------------------'
echo 'icc - Belief: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_belief_propagation.c -o test_belief_propagation-ico.exe -lm

./test_belief_propagation-ico.exe 250
./test_belief_propagation-ico.exe 500
./test_belief_propagation-ico.exe 1000

echo '--------------------------------------------------'
echo 'gcc - Markov Chain: Regular'
echo '--------------------------------------------------'

gcc test_markov_chain.c -o test_markov_chain-gcr.exe -lm

./test_markov_chain-gcr.exe 5000
./test_markov_chain-gcr.exe 10000
./test_markov_chain-gcr.exe 15000

echo '----------------------------------------------------'
echo 'gcc - Markov Chain: Optimized'
echo '----------------------------------------------------'

gcc -Ofast test_markov_chain.c -o test_markov_chain-gco.exe -lm

./test_markov_chain-gco.exe 5000
./test_markov_chain-gco.exe 10000
./test_markov_chain-gco.exe 15000

echo '--------------------------------------------------'
echo 'icc - Markov Chain: Regular'
echo '--------------------------------------------------'

icc test_markov_chain.c -o test_markov_chain-icr.exe -lm

./test_markov_chain-icr.exe 5000
./test_markov_chain-icr.exe 10000
./test_markov_chain-icr.exe 15000

echo '----------------------------------------------------'
echo 'icc - Markov Chain: Optimized'
echo '----------------------------------------------------'

icc -Ofast test_markov_chain.c -o test_markov_chain-ico.exe -lm

./test_markov_chain-ico.exe 5000
./test_markov_chain-ico.exe 10000
./test_markov_chain-ico.exe 15000

echo '----------------------------------------------------'
echo 'gcc - Fourth-order Laplace: Regular'
echo '----------------------------------------------------'

gcc test_laplace_jacobi_4.c -o test_laplace_jacobi_4-gcr.exe -lm

./test_laplace_jacobi_4-gcr.exe 100
./test_laplace_jacobi_4-gcr.exe 150
./test_laplace_jacobi_4-gcr.exe 200

echo '----------------------------------------------------'
echo 'gcc - Fourth-order Laplace: Optimized'
echo '----------------------------------------------------'

gcc -Ofast test_laplace_jacobi_4.c -o test_laplace_jacobi_4-gco.exe -lm
#gcc -O3 -march=native -mfpmath=sse test_laplace_jacobi_4.c -o test_laplace_jacobi_4-gco.exe -lm

./test_laplace_jacobi_4-gco.exe 100
./test_laplace_jacobi_4-gco.exe 150
./test_laplace_jacobi_4-gco.exe 200

echo '----------------------------------------------------'
echo 'icc - Fourth-order Laplace: Regular'
echo '----------------------------------------------------'

icc test_laplace_jacobi_4.c -o test_laplace_jacobi_4-icr.exe

./test_laplace_jacobi_4-icr.exe 100
./test_laplace_jacobi_4-icr.exe 150
./test_laplace_jacobi_4-icr.exe 200

echo '----------------------------------------------------'
echo 'icc - Fourth-order Laplace: Optimized'
echo '----------------------------------------------------'

icc -Ofast test_laplace_jacobi_4.c -o test_laplace_jacobi_4-ico.exe
#icc -O3 -march=native -mfpmath=sse test_laplace_jacobi_4.c -o test_laplace_jacobi_4-ico.exe

./test_laplace_jacobi_4-ico.exe 100
./test_laplace_jacobi_4-ico.exe 150
./test_laplace_jacobi_4-ico.exe 200

echo '--------------------------------------------------'
echo 'gcc - Munchausen Number: Regular'
echo '--------------------------------------------------'

gcc test_munchausen_number.c -o test_munchausen_number-gcr.exe -lm

./test_munchausen_number-gcr.exe

echo '--------------------------------------------------'
echo 'gcc - Munchausen Number: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_munchausen_number.c -o test_munchausen_number-gco.exe -lm

./test_munchausen_number-gco.exe

echo '--------------------------------------------------'
echo 'icc - Munchausen Number: Regular'
echo '--------------------------------------------------'

icc test_munchausen_number.c -o test_munchausen_number-icr.exe -lm

./test_munchausen_number-icr.exe

echo '--------------------------------------------------'
echo 'icc - Munchausen Number: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_munchausen_number.c -o test_munchausen_number-ico.exe -lm

./test_munchausen_number-ico.exe


echo '--------------------------------------------------'
echo 'gcc - Pernicious Number: Regular'
echo '--------------------------------------------------'

gcc test_pernicious_numbers.c -o test_pernicious_numbers-gcr.exe -lm

./test_pernicious_numbers-gcr.exe 100000

echo '--------------------------------------------------'
echo 'gcc - Pernicious Number: Optimized'
echo '--------------------------------------------------'

gcc -Ofast test_pernicious_numbers.c -o test_pernicious_numbers-gco.exe -lm

./test_pernicious_numbers-gco.exe 100000

echo '--------------------------------------------------'
echo 'icc - Pernicious Number: Regular'
echo '--------------------------------------------------'

icc test_pernicious_numbers.c -o test_pernicious_numbers-icr.exe -lm

./test_pernicious_numbers-icr.exe 100000

echo '--------------------------------------------------'
echo 'icc - Pernicious Number: Optimized'
echo '--------------------------------------------------'

icc -Ofast test_pernicious_numbers.c -o test_pernicious_numbers-ico.exe -lm

./test_pernicious_numbers-ico.exe 100000

echo '__________________________________________________'
echo 'Delete all executables'
echo '__________________________________________________'
rm -f *exe
