# GitHub Copilot Instructions — Software Engineering Lab

## 1. Repository Identity

This repository is **Software Engineering Lab (`swe-lab`)**.

It is a continuously evolving personal software engineering knowledge base, experimentation environment, and collection of practical reference implementations.

The repository exists to:

* Learn software engineering concepts deeply.
* Implement concepts through practical examples.
* Experiment with technologies and engineering approaches.
* Document observations and lessons learned.
* Compare alternative approaches.
* Capture engineering trade-offs.
* Build reusable reference implementations.
* Develop practical engineering intuition over time.

This is **not intended to be a random collection of code snippets**.

The guiding lifecycle is:

> **Understand → Design → Implement → Experiment → Validate → Document → Revisit**

---

## 2. Core Engineering Philosophy

When contributing to this repository, prioritize:

1. Clarity over cleverness.
2. Understanding over memorization.
3. Simplicity over unnecessary abstraction.
4. Practical examples over theoretical explanation alone.
5. Explicit trade-offs over one-sided recommendations.
6. Reproducibility over environment-specific assumptions.
7. Security by default.
8. Testability and maintainability.
9. Automation where it reduces repetitive work.
10. Continuous improvement.

Do not introduce complexity merely to demonstrate a technology.

---

## 3. Repository Structure

Use the following high-level organization:

```text
swe-lab/
│
├── .github/                 # GitHub automation and Copilot instructions
│
├── docs/                    # Cross-cutting engineering documentation
│   ├── learning-paths/
│   ├── architecture/
│   ├── engineering-principles/
│   ├── troubleshooting/
│   ├── cheat-sheets/
│   └── glossary/
│
├── programming/             # Programming languages and fundamentals
│   ├── cpp/
│   ├── csharp/
│   ├── python/
│   ├── powershell/
│   ├── bash/
│   └── programming-fundamentals/
│
├── dotnet/                  # .NET ecosystem
│   ├── dotnet-core/
│   ├── aspnet/
│   ├── wcf/
│   ├── dependency-injection/
│   ├── configuration/
│   └── diagnostics/
│
├── architecture/            # Software architecture and design
│   ├── design-patterns/
│   ├── solid/
│   ├── clean-code/
│   ├── clean-architecture/
│   ├── domain-driven-design/
│   ├── microservices/
│   ├── distributed-systems/
│   └── system-design/
│
├── databases/               # Database engineering
│
├── devops/                  # Delivery and operations
│
├── cloud/                   # Cloud technologies and architecture
│
├── operating-systems/       # Linux, Windows and virtualization
│
├── networking/              # Networking concepts and troubleshooting
│
├── security/                # Security engineering
│
├── testing/                 # Testing and test automation
│
├── algorithms/              # Algorithms and computer science
│
├── projects/                # Larger examples and reference projects
│
├── labs/                    # Hands-on experiments and POCs
│
├── README.md
├── CONTRIBUTING.md
├── SECURITY.md
├── LICENSE.md
├── .gitignore
└── .gitattributes
```

Do not create new top-level directories casually.

First determine whether the content belongs in an existing category.

If a new category is genuinely required, explain why it is needed before introducing it.

---

## 4. Separation of Concerns

Keep different types of content separate.

### Concepts

Conceptual explanations belong under:

```text
docs/
```

or the relevant technology/domain directory.

### Source Code

Working examples belong under the relevant technology or project directory.

### Experiments

Experimental work belongs under:

```text
labs/
```

### Larger Implementations

Multi-concept implementations belong under:

```text
projects/
```

### Reusable Documentation

Cross-cutting guidance belongs under:

```text
docs/
```

Do not mix unrelated technologies in a single directory simply because they were learned together.

---

## 5. Topic Organization

A substantial topic should normally have its own `README.md`.

Example:

```text
architecture/
└── design-patterns/
    └── factory/
        ├── README.md
        ├── csharp/
        ├── cpp/
        └── notes/
```

The README should explain the topic before presenting implementation details.

---

## 6. Topic README Standard

When creating or substantially expanding a topic README, prefer this structure:

```markdown
# Topic

## Problem

What problem does this concept solve?

## What Is It?

Concise explanation.

## Why Does It Matter?

Engineering motivation.

## How It Works

Explain the mechanism.

## When to Use

Appropriate scenarios.

## When NOT to Use

Avoid inappropriate application.

## Example

Link to or describe the implementation.

## Trade-offs

### Advantages

### Disadvantages

## Common Mistakes

Common misconceptions or failure modes.

## Related Concepts

Links to related topics within the repository.

## Further Reading

Prefer authoritative external documentation.
```

