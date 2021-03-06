#!/usr/bin/env python3
# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
r"""Command-line tool to autogenerate boilerplate DV testbench code extended from dv_lib / cip_lib
"""
import argparse
import os
import sys

from uvmdvgen import gen_agent, gen_env


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        "name",
        metavar="[ip/block name]",
        help="Name of the ip/block for which the UVM TB is being auto-generated"
    )

    parser.add_argument(
        "-a",
        "--gen_agent",
        action='store_true',
        help="Generate UVM agent code extended from DV library")

    parser.add_argument(
        "-s",
        "--has_separate_host_device_driver",
        action='store_true',
        help=
        """IP / block agent creates a separate driver for host and device modes.
                              (ignored if -a switch is not passed)""")

    parser.add_argument(
        "-e",
        "--gen_env",
        action='store_true',
        help="Generate testbench UVM env code")

    parser.add_argument(
        "-c",
        "--is_cip",
        action='store_true',
        help=
        """Is comportable IP - this will result in code being extended from CIP
                              library. If switch is not passed, then the code will be extended from
                              DV library instead. (ignored if -e switch is not passed)"""
    )

    parser.add_argument(
        "-ea",
        "--env_agents",
        nargs="+",
        metavar="agt1 agt2",
        help="""Env creates an interface agent specified here. They are
                              assumed to already exist. Note that the list is space-separated,
                              and not comma-separated. (ignored if -e switch is not passed)"""
    )

    parser.add_argument(
        "-ao",
        "--agent_outdir",
        default="name",
        metavar="[hw/dv/sv]",
        help="""Path to place the agent code. A directory called <name>_agent is
                              created at this location. (default set to './<name>')"""
    )

    parser.add_argument(
        "-eo",
        "--env_outdir",
        default="name",
        metavar="[hw/ip/<ip>/dv]",
        help="""Path to place the env code. 3 directories are created - env,
                              tb and tests. (default set to './<name>')""")

    args = parser.parse_args()
    if args.agent_outdir == "name": args.agent_outdir = args.name
    if args.env_outdir == "name": args.env_outdir = args.name

    if args.gen_agent:
        gen_agent.gen_agent(args.name, \
                            args.has_separate_host_device_driver, \
                            args.agent_outdir)

    if args.gen_env:
        if not args.env_agents: args.env_agents = []
        gen_env.gen_env(args.name, \
                        args.is_cip, \
                        args.env_agents, \
                        args.env_outdir)


if __name__ == '__main__':
    main()
