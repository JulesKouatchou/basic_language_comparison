

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

    // Parse the number from the command line
    let n: u32 = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: n must be a valid positive integer.");
            process::exit(1);
        }
    };

    let start = Instant::now();

    let mut i: u32 = 0;
    let mut c: u32 = 0;

    // Find the n-th pernicious number
    while c < n {
        if is_pernicious(i) == 1 {
            c += 1;
        }
        i += 1;
    }

    let duration = start.elapsed();

    // Note: i is decremented by 1 because the loop increments it one last time before exiting
    println!(
        "Pernicious number ({}): {:.6} s",
        i - 1,
        duration.as_secs_f64()
    );
}

/// Checks if a number is pernicious.
/// A pernicious number is a positive integer whose population count
/// (number of set bits) is a prime number.
fn is_pernicious(mut n: u32) -> u32 {
    // 32-bit integer with bits set at prime indices (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31)
    let mut c: u32 = 2_693_408_940;

    while n != 0 {
        c >>= 1;
        // Take out the lowest set bit one by one
        n &= n - 1;
    }

    c & 1
}
