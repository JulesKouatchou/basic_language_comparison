
use std::env;
use std::f64::consts::PI;
use std::process;
use std::time::Instant;

const MAX_SWEEPS: usize = 10_000_000;

struct GridStruct {
    n: usize,
    dx: f64,
    x_min: f64,
    x_max: f64,
    dy: f64,
    y_min: f64,
    y_max: f64,
    h: f64,
    grid_epsilon: f64,
}

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage:\n    {} dim", args[0]);
        process::exit(-1);
    }

    // Parse the dimension from the command line
    let n: usize = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: dim must be a valid integer.");
            process::exit(-1);
        }
    };

    let start = Instant::now();

    let x_min = 0.0;
    let x_max = 1.0;
    let y_min = 0.0;
    let y_max = 1.0;
    let epsilon = 1.0e-6;

    let dx = (x_max - x_min) / (n as f64);
    let dy = (y_max - y_min) / (n as f64);
    let h = dx;

    let grid = GridStruct {
        n,
        dx,
        x_min,
        x_max,
        dy,
        y_min,
        y_max,
        h,
        grid_epsilon: epsilon * h.sqrt(),
    };

    // Allocate and zero out the 2D array (Vec<Vec<f64>>)
    let mut u = vec![vec![0.0f64; n]; n];

    implement_bcs(&grid, &mut u);

    let mut err = 1000.0;
    let mut sweep = 0;

    // Perform the Jacobi/Gauss-Seidel iterations
    while sweep < MAX_SWEEPS && err > grid.grid_epsilon {
        err = time_step_4_jacobi(&grid, &mut u);
        sweep += 1;
    }

    let duration = start.elapsed();

    println!("     Number of sweeps ({}): ", sweep);
    println!(
        "Time Jacobi Iteration ({}): {:.6} s",
        n,
        duration.as_secs_f64()
    );
}

fn implement_bcs(grid: &GridStruct, u: &mut [Vec<f64>]) {
    let n = grid.n;
    let x_min = grid.x_min;
    let h = grid.h;

    for j in 0..n {
        let x = x_min + (j as f64) * h;
        u[j][0] = (PI * x).sin();
        u[j][n - 1] = (PI * x).sin() * (-PI).exp();
    }
}

fn time_step_4_jacobi(grid: &GridStruct, u: &mut [Vec<f64>]) -> f64 {
    let n = grid.n;
    let mut err = 0.0;

    for i in 1..n - 1 {
        for j in 1..n - 1 {
            let tmp = u[j][i];

            // 9-point stencil update
            u[j][i] = (4.0 * (u[j - 1][i] + u[j + 1][i] + u[j][i - 1] + u[j][i + 1])
                + u[j - 1][i - 1]
                + u[j + 1][i + 1]
                + u[j + 1][i - 1]
                + u[j - 1][i + 1])
                / 20.0;

            let diff = u[j][i] - tmp;
            err += diff * diff;
        }
    }
    err
}
