
use std::env;
use std::process;
use std::time::Instant;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <N>", args[0]);
        process::exit(1);
    }

    // Parse the dimension from the command line
    let n: i32 = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: N must be a valid integer.");
            process::exit(1);
        }
    };

    let m = n;

    // --- Iterative Fibonacci ---
    let start = Instant::now();
    let iter_result = iterative_fib(n);
    let duration = start.elapsed();

    println!(
        "Iterative - Fibonacci ({}): {:.6} s --> {}",
        n,
        duration.as_secs_f64(),
        iter_result
    );

    // --- Recursive Fibonacci ---
    let start_rec = Instant::now();
    let rec_result = recursive_fib(m);
    let duration_rec = start_rec.elapsed();

    println!(
        "Recursive - Fibonacci ({}): {:.6} s --> {}",
        m,
        duration_rec.as_secs_f64(),
        rec_result
    );
}

/// Recursive Fibonacci returning an f64 (double)
fn recursive_fib(n: i32) -> f64 {
    if n <= 2 {
        1.0
    } else {
        recursive_fib(n - 2) + recursive_fib(n - 1)
    }
}

/// Iterative Fibonacci returning an i64 (long long int)
fn iterative_fib(mut n: i32) -> i64 {
    let mut fib_now: i64 = 0;
    let mut fib_next: i64 = 1;

    n -= 1;
    while n > 0 {
        let temp_fib = fib_now + fib_next;
        fib_now = fib_next;
        fib_next = temp_fib;
        n -= 1;
    }
    fib_next
}
