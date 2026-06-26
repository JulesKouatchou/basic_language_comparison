
use std::env;
use std::fmt::Write;
use std::process;
use std::time::Instant;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <n>", args[0]);
        process::exit(1);
    }

    // Parse the number of iterations from the command line
    let n: usize = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Error: n must be a valid integer.");
            process::exit(1);
        }
    };

    let start = Instant::now();

    // Initial sequence
    let mut current_seq = String::from("1223334444");

    for _ in 0..n {
        let bytes = current_seq.as_bytes();

        // Pre-allocate memory to avoid multiple reallocations.
        // We guess it might roughly double in size.
        let mut next_seq = String::with_capacity(bytes.len() * 2);

        if !bytes.is_empty() {
            let mut count = 1;
            let mut current_char = bytes[0];

            for i in 1..bytes.len() {
                if bytes[i] == current_char {
                    count += 1;
                } else {
                    // Write directly into the buffer, similar to sprintf in C
                    write!(&mut next_seq, "{}{}", count, current_char as char).unwrap();
                    current_char = bytes[i];
                    count = 1;
                }
            }
            // Append the final block
            write!(&mut next_seq, "{}{}", count, current_char as char).unwrap();
        }

        current_seq = next_seq;
    }

    let duration = start.elapsed();

    // println!("sequence {} \n", current_seq);

    println!(
        "Time for look and say sequence ({}): {:.6} s",
        n,
        duration.as_secs_f64()
    );
}