Do not force every section when it adds no value. Use judgment.

---

## 7. Code Example Principles

Code in this repository should be:

* Small enough to understand.
* Focused on the concept being demonstrated.
* Runnable where practical.
* Explicit rather than unnecessarily clever.
* Consistent with the language's normal conventions.
* Accompanied by documentation explaining important decisions.

Avoid:

* Unexplained magic.
* Artificial abstractions.
* Excessive boilerplate.
* Copying large external examples.
* Production claims for educational prototypes.

If an example is intentionally simplified, say so.

---

## 8. Experiments and Labs

Labs should answer a specific engineering question.

A lab should preferably document:

```text
Question
   ↓
Hypothesis
   ↓
Setup
   ↓
Experiment
   ↓
Observation
   ↓
Result
   ↓
Conclusion
   ↓
Lessons Learned
```

For example:

> Does connection pooling significantly affect API throughput under concurrent load?

The lab should document the setup, measurement method, results and conclusion rather than merely containing source code.

---

## 9. Architecture and Design Decisions

When discussing architecture:

* Identify the problem first.
* State assumptions.
* Identify constraints.
* Consider alternatives.
* Explain trade-offs.
* Avoid presenting one architecture as universally correct.
* Consider maintainability, reliability, scalability, security, operability and cost where relevant.

Use Architecture Decision Records when a decision is significant.

Preferred location:

```text
docs/architecture/decisions/
```

Suggested ADR format:

```text
# ADR-XXXX: Decision Title

## Status

Proposed | Accepted | Superseded | Rejected

## Context

What problem are we solving?

## Decision

What was chosen?

## Alternatives Considered

What other approaches were evaluated?

## Consequences

What benefits and drawbacks result?
```

---

## 10. Testing

Examples should include tests where testing is meaningful.

Prefer testing:

* Behavior.
* Contracts.
* Important edge cases.
* Failure paths.
* Integration boundaries.

Avoid testing implementation details unnecessarily.

For examples involving performance, concurrency, networking or distributed systems, clearly distinguish:

* Demonstration
* Functional validation
* Benchmark
* Production-grade testing

Do not describe an unmeasured implementation as "high performance".

---

## 11. Security

Security is a mandatory engineering concern.

Never add or commit:

* Passwords
* API keys
* Access tokens
* Private keys
* Production secrets
* Customer data
* Personal sensitive information
* Real connection strings containing credentials

Use placeholders:

```text
API_TOKEN=<set-in-environment>
DATABASE_CONNECTION_STRING=<set-in-environment>
```

Prefer environment variables, secret stores or GitHub Secrets for sensitive configuration.

If existing code appears to contain a secret, do not reproduce it. Flag the issue and recommend rotation/removal.

---

## 12. External Documentation

When external documentation is needed:

* Prefer official documentation.
* Prefer primary sources.
* Prefer standards/specifications for protocol behavior.
* Prefer authoritative vendor documentation for vendor-specific behavior.
* Avoid copying external documentation into this repository.
* Summarize concepts in your own words.
* Include links where useful.

Do not invent citations, URLs, APIs or configuration options.

---

## 13. Technology Currency

Software technologies evolve.

When adding or modifying content involving versions, APIs, commands, frameworks, cloud services or vendor-specific behavior:

* Verify the current behavior when possible.
* Clearly state the relevant version.
* Avoid assuming that old behavior remains current.
* Do not silently modernize an example if the purpose is to document historical behavior.

If an example intentionally uses an older technology, document why.

---

## 14. Naming Conventions

Prefer:

* lowercase directory names
* kebab-case for multi-word directories
* `README.md` consistently
* descriptive filenames
* standard language conventions for source files

Examples:

```text
design-patterns/
clean-architecture/
distributed-systems/
test-automation/
```

Avoid inconsistent names such as:

```text
DesignPatterns/
designPatterns/
DP/
misc/
stuff/
temp/
new/
old/
```

Avoid vague directory names unless they have a clearly defined purpose.

---

## 15. Documentation Style

Documentation should be:

* Clear.
* Concise.
* Technically accurate.
* Structured.
* Practical.
* Easy to scan.

