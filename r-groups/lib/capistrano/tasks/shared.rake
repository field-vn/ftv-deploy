namespace :shared do

    desc "Create create shared folder"
    task :create do
        on roles(:web) do
        within linked_dirs do
            execute :mkdir, "-p .env"
            execute :mkdir, "-p storage/app/public/uploads"
            execute :mkdir, "-p storage/framework/cache"
            execute :mkdir, "-p storage/framework/sessions"
            execute :mkdir, "-p storage/framework/testing"
            execute :mkdir, "-p storage/framework/views"
            execute :mkdir, "-p storage/logs"
        end
        end
    end

end