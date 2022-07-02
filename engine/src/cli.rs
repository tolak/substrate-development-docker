use clap::{Error as ClapError, Parser};

#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    /// Port number wanna to bind with container, can be specified multiple times
    #[clap(short, long, value_parser)]
    port: Vec<u32>,

    /// Name of the container
    #[clap(short, long, value_parser, default_value = "parachain-container")]
    name: String,

    /// Name of the docker image
    #[clap(short, long, value_parser)]
    image: String,
}

pub fn parse_args() -> Result<String, ClapError> {
    let input = Cli::parse();
    let mut args: String = "run -it".to_owned();

    // Parse port number
    for port in input.port {
        args.push_str(&format!(" -p 127.0.0.1:{}:{}", port, port));
    }
    // Parse name of container
    args.push_str(&format!(" --name {}", input.name));
    // Parse name of docker images
    args.push_str(&format!(" {}", input.image));

    println!("args: {:?}", args);
    Ok(args)
}
