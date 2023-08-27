local M = {}

function M.complete_for(args)
  while #args > 2 and args[2]:sub(1, 1) == "-" do
    table.remove(args, 2)
  end
  if #args == 2 then
    return nyagos.fields [[
          add                 fsck-objects        rebase
          add--interactive    gc                  receive-pack
          am                  get-tar-commit-id   reflog
          annotate            grep                relink
          apply               gui                 remote
          archimport          gui--askpass        remote-ext
          archive             gui--askyesno       remote-fd
          bisect              gui.tcl             remote-ftp
          bisect--helper      hash-object         remote-ftps
          blame               help                remote-http
          branch              http-backend        remote-https
          bundle              http-fetch          repack
          cat-file            http-push           replace
          check-attr          imap-send           request-pull
          check-ignore        index-pack          rerere
          check-mailmap       init                reset
          check-ref-format    init-db             rev-list
          checkout            instaweb            rev-parse
          checkout-index      interpret-trailers  revert
          cherry              log                 rm
          cherry-pick         ls-files            send-email
          citool              ls-remote           send-pack
          clean               ls-tree             sh-i18n--envsubst
          clone               mailinfo            shortlog
          column              mailsplit           show
          commit              merge               show-branch
          commit-tree         merge-base          show-index
          config              merge-file          show-ref
          count-objects       merge-index         stage
          credential          merge-octopus       stash
          credential-manager  merge-one-file      status
          credential-store    merge-ours          stripspace
          credential-wincred  merge-recursive     submodule
          cvsexportcommit     merge-resolve       submodule--helper
          cvsimport           merge-subtree       subtree
          cvsserver           merge-tree          svn
          daemon              mergetool           symbolic-ref
          describe            mktag               tag
          diff                mktree              unpack-file
          diff-files          mv                  unpack-objects
          diff-index          name-rev            update-index
          diff-tree           notes               update-ref
          difftool            p4                  update-server-info
          difftool--helper    pack-objects        upload-archive
          fast-export         pack-redundant      upload-pack
          fast-import         pack-refs           var
          fetch               patch-id            verify-commit
          fetch-pack          prune               verify-pack
          filter-branch       prune-packed        verify-tag
          fmt-merge-msg       pull                web--browse
          for-each-ref        push                whatchanged
          format-patch        quiltimport         worktree
          fsck                read-tree           write-tree]]
  end
  if args[#args]:sub(1, 1) == "-" then
    if args[2] == "commit" then
      return { "--amend", "-a", "--cleanup", "--dry-run" }
    end
  end
  return nil
end

return M
