
use rand::Rng;
use std::env;
use std::process;
use std::time::Instant;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <dim>", args[0]);
        process::exit(1);
    }

    // Parse the dimension from the command line
    let dim: usize = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: dim must be a valid integer.");
            process::exit(1);
        }
    };

    // Allocate the 2D arrays
    let mut a = make_2d_array_double(dim, dim);
    let mut b = make_2d_array_double(dim, dim);
    let mut c = make_2d_array_double(dim, dim);

    let mut rng = rand::rng();

    // Fill matrices A and B with random numbers between 0.0 and 1.0
    for i in 0..dim {
        for j in 0..dim {
            a[i][j] = rng.random::<f64>();
            b[i][j] = rng.random::<f64>();
        }
    }

    // Start the timer
    let start = Instant::now();

    // Perform the matrix multiplication (C = A * B)
    for i in 0..dim {
        for j in 0..dim {
            c[i][j] = 0.0;
        }
        for k in 0..dim {
            for j in 0..dim {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }

    // End the timer
    let duration = start.elapsed();

    println!(
        "time for C({dim},{dim}) = A({dim},{dim}) B({dim},{dim}) is {:.6} s",
        duration.as_secs_f64()
    );
}

/// Helper function to create a 2D vector initialized with zeros.
/// This replaces the nested mallocs from the C `make_2d_array_double` function.
fn make_2d_array_double(array_size_x: usize, array_size_y: usize) -> Vec<Vec<f64>> {
    vec![vec![0.0f64; array_size_y]; array_size_x]
}
