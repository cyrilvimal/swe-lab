<#
.SYNOPSIS
    Creates a clean Software Engineering Lab repository structure.

.DESCRIPTION
    1. Validates that the script is run from the repository root.
    2. Renames the existing "source" directory to a timestamped backup.
    3. Creates the recommended separation-of-concerns folder structure.
    4. Creates README.md files at the root and each meaningful nested level.
    5. Creates repository hygiene files:
       - .gitignore
       - LICENSE placeholder
       - CONTRIBUTING.md
       - SECURITY.md
       - .github/pull_request_template.md
       - .github/ISSUE_TEMPLATE/bug-report.md
       - .github/ISSUE_TEMPLATE/topic-request.md
       - .github/workflows/markdown-lint.yml
       - .github/dependabot.yml
    6. Does NOT move or delete content from the source backup.

.NOTES
    Run this script from the repository root.
    Example:
        cd C:\path\to\cyrilrepo
        .\setup-swe-lab.ps1

    Use -Force to run when the destination folders already exist.
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = (Get-Location).Path
$RepoName = Split-Path $RepoRoot -Leaf

Write-Host ""
Write-Host "Software Engineering Lab repository setup" -ForegroundColor Cyan
Write-Host "Repository: $RepoRoot"
Write-Host ""

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

function Write-FileUtf8 {
    param(
        [Parameter(Mandatory)] [string]$Path,
        [Parameter(Mandatory)] [string]$Content
    )

    $parent = Split-Path -Parent $Path
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    # UTF-8 without BOM, compatible with modern Git/GitHub tooling.
    [System.IO.File]::WriteAllText(
        $Path,
        $Content.TrimStart() + [Environment]::NewLine,
        [System.Text.UTF8Encoding]::new($false)
    )
}

