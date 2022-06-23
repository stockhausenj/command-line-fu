Cherry pick.

`git cherry-pick <commit_id>`

Interactive rebase.

`GIT_SEQUENCE_EDITOR=cat git rebase --interactive <commut_id>`

Oneline log with graph.

`log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --`

Change remote url.

`git remote set-url <remote> <new_url>`

Work with multiple branches simultaneously.

`git worktree add <other_branch> <path>`

Compare files between commits.

`git diff <commit_id_a> <commit_id_b> -- <file_path>`

Delete last commit but keep changes.

`git reset HEAD^`

Cat object types and content.

```
$ cat .git/refs/heads/master
251f6eaf41dbaca8e36d76aef5b5efc196687673

$ git cat-file -t 251f6eaf41dbaca8e36d76aef5b5efc196687673
commit

$ git cat-file -p 251f6eaf41dbaca8e36d76aef5b5efc196687673
tree 9bafb2837baef8fb28be29e71cf0a962ba1117a5
parent 2d4eb2f436cef7d0ca6f367b79119b1cc16219de
author Jay Stockhausen <jay.stockhausen@gmail.com> 1622520435 -0700
committer Jay Stockhausen <jay.stockhausen@gmail.com> 1622520435 -0700

mkdocs
```

View local only log of git command history. Useful if you get lost.

`git reflog`

Find commit that introduced bug binary search style.

```
git bisect start
```