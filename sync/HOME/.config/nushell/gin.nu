# https://www.nushell.sh/cookbook/git.html

export def "switch" [] {
    git branch | lines | str trim | where { |s| 
        let xx = $s | str substring 0..2
        $xx != "* "
    } | str join "\n" | fzf --preview "git show --color=always {}" | str trim | git switch $in
}

export def "status" [] {
    git status
}

export def "del_merged" [] {
    git branch --merged | lines | where ($it != "* master" and $it != "* main") | each {|br| git branch -D ($br | str trim) } | str trim
}

export def "committer" [] {
    git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | histogram committer merger | sort-by merger | reverse
}

# https://www.nushell.sh/cookbook/parsing_git_log.html
export def "log" [] {
    # git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | first 10
    git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD -n 25 | lines | split column "»¦«" commit subject name email date | upsert date {|d| $d.date | into datetime} | sort-by date | reverse
}

#
export def "branch" [] {
    git branch -v | lines | split column -r '\s+' | each {|e| {cur:$e.column1 name:$e.column2 hash:$e.column3 desc:($e | values | range 3.. | str join ' ') } }
}


