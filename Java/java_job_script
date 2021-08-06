#!/bin/csh -f

#SBATCH --time=03:30:00
#SBATCH --job-name=java
#SBATCH --ntasks=40
#SBATCH --constraint=sky
#SBATCH -A j1008
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH -o Java2021-%j.out


#######################################################################
#                  System Environment Variables
#######################################################################

umask 022

limit

source /usr/share/modules/init/csh
module purge
module load jdk/15

#setenv JAVA_HOME /discover/swdev/mathomp4/other/SLES12.3/OpenJDK/jdk-13.0.1/
#setenv JAVA_BINDIR $JAVA_HOME/bin
#setenv JAVA_ROOT $JAVA_HOME
#setenv JRE_HOME $JAVA_HOME
#setenv JDK_HOME $JAVA_HOME
#setenv PATH $JAVA_HOME/bin:${PATH}

#setenv JAVA_HOME /usr/local/other/SLES11.1/jdk/jdk-10.0.2
#setenv JAVA_BINDIR /usr/local/other/SLES11.1/jdk/jdk-10.0.2/jre/bin
#setenv JAVA_ROOT /usr/local/other/SLES11.1/jdk/jdk-10.0.2
#setenv JRE_HOME /usr/local/other/SLES11.1/jdk/jdk-10.0.2/jre
#setenv JDK_HOME /usr/local/other/SLES11.1/jdk/jdk-10.0.2
#setenv PATH /usr/local/other/SLES11.1/jdk/jdk-10.0.2/jre/bin:${PATH}
#setenv PATH /usr/local/other/SLES11.1/jdk/jdk-10.0.2/bin:${PATH}

rm -f *.class

echo '-------------------------'
echo 'Copy Matrix'
echo '-------------------------'
javac testCopyMatrix.java
java testCopyMatrix 5000
java testCopyMatrix 7000
java testCopyMatrix 9000

echo '-------------------------'
echo 'Count unique words'
echo '-------------------------'
javac testCountUniqueWords.java
java testCountUniqueWords ../Data/world192.txt
java testCountUniqueWords ../Data/plrabn12.txt
java testCountUniqueWords ../Data/bible.txt
java testCountUniqueWords ../Data/book1.txt

echo '-------------------------'
echo 'Look and Say'
echo '-------------------------'
javac testLookAndSay.java
java testLookAndSay 40
java testLookAndSay 45
java testLookAndSay 48

echo '-------------------------'
echo 'Fibonacci Sequence'
echo '-------------------------'
javac testFibonacci.java
java testFibonacci 25
java testFibonacci 35
java testFibonacci 45

echo '-------------------------'
echo 'Matrix Multiplication'
echo '-------------------------'
javac testMatrixMultiplication.java
java testMatrixMultiplication 1500
java testMatrixMultiplication 1750
java testMatrixMultiplication 2000

echo '-------------------------'
echo 'Belief Propagation'
echo '-------------------------'
javac testBeliefPropagation.java
java testBeliefPropagation 250
java testBeliefPropagation 500
java testBeliefPropagation 1000

echo '-------------------------'
echo 'Markov Chain'
echo '-------------------------'
javac testMarkovChain.java
java testMarkovChain 5000
java testMarkovChain 10000
java testMarkovChain 15000

echo '-------------------------'
echo 'Jacobi Iterative solver'
echo '-------------------------'
javac testLaplaceJacobi4.java
java testLaplaceJacobi4 100
java testLaplaceJacobi4 150
java testLaplaceJacobi4 200

echo '-------------------------'
echo 'Evaluate Functions'
echo '-------------------------'
javac testEvaluateFunctions.java
java testEvaluateFunctions  80000
java testEvaluateFunctions  90000
java testEvaluateFunctions 100000

#echo '-------------------------'
#echo 'Gauss Legendre quadrature'
#echo '-------------------------'
#javac testGaussLegendreQuadrature.java
#java testGaussLegendreQuadrature 50
#java testGaussLegendreQuadrature 75
#java testGaussLegendreQuadrature 100

echo '-------------------------'
echo 'Pernicious Numbers'
echo '-------------------------'
javac testPerniciousNumbers.java
java testPerniciousNumbers 100000

echo '-------------------------'
echo 'Munchausen Numbers'
echo '-------------------------'
javac testMunchausenNumber.java
java testMunchausenNumber


rm -f *.class
