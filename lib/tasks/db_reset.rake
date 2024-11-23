namespace :db do
  desc "Drop, create, migrate, and seed the development database"
  task reset_dev: :environment do
    if Rails.env.development?
      ActiveRecord::Base.connection.execute <<-SQL
        SELECT pg_terminate_backend(pg_stat_activity.pid)
        FROM pg_stat_activity
        WHERE pg_stat_activity.datname = '#{ActiveRecord::Base.connection.current_database}'
          AND pid <> pg_backend_pid();
      SQL

      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task["db:seed"].invoke
    else
      puts "This task can only be run in the development environment."
    end
  end
end
