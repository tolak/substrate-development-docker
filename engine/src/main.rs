mod cli;

use cli as engine_cli;
use std::process::Command;

fn main() {
    let mut command = String::from("docker ");
    let args = engine_cli::parse_args().expect("Parse command f");
    command.push_str(&args);
    println!("Command line to be executed: {:?}", &command);

    let output = if cfg!(target_os = "windows") {
        Command::new("cmd")
            .args(["/C", &command])
            .spawn()
            .expect("failed to execute process")
    } else {
        Command::new("sh")
            .arg("-c")
            .arg(&command)
            .spawn()
            .expect("failed to execute process")
    };

    println!("Output: ${:?}, ", output);
}
