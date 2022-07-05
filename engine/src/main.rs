mod cli;

use bollard::{
    container::{Config, CreateContainerOptions, StartContainerOptions},
    image::CreateImageOptions,
    Docker,
};
use clap::Parser;
use cli as engine_cli;
use futures_util::TryStreamExt;
use std::default::Default;

const IMAGE: &str = "onfinality/subql-query";

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args = engine_cli::Cli::try_parse().expect("Invalid commands");
    let bollard_docker =
        Docker::connect_with_local_defaults().expect("failed to connect docker daemon");

    let opts = if let Some(name) = args.name {
        Some(CreateContainerOptions { name })
    } else {
        Some(CreateContainerOptions {
            name: String::from("default-name"),
        })
    };
    let config = Config {
        image: Some(IMAGE),
        cmd: None,
        ..Default::default()
    };

    bollard_docker
        .create_image(
            Some(CreateImageOptions {
                from_image: IMAGE,
                ..Default::default()
            }),
            None,
            None,
        )
        .try_collect::<Vec<_>>()
        .await?;
    let id = bollard_docker
        .create_container(opts.clone(), config)
        .await?
        .id;
    let _ = &bollard_docker
        .start_container(&id, None::<StartContainerOptions<String>>)
        .await?;

    // let container_task = tokio::task::spawn(async move {

    // });
    // container_task.await.expect("container task has panicked");

    Ok(())
}
