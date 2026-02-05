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
    "$SPACESHIP_DISTROBOX_COLOR" \
    "$SPACESHIP_DISTROBOX_PREFIX" \
    "$SPACESHIP_DISTROBOX_SYMBOL$distrobox_status" \
    "$SPACESHIP_DISTROBOX_SUFFIX"
}


SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    gradle        # Gradle section
    maven         # Maven section
    package       # Package version
    node          # Node.js section
    ruby          # Ruby section
    elm           # Elm section
    elixir        # Elixir section
    xcode         # Xcode section
    swift         # Swift section
    golang        # Go section
    php           # PHP section
    rust          # Rust section
    haskell       # Haskell Stack section
    julia         # Julia section
    distrobox     # Distrobox section
    docker        # Docker section
    aws           # Amazon Web Services section
    gcloud        # Google Cloud Platform section
    venv          # virtualenv section
    conda         # conda virtualenv section
    pyenv         # Pyenv section
    dotnet        # .NET section
    ember         # Ember.js section
    kubectl       # Kubectl context section
    terraform     # Terraform workspace section
    ibmcloud      # IBM Cloud section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
)
