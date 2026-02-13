import os
import subprocess
import requests
import sys
import argparse
from getpass import getpass
from urllib.parse import urlparse

# --- CONFIGURATION ---
# Define your services and their URLs here.
# You can add multiple URLs per service (e.g. for self-hosted instances).
SERVICE_CONFIG = {
    "gitlab": [
        "https://gitlab.oth-regensburg.de"
    ],
    "github": [
        "https://github.com",
    ]
}
# ---------------------

def get_domain_name(url):
    """Extracts 'gitlab.com' from 'https://gitlab.com' for folder naming."""
    return urlparse(url).netloc

def fetch_gitlab_repos(base_url, token):
    """Fetches all projects from a GitLab instance."""
    projects = []
    page = 1
    headers = {"PRIVATE-TOKEN": token}
    api_url = f"{base_url.rstrip('/')}/api/v4/projects"

    print(f"   📡 Connecting to GitLab API: {base_url}")

    while True:
        params = {
            "membership": "true",
            "per_page": 100,
            "page": page,
            "simple": "true"
        }

        try:
            r = requests.get(api_url, headers=headers, params=params)
            r.raise_for_status()
            data = r.json()
        except Exception as e:
            print(f"   ❌ Error fetching GitLab data: {e}")
            return [] # Return empty to allow script to continue to next service

        if not data:
            break

        for p in data:
            projects.append({
                "name": p['path_with_namespace'],
                "ssh_url": p['ssh_url_to_repo'],
                "domain": get_domain_name(base_url)
            })
        page += 1

    return projects

def fetch_github_repos(base_url, token):
    """Fetches all repositories from GitHub."""
    repos = []
    page = 1
    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/vnd.github.v3+json"
    }

    # Handle Public GitHub vs Enterprise GitHub API URLs
    if "github.com" in base_url:
        api_url = "https://api.github.com/user/repos"
    else:
        # Standard GHE API endpoint pattern
        api_url = f"{base_url.rstrip('/')}/api/v3/user/repos"

    print(f"   📡 Connecting to GitHub API: {base_url}")

    while True:
        params = {
            "type": "all",
            "per_page": 100,
            "page": page
        }

        try:
            r = requests.get(api_url, headers=headers, params=params)
            r.raise_for_status()
            data = r.json()
        except Exception as e:
            print(f"   ❌ Error fetching GitHub data: {e}")
            return []

        if not data:
            break

        for r_item in data:
            repos.append({
                "name": r_item['full_name'],
                "ssh_url": r_item['ssh_url'],
                "domain": get_domain_name(base_url)
            })
        page += 1

    return repos

def mirror_repo(repo, backup_root):
    """Clones or updates a single repo."""
    # Structure: ./backups/domain.com/group/project.git
    full_path = os.path.join(backup_root, repo['domain'], f"{repo['name']}.git")
    target_dir = os.path.dirname(full_path)

    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    if os.path.exists(full_path):
        print(f"   🔄 Updating: {repo['name']}")
        subprocess.run(["git", "-C", full_path, "remote", "update"],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    else:
        print(f"   📥 Cloning:  {repo['name']}")
        subprocess.run(["git", "clone", "--mirror", repo['ssh_url'], full_path],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Multi-Service Git Backup Tool")
    parser.add_argument("backup_dir", help="Root directory for backups")
    args = parser.parse_args()

    all_repos = []

    # Iterate over the configuration dictionary
    for service_type, urls in SERVICE_CONFIG.items():
        if not urls:
            continue

        print(f"\n--- Processing {service_type.upper()} ---")

        for url in urls:
            print(f"\n🔐 Authentication required for: {url}")
            token = getpass(f"   Enter Token for {url}: ")

            if not token:
                print("   ⚠️  Skipping due to empty token.")
                continue

            if service_type == "github":
                repos = fetch_github_repos(url, token)
            elif service_type == "gitlab":
                repos = fetch_gitlab_repos(url, token)
            else:
                print(f"   ⚠️  Unknown service type: {service_type}")
                continue

            print(f"   ✅ Found {len(repos)} repositories.")
            all_repos.extend(repos)

    if not all_repos:
        print("\n❌ No repositories found. Check your tokens and configuration.")
        sys.exit(0)

    print(f"\n🚀 Starting backup of {len(all_repos)} repositories to '{args.backup_dir}'...\n")

    for repo in all_repos:
        mirror_repo(repo, args.backup_dir)

    print("\n✨ All backups complete!")
