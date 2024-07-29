namespace :permissions do

  desc "Set correct permissions for all files and directories"
  task :set do
    on roles(:web) do
      within release_path do
        execute :sudo, :find, '.', '-type f -exec chmod 644 {} \;'
        execute :sudo, :find, '.', '-type d -exec chmod 755 {} \;'
      end
    end
  end

end