Prefer:

```text
Problem
Concept
Example
Trade-offs
Lessons
```

over unnecessarily long theoretical explanations.

Use tables when comparing alternatives.

Use diagrams when relationships or flows are difficult to explain with text.

---

## 16. Cross-Linking

When adding a topic related to an existing topic, link the concepts.

For example:

```markdown
See also:

- [SOLID Principles](../solid/README.md)
- [Dependency Injection](../../dotnet/dependency-injection/README.md)
- [Clean Architecture](../clean-architecture/README.md)
```

Avoid duplicating the same explanation in multiple locations.

Prefer one authoritative explanation with links from related topics.

---

## 17. Git Hygiene

Do not commit:

* Build output.
* IDE caches.
* Temporary files.
* Local environment files.
* Generated binaries.
* Credentials.
* Secrets.
* Large unnecessary artifacts.

Before suggesting a commit, check the conceptual scope of the change.

Prefer focused commits such as:

```text
docs: add factory pattern notes
feat: add docker networking lab
test: add retry policy examples
refactor: reorganize dotnet examples
chore: update repository tooling
```

Avoid vague commits such as:

```text
update
changes
misc
stuff
fix
```

---

## 18. Repository Reorganization

When reorganizing content:

1. Preserve existing information.
2. Avoid unnecessary duplication.
3. Identify the correct domain first.
4. Move related content together.
5. Update affected links.
6. Update relevant README files.
7. Check for broken references.
8. Review Git status before committing.
9. Keep migration backups outside the final repository unless intentionally required.

Do not delete content merely because its current location is inconvenient.

---

## 19. Adding New Technologies

Before introducing a new technology:

1. Determine the engineering problem it addresses.
2. Identify its natural repository category.
3. Create a focused directory.
4. Add a README.
5. Add a minimal example.
6. Document setup requirements.
7. Document trade-offs.
8. Link related topics.

Do not create a directory merely because a technology was mentioned once.

---

## 20. Continuous Improvement

Treat this repository as a living engineering system.

When modifying existing content, look for opportunities to improve:

* Accuracy
* Readability
* Navigation
* Test coverage
* Reproducibility
* Security
* Documentation
* Cross-linking
* Naming consistency

However, avoid unrelated refactoring.

Keep changes focused on the user's requested objective.

---

## 21. Copilot Behavior

When working in this repository, Copilot should:

1. Understand the existing structure before creating files.
2. Reuse existing conventions.
3. Search for related content before duplicating it.
4. Prefer modifying an existing topic over creating a competing topic.
5. Explain significant structural decisions.
6. Preserve existing user work.
7. Avoid destructive operations unless explicitly requested.
8. Avoid introducing dependencies without justification.
9. Avoid unnecessary frameworks or abstractions.
10. Keep educational examples understandable.
11. Flag assumptions.
12. Identify security risks.
13. Identify version-sensitive behavior.
14. Suggest tests when appropriate.
15. Update documentation when behavior or structure changes.

When uncertain about where content belongs, prefer the smallest existing appropriate category and explain the reasoning.

---

## 22. Definition of Done

A new topic is generally considered complete when:

* [ ] The topic is in the correct directory.
* [ ] A README explains the concept.
* [ ] The problem and motivation are clear.
* [ ] A practical example exists where appropriate.
* [ ] Important trade-offs are documented.
* [ ] Tests exist where meaningful.
* [ ] Setup instructions are reproducible.
* [ ] Related repository topics are linked.
* [ ] No secrets or sensitive information are present.
* [ ] Naming follows repository conventions.
* [ ] Existing documentation has been updated where necessary.
* [ ] Git changes are focused and reviewable.

Not every checklist item is mandatory for a tiny note or experiment; use engineering judgment.

---

## 23. Default Decision Rule

When choosing between two reasonable approaches, prefer the one that:

1. Makes the repository easier to understand.
2. Makes the example easier to reproduce.
3. Minimizes unnecessary complexity.
4. Preserves separation of concerns.
5. Makes trade-offs visible.
6. Is easier to maintain.
7. Teaches a transferable engineering principle.

---

## 24. Final Principle

This repository should continuously answer four questions:

> **What did I learn?**

> **How did I prove or implement it?**

> **What trade-offs did I discover?**

> **How can the next engineer understand it quickly?**

Optimize every contribution toward those questions.
