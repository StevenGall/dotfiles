---
name: context7-mcp
description: Use when writing or debugging code against a third-party library where training data may be stale — fast-moving frameworks (Next.js, LangChain, AI/LLM SDKs, Terraform providers, Jetpack Compose, etc.), versions newer than your knowledge cutoff, niche packages, or after code fails with missing-method / deprecation / wrong-signature errors. Also use when the user explicitly asks for current docs. Skip for stable, well-known tools (bash, git, jq, POSIX utilities, language standard libraries, SQL).
---

# Library Docs: Ground Truth First, Context7 Second

Goal: use the API that matches the version the project actually runs. Training data is often fine; reach for lookups when it is likely stale or has already proven wrong.

## Decide whether to look anything up

Look up docs when ANY of these hold:
- The library is fast-moving or released/majorly updated near or after your knowledge cutoff
- The project pins a version you're unsure about (check the lockfile)
- The library is niche enough that you aren't confident in its API
- A first attempt failed with "no such method/property", import errors, deprecation warnings, or type mismatches
- The user asks for current/official docs

Otherwise, answer from training data. Don't spend a lookup on stable APIs.

## Fallback order

### 1. Local ground truth (always try first when in a project)
This is the exact version in use and the only source that covers private/internal packages.
- **Version**: `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock`, `go.mod`, `requirements*.txt` / `uv.lock` / `poetry.lock`, `build.sbt` / `build.gradle(.kts)`, `Package.resolved`, `.terraform.lock.hcl`
- **API surface**: `node_modules/<pkg>/**/*.d.ts` and its README/CHANGELOG, `go doc <pkg>.<Symbol>`, `python -c "import x; help(x.y)"` or the site-packages source, `<tool> --help`
- If this answers the question, stop here.

### 2. Context7
1. `resolve-library-id` with the library name and the user's full question.
2. Pick the best match: exact/official package over forks; version-specific ID matching the version found in step 1 when available; higher benchmark score as a tiebreaker.
3. `query-docs` with that ID and a specific question.
4. Sanity-check the result against the local version. If Context7 returns the wrong library, the wrong major version, or nothing useful, go to step 3 — don't force it.

### 3. Official docs / changelog / migration guide
Fetch the library's official documentation or release notes directly (WebFetch / WebSearch), targeting the specific version.

### 4. Training data
If nothing above is available or conclusive, answer from training data and say so — note the version you're assuming and that it may be out of date.

## Output
- Cite the version the answer applies to and which source it came from (local source, Context7, official docs, or training data).
- Prefer code examples from the source you used over reconstructed ones.
