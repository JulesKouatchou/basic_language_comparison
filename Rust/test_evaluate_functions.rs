

use std::env;
use std::process;
use std::time::Instant;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <n>", args[0]);
        process::exit(1);
    }

    // Parse the dimension from the command line
    let n: usize = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: n must be a valid integer.");
            process::exit(1);
        }
    };

    // Prevent division by zero when calculating 'h'
    if n <= 1 {
        eprintln!("Error: n must be greater than 1.");
        process::exit(1);
    }

    let a_min = -1500.0;
    let a_max = 1500.0;
    let num_iterations = 10000;

    // Start the timer
    let start = Instant::now();

    // Allocate the arrays on the heap
    let mut x = vec![0.0f64; n];
    let mut y = vec![0.0f64; n];

    // Initialize the x array
    let h = (a_max - a_min) / ((n - 1) as f64);
    for i in 0..n {
        x[i] = a_min + (i as f64) * h;
    }

    // Perform the trigonometric operations
    for _ in 0..num_iterations {
        for j in 0..n {
            y[j] = x[j].sin();
            x[j] = y[j].asin();
            y[j] = x[j].cos();
            x[j] = y[j].acos();
            y[j] = x[j].tan();
            x[j] = y[j].atan();
        }
    }

    // End the timer
    let duration = start.elapsed();

    println!(
        "Time Evaluate Function ({}): {:.6} s",
        n,
        duration.as_secs_f64()
    );
}
