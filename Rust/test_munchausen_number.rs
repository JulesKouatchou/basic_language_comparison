

use std::time::Instant;

fn main() {
    // Array to cache the precomputed powers of digits
    let mut power_of_digits = [0; 10];

    // Start the timer
    let start = Instant::now();

    // Precompute the digit powers
    for i in 0..10 {
        power_of_digits[i] = raisedto(i as i32);
    }

    let mut n = 0;
    let mut i = 0;

    // Find the four Munchausen numbers
    while n < 4 {
        let mut sum = 0;
        let mut number = i;

        // Extract digits and sum their precomputed powers
        while number > 0 {
            let digit = (number % 10) as usize;
            sum += power_of_digits[digit];
            number /= 10;
        }

        // Check if the sum is equal to the number itself
        if sum == i {
            n += 1;
            println!("Munchausen number {}: {}", n, i);
        }

        i += 1;
    }

    // End the timer
    let duration = start.elapsed();
    println!("Munchausen numbers: {:.6} s", duration.as_secs_f64());
}

/// Calculates n^n, with the special convention that 0^0 = 0
fn raisedto(n: i32) -> i32 {
    if n == 0 {
        0
    } else {
        // Rust's integer pow takes a u32 for the exponent
        n.pow(n as u32)
    }
}

