mod cli;

use clap::Parser;
use cli as engine_cli;
use std::default::Default;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args = engine_cli::Cli::try_parse().expect("Invalid commands");

    // let container_task = tokio::task::spawn(async move {

    // });
    // container_task.await.expect("container task has panicked");

    Ok(())
}