function New-DirectoryIfMissing {
    param([Parameter(Mandatory)] [string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        if ($PSCmdlet.ShouldProcess($Path, "Create directory")) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
    }
}

function New-ReadmeIfMissing {
    param(
        [Parameter(Mandatory)] [string]$Directory,
        [Parameter(Mandatory)] [string]$Content
    )

    $path = Join-Path $Directory 'README.md'

    if ((Test-Path -LiteralPath $path) -and -not $Force) {
        Write-Host "  Skipping existing: $path" -ForegroundColor DarkYellow
        return
    }

    if ($PSCmdlet.ShouldProcess($path, "Create README.md")) {
        Write-FileUtf8 -Path $path -Content $Content
    }
}

function New-PlaceholderIfMissing {
    param(
        [Parameter(Mandatory)] [string]$Path,
        [Parameter(Mandatory)] [string]$Content
    )

    if ((Test-Path -LiteralPath $Path) -and -not $Force) {
        Write-Host "  Skipping existing: $Path" -ForegroundColor DarkYellow
        return
    }

    if ($PSCmdlet.ShouldProcess($Path, "Create file")) {
        Write-FileUtf8 -Path $Path -Content $Content
    }
}

# ---------------------------------------------------------------------------
# Safety checks
# ---------------------------------------------------------------------------

$gitDir = Join-Path $RepoRoot '.git'
$sourceDir = Join-Path $RepoRoot 'source'

if (-not (Test-Path -LiteralPath $gitDir -PathType Container)) {
    throw "This does not appear to be a Git repository root: $RepoRoot`nRun the script from the directory containing .git."
}

if (-not (Test-Path -LiteralPath $sourceDir -PathType Container)) {
    Write-Warning "The existing 'source' directory was not found. The backup step will be skipped."
}

# ---------------------------------------------------------------------------
# Backup source
# ---------------------------------------------------------------------------

if (Test-Path -LiteralPath $sourceDir -PathType Container) {
    $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backupName = "source-old-$timestamp"
    $backupDir = Join-Path $RepoRoot $backupName

    if ($PSCmdlet.ShouldProcess($sourceDir, "Rename to $backupName")) {
        Rename-Item -LiteralPath $sourceDir -NewName $backupName
        Write-Host "Backed up existing source -> $backupName" -ForegroundColor Green
    }
} else {
    Write-Host "No source directory to back up." -ForegroundColor Yellow
}

# ---------------------------------------------------------------------------
# Recommended repository structure
# ---------------------------------------------------------------------------

$directories = @(
    'docs',
    'docs\learning-paths',
    'docs\architecture',
    'docs\engineering-principles',
    'docs\troubleshooting',
    'docs\cheat-sheets',
    'docs\glossary',

    'programming',
    'programming\cpp',
    'programming\csharp',
    'programming\python',
    'programming\powershell',
    'programming\bash',
    'programming\programming-fundamentals',

    'dotnet',
    'dotnet\dotnet-core',
    'dotnet\aspnet',
    'dotnet\wcf',
    'dotnet\dependency-injection',
    'dotnet\configuration',
    'dotnet\diagnostics',

    'architecture',
    'architecture\design-patterns',
    'architecture\solid',
    'architecture\clean-code',
    'architecture\clean-architecture',
    'architecture\domain-driven-design',
    'architecture\microservices',
    'architecture\distributed-systems',
    'architecture\system-design',

    'databases',
    'databases\sql',
    'databases\sql-server',
    'databases\postgresql',
    'databases\nosql',
    'databases\redis',
    'databases\data-modeling',
    'databases\performance',

    'devops',
    'devops\git',
    'devops\github',
    'devops\ci-cd',
    'devops\docker',
    'devops\kubernetes',
    'devops\infrastructure-as-code',
    'devops\artifact-management',
    'devops\observability',

    'cloud',
    'cloud\azure',
    'cloud\aws',
    'cloud\gcp',
    'cloud\cloud-architecture',
    'cloud\cloud-security',

    'operating-systems',
    'operating-systems\linux',
    'operating-systems\windows',
    'operating-systems\powershell',
    'operating-systems\virtualization',

    'networking',
    'networking\fundamentals',
    'networking\tcp-ip',
    'networking\http',
    'networking\dns',
    'networking\proxies',
    'networking\troubleshooting',

    'security',
    'security\application-security',
    'security\authentication',
    'security\authorization',
    'security\certificates',
    'security\secrets-management',
    'security\secure-coding',

    'testing',
    'testing\unit-testing',
    'testing\integration-testing',
    'testing\api-testing',
    'testing\ui-testing',
    'testing\performance-testing',
    'testing\test-automation',

    'algorithms',
    'algorithms\data-structures',
    'algorithms\algorithms',
    'algorithms\concurrency',
    'algorithms\performance',

    'projects',
    'projects\examples',
    'projects\experiments',
    'projects\prototypes',
    'projects\reference-implementations',

    'labs',
    'labs\cpp',
    'labs\dotnet',
    'labs\python',
    'labs\docker',
    'labs\linux',
    'labs\distributed-systems',

    '.github',
    '.github\workflows',
    '.github\ISSUE_TEMPLATE'
)

foreach ($dir in $directories) {
    New-DirectoryIfMissing -Path (Join-Path $RepoRoot $dir)
}

# ---------------------------------------------------------------------------
# README content
# ---------------------------------------------------------------------------

$rootReadme = @'
# Software Engineering Lab

> A practical knowledge base of software engineering concepts, experiments, reference implementations, and technical notes.

Welcome to my **Software Engineering Lab**.

This repository is my continuously evolving engineering notebook — a place to learn, experiment, implement, document, and revisit concepts across software development and modern engineering practices.

It combines **theory with working code**, with an emphasis on understanding not only *how* something works, but also **why it exists, when to use it, and what trade-offs it introduces**.

## What You'll Find Here

| Area | Topics |
|---|---|
| Programming | C++, C#, Python, PowerShell, Bash |
| Architecture | Design Patterns, SOLID, Clean Architecture, DDD |
| .NET | .NET, ASP.NET, WCF, Dependency Injection, Diagnostics |
| DevOps | Git, GitHub, CI/CD, Docker, Kubernetes |
| Cloud | Azure, AWS, GCP, Cloud Architecture |
| Databases | SQL Server, PostgreSQL, NoSQL, Redis |
| Testing | Unit, Integration, API, Automation, Performance |
| Security | Authentication, Authorization, TLS, Certificates, Secure Coding |
| Networking | TCP/IP, HTTP, DNS, Proxies, Troubleshooting |
| Operating Systems | Linux, Windows, Virtualization |
| Algorithms | Data Structures, Algorithms, Concurrency, Performance |
| Distributed Systems | Messaging, Caching, Consistency, Resilience |
| Observability | Logging, Metrics, Tracing, Diagnostics |
| Tools | Visual Studio, VS Code, VirtualBox, Chocolatey, ProGet |
| Labs | Experiments, prototypes, proof-of-concepts, reference implementations |

## Repository Map

```text
software-engineering-lab/
│
├── programming/              # Languages and programming fundamentals
├── dotnet/                   # .NET ecosystem
├── architecture/             # Architecture and design
├── databases/                # Data and database engineering
├── devops/                   # DevOps, CI/CD and delivery
├── cloud/                    # Cloud platforms and architecture
├── operating-systems/        # Linux, Windows and virtualization
├── networking/               # Networking and communication
├── security/                 # Application and infrastructure security
├── testing/                  # Testing and automation
├── algorithms/               # Algorithms and computer science
├── docs/                     # Cross-cutting documentation
├── tools/                    # Developer and engineering tools
├── projects/                 # Larger examples and prototypes
└── labs/                     # Hands-on experiments
```

## Learning Philosophy

The repository follows:

**Understand → Implement → Experiment → Document → Revisit**

For each important topic, the goal is to capture:

- What it is
- Why it exists
- How it works
- When to use it
- When not to use it
- Practical implementations
- Design trade-offs
- Failure modes and troubleshooting
- Related concepts
- Further reading

The goal is not to collect code snippets.

The goal is to build **engineering intuition**.

## Architecture & Design

Topics include:

- SOLID principles
- Clean Code
- Refactoring
- Design Patterns
- Clean Architecture
- Hexagonal Architecture
- Domain-Driven Design
- Microservices
- Event-Driven Architecture
- Distributed Systems
- System Design
- Resilience and Fault Tolerance
- Scalability
- Observability

## Programming

Languages and programming concepts include:

- C++
- C#
- Python
- PowerShell
- Bash
- Object-oriented programming
- Functional programming concepts
- Memory management
- Concurrency
- Multithreading
- Asynchronous programming
- Error handling
- Performance
- Data structures
- Algorithms

## DevOps & Delivery

This repository also explores the systems used to build, package, test, release and operate software:

- Git and GitHub
- CI/CD
- Docker
- Kubernetes
- Package management
- Artifact repositories
- Infrastructure as Code
- Automation
- Release engineering
- Observability

## Testing & Quality

Testing topics include:

- Unit Testing
- Integration Testing
- API Testing
- Contract Testing
- UI Testing
- Test Automation
- Performance Testing
- Test Design
- Testability
- Mocking and Test Doubles
- CI test pipelines

## Security

Security is treated as a cross-cutting engineering concern.

Topics include:

- Authentication
- Authorization
- Identity
- OAuth
- TLS
- Certificates
- Secrets Management
- Secure Coding
- Application Security
- Dependency Security
- Security in CI/CD

**Never commit credentials, tokens, private keys, production configuration or sensitive information.**

## Labs & Experiments

The `labs/` directory contains hands-on experiments and proof-of-concepts.

Examples include:

- Technology evaluations
- Performance experiments
- Architecture prototypes
- Networking experiments
- Container experiments
- Automation scripts
- Troubleshooting reproductions
- Minimal reproducible examples

Labs are intentionally practical and may evolve as understanding improves.

## Engineering Notes

The `docs/` directory contains concepts that cut across multiple technologies:

```text
docs/
├── architecture/
├── engineering-principles/
├── learning-paths/
├── troubleshooting/
├── cheat-sheets/
└── glossary/
```

## Learning Paths

### Software Engineering Fundamentals

```text
Programming Fundamentals
        ↓
Data Structures & Algorithms
        ↓
Object-Oriented Design
        ↓
SOLID
        ↓
Design Patterns
        ↓
Clean Code & Refactoring
        ↓
Software Architecture
```

### Backend Engineering

```text
Programming
    ↓
.NET / Python / C++
    ↓
HTTP & Networking
    ↓
Databases
    ↓
API Design
    ↓
Testing
    ↓
Caching & Messaging
    ↓
Distributed Systems
```

### DevOps Engineering

```text
Git
 ↓
Build Systems
 ↓
Package Management
 ↓
CI/CD
 ↓
Containers
 ↓
Infrastructure as Code
 ↓
Cloud
 ↓
Observability
```

## Repository Principles

1. Prefer understanding over memorization.
2. Prefer simple solutions over unnecessary complexity.
3. Document the reasoning behind important decisions.
4. Show trade-offs, not just the preferred solution.
5. Keep examples small and focused.
6. Automate repetitive tasks where practical.
7. Treat security as part of engineering, not an afterthought.
8. Measure performance rather than assuming it.
9. Test behavior, not implementation details.
10. Continuously revisit and improve previous work.

## How to Use This Repository

**Learn** — Read the documentation and examples.

**Experiment** — Clone a lab and modify it.

**Compare** — Explore different implementations of the same concept.

**Revisit** — Use the repository as an engineering reference.

**Build** — Use examples as starting points for larger projects.

## Status

This is a **living repository**.

New technologies, experiments, notes and implementations will be added over time.

Some examples are intentionally small and educational rather than production-ready. Production systems require additional considerations such as security, resilience, observability, deployment strategy, operational support and compliance.

## Contributions

This is primarily a personal engineering knowledge base, but ideas, corrections, discussions and improvements are welcome.

If you spot an error or have a better approach, feel free to open an issue or pull request.

## About

**Cyril Vimal**

Software engineering enthusiast focused on building practical knowledge across programming, architecture, systems, automation, DevOps and modern software engineering practices.

GitHub: [@cyrilvimal](https://github.com/cyrilvimal)

> **Learn deeply. Build practically. Understand the trade-offs.**
'@

# ---------------------------------------------------------------------------
# Nested README map
# ---------------------------------------------------------------------------

$readmes = @{
    'docs' = @'
# Documentation

Cross-cutting engineering notes that are not tied to a single programming language or tool.

- `architecture/` — architecture concepts and decisions
- `engineering-principles/` — engineering practices and principles
- `learning-paths/` — structured paths through topics
- `troubleshooting/` — investigation and troubleshooting notes
- `cheat-sheets/` — concise command and concept references
- `glossary/` — terminology and definitions
'@

    'programming' = @'
# Programming

Programming languages, fundamentals, idioms, algorithms, concurrency and practical implementation techniques.

Each language should contain focused examples rather than unrelated code dumps.
'@

    'programming\cpp' = @'
# C++

C++ language experiments, idioms, memory management, STL, concurrency, performance and practical examples.
'@

    'programming\csharp' = @'
# C#

C# language features, idioms, object-oriented design, asynchronous programming, generics, LINQ and practical examples.
'@

    'programming\python' = @'
# Python

Python language fundamentals, standard library usage, automation, scripting, testing and practical examples.
'@

    'programming\powershell' = @'
# PowerShell

PowerShell scripting, automation, administration, remoting and reusable engineering utilities.
'@

    'programming\bash' = @'
# Bash

Bash scripting, Linux automation, command-line techniques and reusable shell utilities.
'@

    'programming\programming-fundamentals' = @'
# Programming Fundamentals

Core programming concepts independent of a specific language.

Topics may include abstraction, control flow, functions, data structures, error handling, memory, concurrency and complexity.
'@

    'dotnet' = @'
# .NET

Notes, examples and experiments covering the .NET ecosystem.

The emphasis is on practical engineering, application behavior, architecture, diagnostics and trade-offs.
'@

    'dotnet\dotnet-core' = @'
# .NET Core / Modern .NET

Modern .NET runtime and application development concepts, APIs, hosting, configuration and cross-platform development.
'@

    'dotnet\aspnet' = @'
# ASP.NET

Web application and API development using ASP.NET and related .NET technologies.
'@

    'dotnet\wcf' = @'
# WCF

Windows Communication Foundation concepts, service contracts, bindings, serialization, hosting, security and migration considerations.
'@

    'dotnet\dependency-injection' = @'
# Dependency Injection

Dependency Injection concepts, lifetimes, composition roots, testing and practical .NET implementations.
'@

    'dotnet\configuration' = @'
# Configuration

Application configuration, environment-specific settings, options patterns, secrets and configuration management.
'@

    'dotnet\diagnostics' = @'
# .NET Diagnostics

Diagnostics, logging, tracing, profiling, performance investigation and troubleshooting techniques.
'@

    'architecture' = @'
# Architecture

Software architecture concepts, design decisions, quality attributes, system boundaries and trade-offs.

The objective is to understand how architecture affects maintainability, scalability, reliability, security and delivery.
'@

    'architecture\design-patterns' = @'
# Design Patterns

Practical implementations and explanations of common software design patterns.

Each pattern should explain intent, applicability, implementation, trade-offs and alternatives.
'@

    'architecture\solid' = @'
# SOLID

Examples and notes for the SOLID principles, including practical benefits, limitations and common misapplications.
'@

    'architecture\clean-code' = @'
# Clean Code

Readable, maintainable and understandable code practices, including naming, structure, cohesion, coupling and refactoring.
'@

    'architecture\clean-architecture' = @'
# Clean Architecture

Experiments and notes around dependency direction, boundaries, use cases, domain logic and infrastructure isolation.
'@

    'architecture\domain-driven-design' = @'
# Domain-Driven Design

Concepts such as bounded contexts, entities, value objects, aggregates, domain services and ubiquitous language.
'@

    'architecture\microservices' = @'
# Microservices

Microservice boundaries, communication, deployment, observability, data ownership and operational trade-offs.
'@

    'architecture\distributed-systems' = @'
# Distributed Systems

Distributed computing concepts including consistency, availability, partition tolerance, replication, coordination and failure.
'@

    'architecture\system-design' = @'
# System Design

System-level design exercises covering scalability, reliability, data, APIs, caching, messaging, storage and operational concerns.
'@

    'databases' = @'
# Databases

Database technologies, data modeling, query design, indexing, transactions, consistency and performance.
'@

    'databases\sql' = @'
# SQL

SQL fundamentals, query design, joins, aggregation, transactions, window functions and query optimization concepts.
'@

    'databases\sql-server' = @'
# SQL Server

SQL Server administration, development, performance, indexing, transactions and troubleshooting notes.
'@

    'databases\postgresql' = @'
# PostgreSQL

PostgreSQL features, SQL, indexing, transactions, performance and practical database examples.
'@

    'databases\nosql' = @'
# NoSQL

Document, key-value, column-family and other non-relational database concepts and trade-offs.
'@

    'databases\redis' = @'
# Redis

Caching, key-value storage, expiration, data structures, messaging and distributed application patterns.
'@

    'databases\data-modeling' = @'
# Data Modeling

Relational and non-relational data modeling, normalization, denormalization, relationships and evolution.
'@

    'databases\performance' = @'
# Database Performance

Query plans, indexing, contention, caching, connection management and performance investigation.
'@

    'devops' = @'
# DevOps

Practices and technologies for building, testing, packaging, releasing and operating software reliably.
'@

    'devops\git' = @'
# Git

Version control concepts, branching, merging, rebasing, recovery, troubleshooting and practical workflows.
'@

    'devops\github' = @'
# GitHub

Repository management, collaboration, pull requests, Actions, security, automation and engineering workflows.
'@

    'devops\ci-cd' = @'
# CI/CD

Continuous integration and delivery concepts, pipeline design, quality gates, artifacts, deployments and rollback strategies.
'@

    'devops\docker' = @'
# Docker

Container fundamentals, images, Dockerfiles, networking, volumes, Compose and practical container workflows.
'@

    'devops\kubernetes' = @'
# Kubernetes

Container orchestration concepts, workloads, services, configuration, storage, networking and operations.
'@

    'devops\infrastructure-as-code' = @'
# Infrastructure as Code

Declarative infrastructure, reproducibility, environments, state, automation and infrastructure lifecycle management.
'@

    'devops\artifact-management' = @'
# Artifact Management

Package and artifact repositories, versioning, promotion, retention and secure software supply chains.
'@

    'devops\observability' = @'
# Observability

Logs, metrics, traces, correlation, alerting, dashboards and techniques for understanding running systems.
'@

    'cloud' = @'
# Cloud

Cloud platforms, architecture, infrastructure, security, reliability, cost and operational practices.
'@

    'cloud\azure' = @'
# Azure

Azure services, architecture patterns, automation, security and practical experiments.
'@

    'cloud\aws' = @'
# AWS

AWS services, architecture patterns, automation, security and practical experiments.
'@

    'cloud\gcp' = @'
# Google Cloud

GCP services, architecture patterns, automation, security and practical experiments.
'@

    'cloud\cloud-architecture' = @'
# Cloud Architecture

Cloud-native architecture, availability zones, scaling, resilience, networking, storage and cost trade-offs.
'@

    'cloud\cloud-security' = @'
# Cloud Security

Identity, least privilege, network controls, secrets, encryption, monitoring and secure cloud architecture.
'@

    'operating-systems' = @'
# Operating Systems

Operating-system concepts, administration, processes, services, filesystems, virtualization and troubleshooting.
'@

    'operating-systems\linux' = @'
# Linux

Linux administration, shell usage, processes, services, filesystems, networking and troubleshooting.
'@

    'operating-systems\windows' = @'
# Windows

Windows administration, services, networking, PowerShell, event logs, security and troubleshooting.
'@

    'operating-systems\powershell' = @'
# PowerShell

Windows and cross-platform automation using PowerShell.
'@

    'operating-systems\virtualization' = @'
# Virtualization

Virtual machines, snapshots, networking, resource allocation and automation using virtualization platforms.
'@

    'networking' = @'
# Networking

Networking fundamentals and practical troubleshooting for software engineers.
'@

    'networking\fundamentals' = @'
# Networking Fundamentals

OSI/TCP-IP concepts, addressing, routing, ports, sockets and common network behaviors.
'@

    'networking\tcp-ip' = @'
# TCP/IP

TCP, UDP, IP addressing, routing, ports, sockets and practical diagnostics.
'@

    'networking\http' = @'
# HTTP

HTTP methods, status codes, headers, TLS, cookies, caching, APIs and protocol behavior.
'@

    'networking\dns' = @'
# DNS

DNS resolution, records, caching, troubleshooting and common failure modes.
'@

    'networking\proxies' = @'
# Proxies

Forward proxies, reverse proxies, load balancing, TLS termination and troubleshooting.
'@

    'networking\troubleshooting' = @'
# Networking Troubleshooting

Repeatable methods for diagnosing connectivity, DNS, TLS, routing, proxy and service problems.
'@

    'security' = @'
# Security

Security concepts and practical engineering techniques.

Never store real credentials, private keys, production secrets or sensitive configuration here.
'@

    'security\application-security' = @'
# Application Security

Threats, secure design, validation, dependency risks, security testing and defensive engineering.
'@

    'security\authentication' = @'
# Authentication

Identity verification, sessions, tokens, credentials, certificates and authentication protocols.
'@

    'security\authorization' = @'
# Authorization

Permissions, roles, claims, policies, least privilege and access-control design.
'@

    'security\certificates' = @'
# Certificates

X.509 certificates, certificate chains, trust stores, lifecycle management and troubleshooting.
'@

    'security\secrets-management' = @'
# Secrets Management

Safe handling of passwords, API keys, tokens, certificates and other sensitive values.
'@

    'security\secure-coding' = @'
# Secure Coding

Practical coding practices for reducing vulnerabilities and improving application security.
'@

    'testing' = @'
# Testing

Software testing strategies and practical techniques for validating behavior and quality.
'@

    'testing\unit-testing' = @'
# Unit Testing

Fast, focused tests for isolated units of behavior.
'@

    'testing\integration-testing' = @'
# Integration Testing

Tests that validate interactions between components, services, databases and infrastructure.
'@

    'testing\api-testing' = @'
# API Testing

Functional, contract, negative, security and performance testing of APIs.
'@

    'testing\ui-testing' = @'
# UI Testing

End-to-end and user-interface automation with emphasis on stability and maintainability.
'@

    'testing\performance-testing' = @'
# Performance Testing

Load, stress, endurance and performance investigation techniques.
'@

    'testing\test-automation' = @'
# Test Automation

Automation frameworks, test infrastructure, reporting, CI integration and maintainable test design.
'@

    'algorithms' = @'
# Algorithms

Computer science fundamentals, algorithms, data structures, concurrency and performance.
'@

    'algorithms\data-structures' = @'
# Data Structures

Arrays, linked lists, stacks, queues, trees, graphs, hash tables and practical trade-offs.
'@

    'algorithms\algorithms' = @'
# Algorithms

Algorithmic techniques, complexity analysis, searching, sorting, graphs and problem solving.
'@

    'algorithms\concurrency' = @'
# Concurrency

Concurrency models, synchronization, race conditions, deadlocks, parallelism and asynchronous execution.
'@

    'algorithms\performance' = @'
# Performance

Big-O analysis, profiling, benchmarking, memory behavior and performance optimization.
'@

    'projects' = @'
# Projects

Larger examples, prototypes and reference implementations that combine multiple engineering concepts.

Projects should contain enough context to explain the problem, architecture, setup, usage and lessons learned.
'@

    'projects\examples' = @'
# Examples

Small but complete examples demonstrating a particular concept or technique.
'@

    'projects\experiments' = @'
# Experiments

Technology experiments used to answer specific engineering questions.
'@

    'projects\prototypes' = @'
# Prototypes

Proof-of-concepts and early implementations used to evaluate ideas before production development.
'@

    'projects\reference-implementations' = @'
# Reference Implementations

Focused implementations intended to demonstrate a clean approach to a recurring engineering problem.
'@

    'labs' = @'
# Labs

Hands-on experiments and minimal reproducible environments.

Labs favor practical investigation over production completeness.
'@

    'labs\cpp' = @'
# C++ Labs

Hands-on C++ experiments, language behavior, performance and systems programming.
'@

    'labs\dotnet' = @'
# .NET Labs

Hands-on .NET experiments, runtime behavior, APIs, diagnostics and architecture.
'@

    'labs\python' = @'
# Python Labs

Hands-on Python experiments, automation, scripting and tooling.
'@

    'labs\docker' = @'
# Docker Labs

Container experiments involving images, networking, volumes, Compose and automation.
'@

    'labs\linux' = @'
# Linux Labs

Hands-on Linux experiments, administration, networking, processes and troubleshooting.
'@

    'labs\distributed-systems' = @'
# Distributed Systems Labs

Experiments around messaging, retries, consistency, failure handling, caching and distributed behavior.
'@
}

foreach ($relativePath in $readmes.Keys) {
    $dir = Join-Path $RepoRoot $relativePath
    New-ReadmeIfMissing -Directory $dir -Content $readmes[$relativePath]
}

# Root README is handled separately so -Force behaves predictably.
New-PlaceholderIfMissing -Path (Join-Path $RepoRoot 'README.md') -Content $rootReadme

# ---------------------------------------------------------------------------
# .gitignore
# ---------------------------------------------------------------------------

$gitignore = @'
# -----------------------------------------------------------------------------
# OS / IDE
# -----------------------------------------------------------------------------

.DS_Store
Thumbs.db
desktop.ini

.vs/
.vscode/
.idea/
*.suo
*.user
*.userosscache
*.sln.docstates

# -----------------------------------------------------------------------------
# Build output
# -----------------------------------------------------------------------------

bin/
obj/
[Bb]uild/
[Bb]uildOutput/
Debug/
Release/
x64/
x86/
TestResults/
artifacts/
packages/

# Native/C++ build systems
CMakeFiles/
CMakeCache.txt
cmake_install.cmake
compile_commands.json
Makefile
*.sln.cache

# -----------------------------------------------------------------------------
# .NET
# -----------------------------------------------------------------------------

*.pdb
*.dll
*.exe
*.nupkg
*.snupkg

# Keep package-lock style source artifacts if intentionally committed.
!**/packages/*.config

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------

__pycache__/
*.py[cod]
*$py.class
*.pyo
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/
.tox/
.nox/
.venv/
venv/
env/
ENV/

# -----------------------------------------------------------------------------
# Node / JavaScript tooling if used by examples
# -----------------------------------------------------------------------------

node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# -----------------------------------------------------------------------------
# Logs / temporary files
# -----------------------------------------------------------------------------

*.log
*.tmp
*.temp
*.bak
*.swp
*.swo
*~

# -----------------------------------------------------------------------------
# Environment / secrets
# -----------------------------------------------------------------------------

.env
.env.*
!.env.example
*.secret
secrets/
secrets.*
*.pem
*.key
*.pfx
*.p12

# -----------------------------------------------------------------------------
# Certificates / credentials
# -----------------------------------------------------------------------------

*.crt
*.cer
*.der
*.jks
*.keystore

# -----------------------------------------------------------------------------
# Terraform / IaC
# -----------------------------------------------------------------------------

.terraform/
.terraform.lock.hcl
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json

# -----------------------------------------------------------------------------
# Docker / local runtime
# -----------------------------------------------------------------------------

docker-data/
docker-volumes/
*.pid

# -----------------------------------------------------------------------------
# Coverage / reports
# -----------------------------------------------------------------------------

coverage/
coverage.xml
*.coverage
*.trx
*.opencover.xml

# -----------------------------------------------------------------------------
# Local configuration
# -----------------------------------------------------------------------------

local.settings.json
appsettings.Local.json
appsettings.*.Local.json

# -----------------------------------------------------------------------------
# Virtualization
# -----------------------------------------------------------------------------

*.vdi
*.vmdk
*.vhd
*.vhdx
*.ova
*.ovf
*.sav
*.vmem

# -----------------------------------------------------------------------------
# Generated documentation / tooling caches
# -----------------------------------------------------------------------------

site/
.docfx/
.DS_Store

# -----------------------------------------------------------------------------
# Backup directories created by repository migration scripts
# Review before committing; these are intentionally ignored until migrated.
# -----------------------------------------------------------------------------

source-old-*/
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.gitignore') -Content $gitignore

# ---------------------------------------------------------------------------
# CONTRIBUTING.md
# ---------------------------------------------------------------------------

$contributing = @'
# Contributing

This repository is primarily a personal software engineering knowledge base, but corrections, ideas and improvements are welcome.

## Adding a Topic

Prefer the following structure for a substantial topic:

```text
topic/
├── README.md
├── examples/
├── exercises/
├── labs/
└── notes/
```

Keep examples small, focused and reproducible.

## Documentation Guidelines

A topic README should answer:

1. What is it?
2. Why does it exist?
3. How does it work?
4. When should it be used?
5. When should it not be used?
6. What are the trade-offs?
7. Is there a practical example?
8. What related concepts should be explored?

## Code Guidelines

- Prefer readable code over clever code.
- Explain non-obvious decisions.
- Keep examples independently runnable where practical.
- Avoid committing generated binaries or build output.
- Never commit credentials or secrets.

## Pull Requests

For changes, provide:

- What changed
- Why it changed
- How it was tested
- Any important trade-offs or limitations
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot 'CONTRIBUTING.md') -Content $contributing

# ---------------------------------------------------------------------------
# SECURITY.md
# ---------------------------------------------------------------------------

$security = @'
# Security

## Reporting a Security Issue

Please do not publish sensitive information, credentials, private keys, tokens or exploitable details in a public issue.

For sensitive issues, use a private communication channel associated with the repository owner.

## Repository Rules

Never commit:

- Passwords
- API keys
- Access tokens
- Private keys
- Production connection strings
- Certificates containing private material
- Cloud credentials
- Personal or customer data

Use placeholders or environment variables instead.

Example:

```text
DATABASE_CONNECTION_STRING=<set-in-environment>
API_TOKEN=<set-in-environment>
```

If a secret is accidentally committed, rotate/revoke it immediately. Removing the file in a later commit is not sufficient because the secret may remain in Git history.
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot 'SECURITY.md') -Content $security

