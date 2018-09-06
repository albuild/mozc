# albuild-mozc

A set of prebuilt Mozc binaries for Amazon Linux 2.

## Install (Amazon WorkSpaces)

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

1. Extract rpm from the built image.

    ```
    bin/cp
    ```

1. Install rpm.

    ```
    sudo yum install -y rpm/albuild-mozc-0.1.0-1.amzn2.x86_64.rpm
    ```

1. (Optional) Delete the built image.

    ```
    bin/rmi
    ```

1. Make a symlink to mozc.xml.

    ```
    sudo ln -s /opt/albuild-mozc/0.1.0/mozc.xml /usr/share/ibus/component/mozc.xml
    ```

1. Logout and login.

1. Run `ibus-setup` and add "Japanese - Mozc" in the Input Method tab.
