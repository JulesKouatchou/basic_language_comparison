// You can run this via Cargo and pass the number of iterations (e.g., 50) like this:
// cargo run --release -- 50
//
// Setup:
// If you are starting a new Rust project, run cargo new belief_prop.
// Then, add the rand crate to your Cargo.toml dependencies:
// [dependencies]
// rand = "0.8"
//
use rand::Rng;
use std::env;
use std::process;
use std::time::Instant;

const DIM: usize = 1000;

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

    // Allocate arrays on the heap (Vec) to avoid stack overflow for 8MB arrays
    let mut a = vec![vec![0.0f64; DIM]; DIM];
    let mut x = vec![1.0f64; DIM];

    let mut rng = rand::thread_rng();

    // Initialize the A matrix with random numbers between 0.0 and 1.0
    for i in 0..DIM {
        for j in 0..DIM {
            a[i][j] = rng.gen::<f64>();
        }
    }

    // Start timer
    let start = Instant::now();

    // Perform the belief operations
    belief_propagation(&a, &mut x, n);

    // End timer
    let duration = start.elapsed();

    println!(
        "Time for Belief Propagation ({}): {:.6} s",
        n,
        duration.as_secs_f64()
    );
}

fn belief_propagation(a: &[Vec<f64>], x: &mut [f64], n: usize) {
    let mut x2 = vec![0.0f64; DIM];

    for _ in 0..n {
        // Step 1: Matrix multiplication with exp(x)
        for i in 0..DIM {
            x2[i] = 0.0;
            for j in 0..DIM {
                x2[i] += a[i][j] * x[j].exp();
            }
        }

        // Step 2: Log transform
        for i in 0..DIM {
            x[i] = x2[i].ln();
        }

        // Step 3: Calculate sum of exp(x)
        let mut mysum = 0.0;
        for i in 0..DIM {
            mysum += x[i].exp();
        }

        // Step 4: Normalize
        let mynorm = mysum.ln();
        for i in 0..DIM {
            x[i] -= mynorm;
        }
    }
}