# ---------------------------------------------------------------------------
# LICENSE placeholder
# ---------------------------------------------------------------------------

$license = @'
# License

Choose an appropriate open-source license before publishing this repository for reuse.

If this repository is intended to remain a personal knowledge base, consider whether a license is needed at all.

Do not replace this placeholder with a license until the intended reuse permissions have been decided.
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot 'LICENSE.md') -Content $license

# ---------------------------------------------------------------------------
# Pull request template
# ---------------------------------------------------------------------------

$prTemplate = @'
## Summary

Describe what changed and why.

## Type of Change

- [ ] New topic
- [ ] Documentation improvement
- [ ] Code example
- [ ] Lab / experiment
- [ ] Bug fix
- [ ] Refactoring
- [ ] Repository maintenance

## Validation

Describe how the change was tested or verified.

## Engineering Notes

Mention important assumptions, trade-offs, limitations or follow-up work.
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.github\pull_request_template.md') -Content $prTemplate

# ---------------------------------------------------------------------------
# Issue templates
# ---------------------------------------------------------------------------

$bugTemplate = @'
---
name: Bug report
about: Report an incorrect example, broken instruction or reproducible problem
title: "[Bug] "
labels: ""
assignees: ""
---

## Problem

Describe the issue.

## Expected Behavior

