mod cli;

use cli as engine_cli;
use std::process::Command;

fn main() {
    let command = "docker ";
    let args = engine_cli::parse_args().expect("Parse command f");

    let output = Command::new(command)
        .arg(args)
        .output()
        .expect("Command execution failed");
    println!("Output: ${:?}, ", String::from_utf8(output.stdout));
}
