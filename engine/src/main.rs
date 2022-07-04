mod cli;

use clap::Parser;
use cli as engine_cli;
use docker_api::{api::ContainerCreateOpts, Docker, Result as DockerResult};

#[cfg(unix)]
pub fn new_docker() -> DockerResult<Docker> {
    Ok(Docker::unix("/var/run/docker.sock"))
}

#[cfg(not(unix))]
pub fn new_docker() -> Result<Docker> {
    Docker::new("tcp://127.0.0.1:8080")
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args = engine_cli::Cli::try_parse().expect("Invalid commands");
    let docker = new_docker()?;

    let opts = if let Some(name) = args.name {
        ContainerCreateOpts::builder(args.image).name(name).build()
    } else {
        ContainerCreateOpts::builder(args.image).build()
    };

    tokio::task::spawn(async move {
        match docker.containers().create(&opts).await {
            Ok(info) => println!("{:?}", info),
            Err(e) => eprintln!("Error: {}", e),
        }
    });


    Ok(())
}
