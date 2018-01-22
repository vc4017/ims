for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
 if [[ "$(git log $branch --since="1 week ago" | wc -l)" -eq 0 ]]; then
   if [[ "$branch" =~ "origin/" ]]; then
     local_branch_name=$(echo "$branch" | sed 's/^origin\///')
     if [[ "$DRY_RUN" -eq 1 ]]; then
       echo "git push origin :$local_branch_name"
     else
       git push origin :$local_branch_name
     fi
   else
     if [[ "$DRY_RUN" -eq 1 ]]; then
       echo "git branch -D $branch"
     else
       git branch -D $branch
     fi
   fi
 fi
done