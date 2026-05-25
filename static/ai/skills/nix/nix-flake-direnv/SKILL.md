---
name: nix-flake-direnv
description: Create or update minimal flake.nix and .envrc files when the user explicitly asks for a Nix flake, direnv setup, or a lightweight dev shell in the current directory. Do not use for full project scaffolding, complex Nix packaging, multi-shell architectures, or CI/deployment setup.
---

Create the smallest useful Nix + direnv setup for the current directory.

Goals:

- Add `flake.nix` and `.envrc` only when needed.
- Keep the setup minimal and readable.
- Do not introduce extra files unless the user asks.

Behavior:

1. Inspect the current directory for existing `flake.nix`, `.envrc`, `.tool-versions`, `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, or similar signals.
2. If `flake.nix` already exists, prefer updating it carefully instead of replacing it wholesale.
3. If `.envrc` already exists, preserve unrelated content where possible.
4. Default to a generic dev shell if the stack is unclear.
5. Do not add overlays, flakes inputs beyond `nixpkgs` and `flake-utils` unless clearly needed.
6. Do not add formatting, linting, pre-commit, devenv, lorri, or shell hooks unless the user asks.
7. Explain any assumptions briefly.

Default files:

`flake.nix`

- Use a minimal dev shell.
- Prefer:
  - `nixpkgs`
  - `flake-utils`
- Include `mkShell`.
- Add only obvious packages inferred from the repo, for example:
  - Node project: `nodejs`
  - Python project: `python3`
  - Rust project: `rustc`, `cargo`
  - Go project: `go`
  - Make sure the tools in the `flake.nix` use the correct version

`.envrc`

- Prefer:
  `use flake`

Decision rules:

- If the project already has strong ecosystem cues, tailor the package list lightly.
- If signals are mixed or weak, generate a generic shell rather than guessing.
- If the user asks for "minimal", optimize for fewer dependencies and fewer comments.
- If the user asks for "production-ready" or "full setup", do not continue with this skill alone; ask whether they want a larger Nix architecture.

Output:

- Create or update `flake.nix`
- Create or update `.envrc`
- Briefly summarize what was added and any assumptions made