What should happen?

## Actual Behavior

What happens instead?

## Environment

- OS:
- Runtime/tool version:
- Relevant configuration:

## Reproduction

Provide the smallest reproducible example or steps.
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.github\ISSUE_TEMPLATE\bug-report.md') -Content $bugTemplate

$topicTemplate = @'
---
name: Topic request
about: Suggest a useful software engineering topic
title: "[Topic] "
labels: ""
assignees: ""
---

## Topic

What topic should be covered?

## Why It Matters

What engineering problem does it help explain?

## Suggested Scope

What concepts, examples or experiments would be useful?
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.github\ISSUE_TEMPLATE\topic-request.md') -Content $topicTemplate

# ---------------------------------------------------------------------------
# GitHub workflow
# ---------------------------------------------------------------------------

$markdownWorkflow = @'
name: Markdown Quality

on:
  push:
    branches: ["**"]
  pull_request:

permissions:
  contents: read

jobs:
  markdown:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Check Markdown files
        uses: DavidAnson/markdownlint-cli2-action@v20
        with:
          globs: |
            **/*.md
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.github\workflows\markdown-lint.yml') -Content $markdownWorkflow

# ---------------------------------------------------------------------------
# Dependabot
# ---------------------------------------------------------------------------

$dependabot = @'
version: 2
updates:
  - package-ecosystem: github-actions
    directory: /
    schedule:
      interval: monthly
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.github\dependabot.yml') -Content $dependabot

# ---------------------------------------------------------------------------
# .gitattributes
# ---------------------------------------------------------------------------

$gitattributes = @'
# Normalize text files to LF in Git.
* text=auto eol=lf

# Windows scripts and files.
*.ps1 text eol=crlf
*.bat text eol=crlf
*.cmd text eol=crlf

# Binary files.
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
*.zip binary
*.7z binary
*.gz binary
'@

New-PlaceholderIfMissing -Path (Join-Path $RepoRoot '.gitattributes') -Content $gitattributes

# ---------------------------------------------------------------------------
# Completion
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Repository structure created successfully." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Review the generated structure."
Write-Host "  2. Migrate content from the timestamped source-old-* backup."
Write-Host "  3. Review .gitignore before committing."
Write-Host "  4. Decide on the LICENSE."
Write-Host "  5. Rename the GitHub repository to your chosen name (for example: swe-lab)."
Write-Host "  6. Update the Git remote, for example:"
Write-Host "       git remote set-url origin https://github.com/cyrilvimal/swe-lab.git"
Write-Host "  7. Run:"
Write-Host "       git status"
Write-Host "       git add ."
Write-Host "       git commit -m ""chore: reorganize repository as software engineering lab"""
Write-Host "       git push"
Write-Host ""
Write-Host "Important: The old source directory was renamed, not deleted." -ForegroundColor Yellow
Write-Host "Review and migrate its contents before deleting the backup." -ForegroundColor Yellow
