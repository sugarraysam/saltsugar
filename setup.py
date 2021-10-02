#!/usr/bin/env python

from setuptools import find_packages, setup

setup(
    author="Samuel Blais-Dowdy",
    author_email="samuel.blaisdowdy@protonmail.com",
    python_requires=">=3.9",
    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Natural Language :: English",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.9",
    ],
    description="Manage and maitain an ArchLinux workstation with Salt.",
    install_requires=[],
    license="Apache Software License 2.0",
    include_package_data=True,
    keywords="saltsugar",
    name="saltsugar",
    packages=find_packages(include=["saltsugar", "saltsugar.*"]),
    test_suite="tests",
    tests_require=["pytest~=6.2.5"],
    url="https://github.com/sugarraysam/saltsugar",
    version="0.1.0",
    zip_safe=False,
)
