# Demo: Stacked PRs For Complete Beginners

This demo creates a small local Git project and builds a stacked branch workflow:

```text
main -> notif-db -> notif-api -> notif-ui -> notif-cleanup
```

You can run the local demo without GitHub. The GitHub PR commands are included later as an optional step for a real repository.

## What You Need

- Windows PowerShell
- Git installed

You do not need Node.js, npm, GitHub CLI, or a GitHub account to run the local demo.

## Copy-Paste Local Demo

Open PowerShell, then copy and paste these commands:

```powershell
cd C:\Users\kabil\youtube-github-stacked-prs\demo
.\run-demo.ps1
```

If PowerShell blocks the script, run this command from the same folder:

```powershell
powershell -ExecutionPolicy Bypass -File .\run-demo.ps1
```

## What The Script Creates

After the script finishes, you will have:

```text
C:\Users\kabil\youtube-github-stacked-prs\demo\workspace\notification-settings-demo
C:\Users\kabil\youtube-github-stacked-prs\demo\terminal-transcript.txt
```

The first path is the generated demo Git repo. The second path is a transcript you can use while recording the video.

## Check The Result

Copy and paste these commands:

```powershell
cd C:\Users\kabil\youtube-github-stacked-prs\demo\workspace\notification-settings-demo
git branch
git log --graph --oneline --decorate --all
```

You should see branches like this:

```text
notif-cleanup
notif-ui
notif-api
notif-db
main
```

And the Git history should look like one stack:

```text
notif-cleanup   -> final cleanup layer
notif-ui        -> depends on notif-api
notif-api       -> depends on notif-db
notif-db        -> depends on main
main            -> first commit
```

## Open The Transcript

To view the exact terminal output:

```powershell
cd C:\Users\kabil\youtube-github-stacked-prs\demo
notepad .\terminal-transcript.txt
```

## Optional: Push The Demo To GitHub

Use this section when you want to create a real GitHub repository and open real stacked PRs.

For the copy-paste GitHub CLI path, you need:

- a GitHub account
- GitHub CLI installed
- `gh auth login` completed

If you do not use GitHub CLI, use the browser alternative below.

### Step 1: Go To The Generated Demo Repo

Copy and paste:

```powershell
cd C:\Users\kabil\youtube-github-stacked-prs\demo\workspace\notification-settings-demo
```

### Step 2A: Check GitHub CLI Login

Copy and paste:

```powershell
gh auth status
```

If you are not logged in, copy and paste:

```powershell
gh auth login
```

Follow the prompts in the terminal.

### Step 3A: Create A New Remote GitHub Repo With GitHub CLI

Copy and paste:

```powershell
gh repo create notification-settings-demo --private --source . --remote origin --description "Demo repo for stacked pull requests"
```

This creates a private GitHub repository and adds it as the `origin` remote for this local demo repo.

If you want the repo to be public, use this instead:

```powershell
gh repo create notification-settings-demo --public --source . --remote origin --description "Demo repo for stacked pull requests"
```

If GitHub says the repository name already exists, change `notification-settings-demo` to another name, for example:

```powershell
gh repo create notification-settings-demo-2 --private --source . --remote origin --description "Demo repo for stacked pull requests"
```

### Step 2B: Browser Alternative

Use this only if you do not want to use GitHub CLI.

1. Go to GitHub.
2. Create a new empty repository named `notification-settings-demo`.
3. Do not add a README, `.gitignore`, or license on GitHub.
4. Copy the repository URL.

Then come back to PowerShell and run this command. Replace `YOUR-USERNAME` with your GitHub username:

```powershell
git remote add origin https://github.com/YOUR-USERNAME/notification-settings-demo.git
```

### Step 4: Push All Demo Branches

Copy and paste:

```powershell
git push -u origin main notif-db notif-api notif-ui notif-cleanup
```

Now GitHub has the full stack:

```text
main -> notif-db -> notif-api -> notif-ui -> notif-cleanup
```

## Optional: Create Real GitHub PRs

Run these commands after the remote repo exists and all branches are pushed. These commands use GitHub CLI.

### PR 1: Database Layer

```powershell
gh pr create --base main --head notif-db --title "Add notification settings table" --body "Stack: 1/4. Next: notif-api."
```

GitHub should show:

```text
base: main
compare: notif-db
Files changed: db/migrations, app/models, tests
```

### PR 2: API Layer

```powershell
gh pr create --base notif-db --head notif-api --title "Add notification settings API" --body "Stack: 2/4. Depends on notif-db. Next: notif-ui."
```

GitHub should show:

```text
base: notif-db
compare: notif-api
Files changed: api route and API tests only
```

### PR 3: UI Layer

```powershell
gh pr create --base notif-api --head notif-ui --title "Add notification settings screen" --body "Stack: 3/4. Depends on notif-api. Next: notif-cleanup."
```

GitHub should show:

```text
base: notif-api
compare: notif-ui
Files changed: UI files only
```

### PR 4: Cleanup Layer

```powershell
gh pr create --base notif-ui --head notif-cleanup --title "Wire analytics and docs" --body "Stack: 4/4. Final cleanup layer."
```

GitHub should show:

```text
base: notif-ui
compare: notif-cleanup
Files changed: docs and analytics only
```

### Browser Alternative: Open PRs Manually

If you do not use GitHub CLI, open your GitHub repo in the browser and create four pull requests with these base and compare branches:

```text
PR 1: base main       compare notif-db
PR 2: base notif-db   compare notif-api
PR 3: base notif-api  compare notif-ui
PR 4: base notif-ui   compare notif-cleanup
```

## Optional: Fix Review Feedback In The Middle

Example: if review feedback changes the API branch, update `notif-api`, then rebase the branches above it.

```bash
git switch notif-api
# edit API files
git add api tests/api
git commit --amend --no-edit

git switch notif-ui
git rebase notif-api

git switch notif-cleanup
git rebase notif-ui

git push --force-with-lease origin notif-api notif-ui notif-cleanup
```

## Optional: GitHub `gh stack` Version

If your repository has access to GitHub's `gh stack` preview:

```bash
gh extension install github/gh-stack

gh stack init notif-db
# commit DB layer

gh stack add notif-api
# commit API layer

gh stack add notif-ui
# commit UI layer

gh stack add notif-cleanup
# commit cleanup layer

gh stack push
gh stack view
gh stack submit
```

## Recording Tip

Record the local PowerShell demo first. Then switch to the HTML presentation for the GitHub PR screen checks.
