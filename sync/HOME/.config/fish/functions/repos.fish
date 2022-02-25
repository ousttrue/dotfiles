function repos
    ghq list | peco | read select_dir
    if [ $select_dir ]
        cd (ghq root)/$select_dir
    else
        echo "Not selected project"
    end
end
