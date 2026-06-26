
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

    // Allocate the 3D array using our helper function
    let mut a = make_3d_double_arr(dim, dim, 3);

    let mut rng = rand::thread_rng();

    // Fill the array with random numbers between 0.0 and 1.0
    for i in 0..dim {
        for j in 0..dim {
            for k in 0..3 {
                a[i][j][k] = rng.gen::<f64>();
            }
        }
    }

    // Start the timer
    let start = Instant::now();

    // Perform the copy operations
    for i in 0..dim {
        for j in 0..dim {
            a[i][j][0] = a[i][j][1];
            a[i][j][2] = a[i][j][0];
            a[i][j][1] = a[i][j][2];
        }
    }

    // End the timer
    let duration = start.elapsed();

    println!(
        "Time for matrix copy ({}): {:.6} s",
        dim,
        duration.as_secs_f64()
    );
}

/// Creates a dynamically allocated 3D vector of f64.
/// This safely implements the equivalent of your `make_3D_double_arr` C function.
fn make_3d_double_arr(arr_size_x: usize, arr_size_y: usize, arr_size_z: usize) -> Vec<Vec<Vec<f64>>> {
    vec![vec![vec![0.0f64; arr_size_z]; arr_size_y]; arr_size_x]
}
