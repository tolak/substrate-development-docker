use clap::Parser;

#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    /// Port number wanna to bind with container, can be specified multiple times
    #[clap(short, long, value_parser)]
    pub port: Option<Vec<u32>>,

    /// Name of the container
    #[clap(short, long, value_parser)]
    pub name: Option<String>,

    /// Name of the docker image
    #[clap(short, long, value_parser)]
    pub image: String,
}
