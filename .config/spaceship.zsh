# Change the symbols used in the prompt
SPACESHIP_CHAR_SYMBOL="${SPACESHIP_CHAR_SYMBOL="|> "}"
SPACESHIP_PACKAGE_SYMBOL="${SPACESHIP_PACKAGE_SYMBOL=" "}"

# Custom prompt segments
## Define a custom section for Distrobox in Spaceship Prompt
SPACESHIP_DISTROBOX_SHOW="${SPACESHIP_DISTROBOX_SHOW=true}"
SPACESHIP_DISTROBOX_COLOR="${SPACESHIP_DISTROBOX_COLOR="#C678DD"}"
SPACESHIP_DISTROBOX_PREFIX="${SPACESHIP_DISTROBOX_PREFIX="on "}"
SPACESHIP_DISTROBOX_SUFFIX="${SPACESHIP_DISTROBOX_SUFFIX=" "}"
SPACESHIP_DISTROBOX_SYMBOL="${SPACESHIP_DISTROBOX_SYMBOL=" "}"

spaceship_distrobox() {
  # Check if a Distrobox environment variable is present.
  # DISTROBOX_ENTER_PATH is a common one set inside containers[citation:8].
  [[ -n "${DISTROBOX_ENTER_PATH}" ]] || return

  # Define the icon. Using the whale emoji as a Docker-like symbol.

  # Use $CONTAINER_ID if you prefer the ID[citation:10], or show a generic tag.
  # This example shows a simple tag. You can customize this line.
  local distrobox_status="$CONTAINER_ID"

  # Display the section
  # spaceship::section::v4 \
  spaceship::section \
    --color "$SPACESHIP_DISTROBOX_COLOR" \
    --prefix "$SPACESHIP_DISTROBOX_PREFIX" \
    --symbol "$SPACESHIP_DISTROBOX_SYMBOL" \
    --suffix "$SPACESHIP_DISTROBOX_SUFFIX" \
    "$distrobox_status"
}


SPACESHIP_PROMPT_ORDER=(
    time           # Time stamps section
    user           # Username section
    dir            # Current directory section
    host           # Hostname section
    distrobox       # Distrobox section
    git            # Git section (git_branch + git_status + [git_commit](default off))
    hg             # Mercurial section (hg_branch  + hg_status)
    package        # Package version
    haxe           # Haxe section
    node           # Node.js section
    rlang          # R section
    bun            # Bun section
    deno           # Deno section
    ruby           # Ruby section
    python         # Python section
    red            # Red section
    elm            # Elm section
    elixir         # Elixir section
    xcode          # Xcode section
    xcenv          # xcenv section
    swift          # Swift section
    swiftenv       # swiftenv section
    golang         # Go section
    perl           # Perl section
    php            # PHP section
    rust           # Rust section
    haskell        # Haskell Stack section
    scala          # Scala section
    kotlin         # Kotlin section
    java           # Java section
    lua            # Lua section
    dart           # Dart section
    julia          # Julia section
    crystal        # Crystal section
    docker         # Docker section
    docker_compose # Docker section
    aws            # Amazon Web Services section
    gcloud         # Google Cloud Platform section
    azure          # Azure section
    venv           # virtualenv section
    conda          # conda virtualenv section
    uv             # uv virtualenv section
    dotnet         # .NET section
    ocaml          # OCaml section
    vlang          # V section
    zig            # Zig section
    purescript     # PureScript section
    erlang         # Erlang section
    gleam          # Gleam section
    kubectl        # Kubectl context section
    ansible        # Ansible section
    terraform      # Terraform workspace section
    pulumi         # Pulumi stack section
    ibmcloud       # IBM Cloud section
    nix_shell      # Nix shell
    gnu_screen     # GNU Screen section
    exec_time      # Execution time
    async          # Async jobs indicator
    line_sep       # Line break
    battery        # Battery level and status
    jobs           # Background jobs indicator
    exit_code      # Exit code section
    sudo           # Sudo indicator
    char           # Prompt character
)
