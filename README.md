# OpenTitan

This repository contains hardware, software and utilities written as part of the
OpenTitan project. It is structured as monolithic repository, or "monorepo",
where all components live in one repository.

## Documentation

The project contains comprehensive documentation of all IPs and tools. You can
either access it [online](https://bubble.servers.lowrisc.org/) or build it
locally by following the steps below.

1. Ensure that you have the required Python modules installed (to be executed
in the repository root):

```command
$ sudo apt install python3 python3-pip
$ pip3 install --user -r python-requirements.txt
```

2. Execute the build script:

```command
$ ./util/build_docs.py --preview
```

This compiles the documentation into `./opentitan-docs` and starts a local
server, which allows you to access the documentation at
[http://127.0.0.1:5500](http://127.0.0.1:5500).

## How to contribute

Have a look at [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines how to
contribute code to this repository.

## Licensing

Unless otherwise noted, everything in this repository is covered by the Apache
License, Version 2.0 (see [LICENSE](LICENSE) for full text).
