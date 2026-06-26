
use std::f64::consts::PI;
use std::time::Instant;

const N: usize = 70;

struct GaussLegendre {
    lroots: [f64; N],
    weight: [f64; N],
    lcoef: [[f64; N + 1]; N + 1],
}

impl GaussLegendre {
    fn new() -> Self {
        GaussLegendre {
            lroots: [0.0; N],
            weight: [0.0; N],
            lcoef: [[0.0; N + 1]; N + 1],
        }
    }

    fn lege_coef(&mut self) {
        self.lcoef[0][0] = 1.0;
        self.lcoef[1][1] = 1.0;
        
        for n in 2..=N {
            let nf = n as f64;
            self.lcoef[n][0] = -(nf - 1.0) * self.lcoef[n - 2][0] / nf;
            for i in 1..=n {
                self.lcoef[n][i] = ((2.0 * nf - 1.0) * self.lcoef[n - 1][i - 1] 
                                  - (nf - 1.0) * self.lcoef[n - 2][i]) / nf;
            }
        }
    }

    fn lege_eval(&self, n: usize, x: f64) -> f64 {
        let mut s = self.lcoef[n][n];
        // Equivalent to C's `for (i = n; i; i--)`
        for i in (1..=n).rev() {
            s = s * x + self.lcoef[n][i - 1];
        }
        s
    }

    fn lege_diff(&self, n: usize, x: f64) -> f64 {
        (n as f64) * (x * self.lege_eval(n, x) - self.lege_eval(n - 1, x)) / (x * x - 1.0)
    }

    fn lege_roots(&mut self) {
        for i in 1..=N {
            let mut x = (PI * ((i as f64) - 0.25) / ((N as f64) + 0.5)).cos();
            let mut x1;
            
            loop {
                x1 = x;
                x -= self.lege_eval(N, x) / self.lege_diff(N, x);
                if (x - x1).abs() <= 1.0e-16 {
                    break;
                }
            }
            
            self.lroots[i - 1] = x;
            x1 = self.lege_diff(N, x);
            self.weight[i - 1] = 2.0 / ((1.0 - x * x) * x1 * x1);
        }
    }

    fn lege_inte(&self, f: fn(f64) -> f64, a: f64, b: f64) -> f64 {
        let c1 = (b - a) / 2.0;
        let c2 = (b + a) / 2.0;
        let mut sum = 0.0;
        
        for i in 0..N {
            sum += self.weight[i] * f(c1 * self.lroots[i] + c2);
        }
        
        c1 * sum
    }
}

fn main() {
    let start = Instant::now();

    let mut gl = GaussLegendre::new();
    
    gl.lege_coef();
    gl.lege_roots();
    
    // Perform the integration
    let integral_result = gl.lege_inte(f64::exp, -3.0, 3.0);
    
    let duration = start.elapsed();

    println!(
        "Time for quadrature ({}): {:.6} s",
        N,
        duration.as_secs_f64()
    );

    let actual = 3.0_f64.exp() - (-3.0_f64).exp();
    
    println!(
        "\nintegrating Exp(x) over [-3, 3]:\n\t{:.8},\ncompred to actual\n\t{:.8}",
        integral_result, actual
    );
}
