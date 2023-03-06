use rulinalg::utils;
use rand_distr::{Normal, Distribution};
use rand;
use std::fs;
use std::fs::File;
use std::io::{BufWriter, Write};
// use duration_string::DurationString;

// define out main struct which contains the model's parameters
struct Single {
    alpha: f64,
    gamma: f64,
    sigma: f64,
    output_interference: f64,
}

// number of items and simulations are constant
const N_ITEMS: usize = 6;
const N_SIM: usize = 10_000;

// that's our main function, launchs the model
fn main() {

    // used to benchmark our code 
    use std::time::Instant;
    let now = Instant::now();
    
    // create struct to pass as less arguments as possible
    let s = Single {
        alpha: 10.0, // peak of primacy gradient
        gamma: 0.9, // steepness of primacy gradient
        sigma: 0.5, // noise parameter
        output_interference: 0.8, // strength of output interference
    };
    
    // laucn the main function and score the score
    let score: [f64; N_ITEMS] = core(&s);

    // benchmarking + printing model's output
    let elapsed = now.elapsed();
    println!("Elapsed: {:.2?}", elapsed);
    println!("{:?}", score);

    fs::write("results/output.txt", elapsed.as_millis().to_string()).expect("Unable to write file");

    let file = File::create("results/score.txt").unwrap();
    let mut file = BufWriter::new(file);
    for value in score {
        writeln!(file, "{}", value.to_string());
    }

    // fs::write("results/score.txt", ["a", "b", "c"].join("\n")).expect("Unable to write file");
    
}

// core function of the model that performs the actual computation
fn core(s: &Single) -> [f64; N_ITEMS] {
    
    // pre-allocate normal distribution, score, and primacy gradient
    let normal = Normal::new(0.0, s.sigma).unwrap();    
    let mut score = [0.0; N_ITEMS];
    let gradient: [f64; N_ITEMS] = gen_gradient(&s);

    // iterate over number of simulations
    for _epoch in 0..N_SIM {

        // pre-allocate response suppression
        let mut r: [f64; N_ITEMS] = [1.0; N_ITEMS];
        // get the recalled items
        let recalled: [usize; N_ITEMS] = retrieval(s, &gradient, &mut r, normal);
        
        // analyze score
        for i in 0..N_ITEMS {
            if recalled[i] == i {
                score[i] += 1.0 / (N_SIM as f64);
            }            
        }
        
    }

    score
    
}

// generate our primacy gradient
fn gen_gradient(s: &Single) -> [f64; N_ITEMS] {
    
    let mut gradient = [0.0; N_ITEMS];
    for i in 0..N_ITEMS {
        gradient[i] = s.alpha - (s.gamma * i as f64);
    }
    
    gradient
    
}

// selects the most strongly activated item, after adding noise and applying output interference
fn selection(s: &Single, gradient: &[f64; N_ITEMS], r: &[f64; N_ITEMS], cnt: f64, normal: Normal<f64>) -> usize {
    
    let mut act = [0.0; N_ITEMS];
    for i in 0..N_ITEMS {
        // here we apply output interference
        act[i] += gradient[i] * s.output_interference.powf(cnt);
        // add noise
        act[i] += normal.sample(&mut rand::thread_rng());
        // response suppression
        act[i] *= r[i];
    }
    
    // return index of the most activated item
    utils::argmax(&act).0
    
}

fn retrieval(s: &Single, gradient: &[f64; N_ITEMS], r: &mut [f64; N_ITEMS], normal: Normal<f64>) -> [usize; N_ITEMS] {
    
    // retrieve items one by one
    let mut recalled: [usize; N_ITEMS] = [0; N_ITEMS];
    for i in 0..N_ITEMS {
        let idx: usize = selection(&s, &gradient, &r, i as f64, normal);
        r[idx] = 0.0;
        recalled[i] = idx;
    }

    recalled

}
