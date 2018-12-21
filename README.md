# albuild-mozc

A set of prebuilt Mozc binaries for Amazon Linux 2.

## Install (Amazon WorkSpaces)

1. Download the prebuilt package from [the Release page](https://github.com/albuild/mozc/releases/tag/v0.2.0).

1. Install the package.

    ```
    sudo yum install -y albuild-mozc-0.2.0-1.amzn2.x86_64.rpm
    ```

1. Logout and login.

1. Run `ibus-setup` and add "Japanese - Mozc" in the Input Method tab.

## Build (Amazon WorkSpaces)

### System Requirements

* Docker

### Instructions

1. Clone this repository.

    ```
    git clone https://github.com/albuild/mozc.git
    ```

1. Go to the repository.

    ```
    cd mozc
    ```

1. Build a new image.

    ```
    bin/build
    ```

1. Extract a built package from the built image. The package will be copied to the ./rpm directory.

    ```
    bin/cp
    ```

1. Delete the built image.

    ```
    bin/rmi
    ```
