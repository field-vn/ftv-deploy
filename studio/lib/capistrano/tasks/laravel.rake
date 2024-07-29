namespace :laravel do

  desc "Run Artisan migrate task"
  task :migrate do
    on roles(:web) do
      within release_path do
        execute :php, "artisan migrate --path=database/migrations", "--force"
      end
    end
  end

  desc "Run Artisan db:seed task"
  task :seed do
    on roles(:web) do
      within release_path do
        execute :php, "artisan db:seed"
      end
    end
  end

  desc "Run Artisan cache:clear task"
  task :clear_cache do
    on roles(:web) do
      within release_path do
        execute :php, "artisan cache:clear"
      end
    end
  end

  desc "Run Artisan config:clear task"
  task :clear_config do
    on roles(:web) do
      within release_path do
        execute :php, "artisan config:clear"
      end
    end
  end

  desc "Run Artisan clear-compiled & optimize task"
  task :optimize do
    on roles(:web) do
      within release_path do
        execute :php, "artisan clear-compiled"
        execute :php, "artisan optimize"
      end
    end
  end

  desc "Run Artisan restart queue"
  task :queue_restart do
    on roles(:web) do
      within release_path do
        execute :php, "artisan queue:restart"
      end
    end
  end

  desc "Run link storage"
  task :storage_link do
    on roles(:web) do
      within release_path do
        execute :php, "artisan storage:link"
      end
    end
  end

  desc "Create Storage directories & Set permissions task"
  task :permissions do
    on roles(:web) do
      within release_path do
        execute :chown, "-RH apache:apache storage"
        execute :chown, "-RH apache:apache bootstrap/cache"
        execute :chmod, "-R ug+rwx storage"
        execute :chmod, "-R ug+rwx bootstrap/cache"
        execute :chown, "-RH apache:apache public/uploads"
        execute :chmod, "-R ug+rwx public/uploads"
      end
    end
  end

end
