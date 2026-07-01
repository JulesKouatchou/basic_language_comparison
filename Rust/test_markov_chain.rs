

use rand::Rng;
use std::env;
use std::f64::consts::PI;
use std::process;
use std::time::Instant;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <N>", args[0]);
        process::exit(1);
    }

    // Parse the number of iterations from the command line
    let n: usize = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: N must be a valid integer.");
            process::exit(1);
        }
    };

    let mut x: [f64; 2] = [0.0, 0.0];

    // Start the timer
    let start = Instant::now();

    // Perform the Markov Chain operations
    mcmc(&mut x, n);

    // End the timer
    let duration = start.elapsed();

    println!(
        "Time for belief calculations ({}): {:.6} s",
        n,
        duration.as_secs_f64()
    );
}

/// The target probability density function
fn f(x: &[f64; 2]) -> f64 {
    ((x[0] * 5.0).sin() - x[0] * x[0] - x[1] * x[1]).exp()
}

/// Markov Chain Monte Carlo using Metropolis-Hastings and Box-Muller
fn mcmc(x: &mut [f64; 2], n: usize) {
    let mut rng = rand::rng();
    let mut p = f(x);
    let mut x2 = [0.0f64; 2];

    for _ in 0..n {
        // Run Box-Muller to get 2 normal random variables.
        // `rng.gen::<f64>()` generates a uniform float in the range [0.0, 1.0).
        // Note: To perfectly mimic C's rand()/RAND_MAX we use gen(), but we add
        // a tiny epsilon to U1 to prevent ln(0.0) which yields -Infinity.
        let mut u1: f64 = rng.random();
        if u1 == 0.0 {
            u1 = std::f64::EPSILON;
        }
        let u2: f64 = rng.random();

        let r1 = (-2.0 * u1.ln()).sqrt() * (2.0 * PI * u2).cos();
        let r2 = (-2.0 * u1.ln()).sqrt() * (2.0 * PI * u2).sin();

        x2[0] = x[0] + 0.01 * r1;
        x2[1] = x[1] + 0.01 * r2;

        let p2 = f(&x2);

        // Metropolis acceptance criterion
        let acceptance_ratio = p2 / p;
        if rng.random::<f64>() < acceptance_ratio {
            x[0] = x2[0];
            x[1] = x2[1];
            p = p2;
        }
    }
}
